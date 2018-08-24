library(shiny)
library(tidyverse)

shinyServer(function(input, output){
  selected <- reactiveValues()
  observe({
    selected$geography <- input$geo_choice
    selected$group <- input$group
    selected$estimate <- input$checkGroup
  })
  output$info <- renderText(({paste("Pulling data from AAPI Data Server", selected$geography, selected$group, selected$estimate)}))
})