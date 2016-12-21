
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("source.r")

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })
  
  output$showmap <- renderLeaflet({
    getId = which(getData$tag == input$stores)
    lng = getData$Response_X[1]
    lat = getData$Response_Y[1]
    zoom = 13
    getId = which(getData$tag == input$stores)
    getmap <- leaflet() %>% addTiles() %>%
              setView(lng, lat, zoom) %>%
              addMarkers(getData$Response_X[getId], getData$Response_Y[getId])
  })
  
  output$testGet <- renderText({
    print(input$stores)
  })
  
  output$showstores <- renderTable({
    getId = which(getData$tag == input$stores)
    print(getData[getId,])
  })

})
