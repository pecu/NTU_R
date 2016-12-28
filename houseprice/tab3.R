# tab page 3 #
source("check_valid.R", local=TRUE)
source("code_printing.R", local = TRUE)

datasetInput <- reactive({
  switch(input$dataset,
         "rock" = rock,
         "pressure" = pressure,
         "cars" = cars,
         "mock" = mock)
})

# Dynamically create the `align` options, so that it displays
# three options with the number of columns of the current
# dataset selected (+1 for the row.names if `rownames`=TRUE)
output$pre_align <- renderUI({
  choices <- c("NULL", "?", "c", "l")
  size <- { 
    if (as.logical(input$rownames)) ncol(datasetInput())+1 
    else ncol(datasetInput()) }
  choices <- c(choices, 
               paste(sample(c("l", "c", "r", "?"), size = size, 
                            replace = TRUE), collapse = ""),
               paste(sample(c("l", "c", "r", "?"), size = size, 
                            replace = TRUE), collapse = ""),
               paste(sample(c("l", "c", "r", "?"), size = size, 
                            replace = TRUE), collapse = ""))
  selectInput("align", "Column alignment:", choices, "NULL")
})

# Display the resulting table
output$view <- renderTable({
  head(datasetInput(), n = input$obs)}, 
  striped = striped,
  bordered = bordered,
  hover = hover,
  spacing = spacing,
  width = width,
  rownames = rownames,
  colnames = colnames,
  align = align,
  digits = digits,
  na = na
)

# Display the corresponding code for the user to generate
# the current table in their own Shiny app
output$code <- renderText({
  paste0( "in <strong>ui.R</strong>: "    , 
          "<br><code>tableOutput('tbl')</code><br><br>",
          "in <strong>server.R</strong>: ", 
          "<br><code>output$tbl <- ", 
          "renderTable({ head( ", dataset(), 
          ", n = ", obs(), " )}", 
          striped_code(), bordered_code(), 
          hover_code(), spacing_code(),
          width_code(), align_code(),
          rownames_code(), colnames_code(), 
          digits_code(), na_code(),
          ")&nbsp;&nbsp;</code>"
  )
})