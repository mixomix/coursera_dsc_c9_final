#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
 
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Simple stock market analysis tool :)"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("index_show", "Pick Index(s) to display:",
                         c("DAX",
                           "SMI",
                           "CAC", "FTSE" ), selected =c("DAX","SMI")),
      
      h4("Moving average Indicator:"),
      checkboxInput("show_MA", "Show Moving Average", value = TRUE),
       sliderInput("MA_range",
                   "Moving average size:",
                   min = 1,
                   max = 100,
                   value = 50),
      checkboxGroupInput("MA_index_name", "Index to average:",
                         c("DAX",
                           "SMI",
                           "CAC", "FTSE" ),selected =c("DAX"))
    ),
    # Show a plot of the generat  ed distribution
    mainPanel(
      plotOutput("distPlot"),
      a(href="https://mixomix.github.io/coursera_dsc_c9_final/Docs.html", "Documentation here!")
    )
  )
))
