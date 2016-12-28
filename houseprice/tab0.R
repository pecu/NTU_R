output$plot1 <- renderPlot({
  TabletempIdC = 2004
  TabletempIdP = 1999
  inputc = input$totalC - TabletempIdC
  inputp = input$totalP - TabletempIdP
  x = gdp[,inputc]
  y = gdp[,inputp]
  plot(x,y)
})

