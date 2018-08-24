library(shiny)
library(readxl)
library(shinythemes)
library(tidyverse)
library(DT)

## geographic options, I guess theoretically, we could offer whatever the census API had, but that would mean we would need to have corresponding PUMS code.
geography <- c("National",
               "State",
               "County","Congressional District")
geographyvals <- c("us","state","county","congressional district")
names(geographyvals) <- geography

group <- c("Chinese", "Korean", "Japanese", "Indian", "Native Hawaiian")

topics <- c("Educational Attainment", 
            "Poverty")
topicvals <- c("edu", "pov")
names(topicvals) <- topics

est_edu <- c("Less than High School", "HS or GED", "BA or higher")
est_pov <- c("Overall Poverty", "Child in Poverty", "Senior in Poverty")
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("spacelab"),
  column(3, offset= 1,
         titlePanel("QuickStats"),
         
         selectizeInput(
           "group",
           "Select Groups (up to 3)",
           choices = group, multiple = TRUE, options = list(
             maxItems = 3,
             placeholder = "i.e. Vietnamese, Asian, US Average",
             onInitialize = I('function() { this.setValue(""); }'))),
         
         radioButtons("geo_choice", "Geography",
                      choices = geographyvals),
         
         conditionalPanel(condition = "input.geo_choice == 'us'",
                          checkboxGroupInput(
                            "checkGroup", label = h3("Select Estimates"),
                            choices = topics,
                            selected = 1
                          )),
        
        conditionalPanel(condition = "input.geo_choice != 'us'",
                         selectInput(
                         "topic_choice", 
                         "Select A Topic",
                         choices = topicvals),
                         conditionalPanel(condition = "input.topic_choice == 'edu'",
                                 radioButtons( "est", "Select An Estimate",
                                 choices = est_edu)),
                         conditionalPanel(condition = "input.topic_choice == 'pov'",
                                 radioButtons("est", "Select An Estimate",
                                 choices = est_pov)))),
         
  
  mainPanel(
    h1("AAPI Data QuickStats"),
    hr(),
    h3(em(textOutput("info"))),
    br()
)))
