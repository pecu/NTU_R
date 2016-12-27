library(shiny)
library(leaflet)
source("readdata.R")

vars <- colnames(houseprice)

navbarPage("house price",
           
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
  )
)