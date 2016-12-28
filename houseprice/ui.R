library(shiny)
library(leaflet)
library(ggvis)

source("readdata.R")

vars <- colnames(houseprice)

navbarPage("house price",
  tabPanel("new movie test",
    fluidPage(
      h2("new page"),
      fluidRow(
        column(3,
        wellPanel(
               sliderInput("totalC", " Total energy consumption in billion BTU in given year",
                           min = 2010, max = 2014, step = 1, value = 2010),
               sliderInput("totalP", "Total energy production in billion BTU in given year", 
                           min = 2010, max = 2014, step = 1, value = 2010)        
               )),
        column(9, 
               plotOutput("plot1")
      )
    )
  )),
                    
  tabPanel("Interactive map",
    leafletOutput("myMap", width="100%", height="1000"),
    absolutePanel(fixed = TRUE, draggable = TRUE, 
                  top = 200, left = 20, right = "auto", 
                  bottom = "auto", width = 330, height = "auto",
                  h2("Feature Selects"),
                  selectInput("feature", "Features", vars[3:7]),
                  sliderInput("bins", "",
                              min = 0, max = 100, value = 25),
                  plotOutput("histCentile", height = 200)
    )
  ),
  
  tabPanel("K means",
    selectInput("featureX", "x Features", vars[3:7]),
    selectInput("featureY", "Y Features", vars[3:7]),
    sliderInput("clusters", "",
               min = 1, max = 10, value = 5),
    plotOutput("kmeans")
  ),
  tabPanel("render table",
    fluidPage(
     fluidRow(
       column(12,
              h2("Shiny Table Demo"),
              fluidRow(
                column(4,
                       h3("Inputs"),
                       hr(),
                       fluidRow(
                         column(6, selectInput("dataset", "Data:", 
                                               c("rock", "pressure", "cars", "mock"))),
                         column(6,numericInput("obs", "Rows:", 6))
                       ),
                       br(),
                       fluidRow(
                         column(6, checkboxGroupInput("format", "Options:",
                                                      c("striped", "bordered", "hover"))),
                         column(6, radioButtons("spacing", "Spacing:",
                                                c("xs", "s", "m", "l"), "s"))
                       ),
                       br(),
                       fluidRow(
                         column(6, selectInput("width", "Width:",
                                               c("auto", "100%", "75%",
                                                 "300", "300px", "10cm"), "auto")),
                         column(6, uiOutput("pre_align"))
                       ),
                       br(),
                       fluidRow(
                         column(6, radioButtons("rownames", "Include rownames:",
                                                c("T", "F"), "F", inline=TRUE)),
                         column(6, radioButtons("colnames", "Include colnames:",
                                                c("T", "F"), "T", inline=TRUE))
                       ),
                       br(),
                       fluidRow(
                         column(6, selectInput("digits", "Number of decimal places:",
                                               c("NULL", "3", "2", "0", "-2", "-3"))),
                         column(6, selectInput("na", "String for missing values:",
                                               c("NA", "missing", "-99"), "NA"))
                       )
                ),
                column(7, offset=1,
                       h3("Table and Code"),
                       br(),
                       tableOutput("view"),
                       br(),
                       h4("Corresponding R code:"),
                       htmlOutput("code")
                )
              )
       )
     )
    )           
  )
)