library(shiny)
library(datasets)

vars <- colnames(houseprice)
mock <- data.frame(v1 = c(    1,    2,    NA,   9,   NaN,   7 ),
                   v2 = c(  "a",  "b",   "c", "d",   "e",  NA ),
                   v3 = c( TRUE, TRUE, FALSE,  NA, FALSE, TRUE)) 
row.names(mock) <- c("uno", "dos", "tres", "cuatro", "cinco", "seis")



function(input, output, session) {

  output$plot1 <- renderPlot({
    x = gdp[, (input$totalC - 2004)]
    y = gdp[, (input$totalP - 1999)]
    plot(x,y)
  })
  
  
  #source('tab0.R', local=TRUE)
  source('tab1.R', local=TRUE)
  source('tab2.R', local=TRUE)
  source('tab3.R', local=TRUE)
  
}
