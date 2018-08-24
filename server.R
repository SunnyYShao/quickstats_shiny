library(shiny)
library(tidyverse)

shinyServer(function(input, output){
  selected <- reactiveValues()
  observe({
    selected$geography <- input$geo_choice
    selected$group <- input$group
    selected$checkGroup <- input$checkGroup
    selected$topic <- input$topic_choice
    selected$est <- input$est
  })
  output$info <- renderText(({paste("Pulling data from AAPI Data Server", 
                                    selected$geography, 
                                    selected$group, 
                                    selected$checkGroup,
                                    selected$topic_choice,
                                    selected$est)}))
})