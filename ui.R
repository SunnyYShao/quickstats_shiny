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
topics <- c("Educational Attainment", "Poverty", "Median Household Income")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("spacelab"),
  column(3, offset= 1,
         titlePanel("QuickStats"),
         radioButtons("geo_choice", "Geography",
                      choices = geographyvals),
         conditionalPanel(condition = "input.geo_choice" == 'us',
                          selectizeInput(
                            "group",
                            "Select Groups (up to 3)",
                            choices = group, multiple = TRUE, options = list(
                              maxItems = 3,
                              placeholder = "i.e. Vietnamese, Asian, US Average",
                              onInitialize = I('function() { this.setValue(""); }'))),
                          checkboxGroupInput(
                            "checkGroup", label = h3("Select Estimates"),
                            choices = topics,
                            selected = 1
                          ))),
  
  mainPanel(
    h1("AAPI Data QuickStats"),
    hr(),
    h3(em(textOutput("info"))),
    br()
    #h5(dataTableOutput("acs"))
  )
)
)
