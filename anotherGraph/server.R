#setwd("/Users/kylegoodwin/INFO498F/final-project/")

library(dplyr)
library(shiny)
library(plotly)
source("UWrange.R")

shinyServer(function(input, output) {
    
    output$rangeUW <- renderPlotly({ 
      groupAverage(uw_salaries, input$slider[1], input$slider[2], input$year)
    })
    
  }
)