library(shiny)

vars <- colnames(houseprice)

function(input, output, session) {
  
  output$histCentile <- renderPlot({
    id   <- which( vars == input$feature )
    x    <- houseprice[, id]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  output$myMap <- renderLeaflet({
      leaflet() %>% addTiles() %>%
      setView(lng = houseprice$long[1], lat = houseprice$lat[1], zoom = 11)
  })

  # This observer is responsible for maintaining the circles and legend,
  # according to the variables the user has chosen to map to color and size.
  observe({
      id   <- which( vars == input$feature )
      col  <- palette()
      
      radius <- ifelse(houseprice[, id] >= mean(houseprice[, id]), 300, 30)
    
      leafletProxy("myMap", data = houseprice) %>%
      clearShapes() %>%
      addCircles(~long, ~lat, radius=radius,
                 stroke=FALSE, fillOpacity=0.4, fillColor=col[id])
  })
  
  selectedData <- reactive({
    idx   <- which( vars == input$featureX )
    idy   <- which( vars == input$featureY )
    houseprice[, c(idx, idy)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$kmeans <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
}
