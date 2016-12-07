
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(stats)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

  output$randnumber <- renderPlot({
    n = input$bins
    getmean = input$mean
    getvar = input$var
    getnum = rnorm(n, mean = getmean, sd = getvar^0.5)
    
    plot(getnum)

    
  })
})
