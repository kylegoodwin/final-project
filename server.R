#Kyle Goodwin
#INFO 498f
#Final Projects

#Read in data
setwd("/Users/kylegoodwin/INFO498F/final-project/")
salaries <- read.csv("data/AnnualSalary.csv")
source("scripts/format.R")
source("scripts/state-level-visualization.r")
source("scripts/UW_data.r")

#Format data, take out the commas, read strings as integers
salaries<- getIntegerData(salaries)
uw_salaries <- filterUW(salaries)

#Start shiny server
shinyServer(function(input, output) {
  
  #Output a bar graph for the site
  output$pie_chart <- renderPlotly({
    grouped <- summarizeWa(salaries,input$year)
    pieChart(grouped$total)
  })
  
  #Output a scatterplot for the site
  output$bar_chart <- renderPlotly({ 
    grouped <- summarizeWa(salaries,input$year)
    bar_data <- getBarData(grouped,input$departments)
    barChart(input$departments,bar_data)
    
  })
  
  output$bar_text <- renderText({
    getBarText()
  })
  
  output$overview_text <- renderText({
    paste0("$",getTotalSpending(salaries,input$year))
  })
  
  output$max_graph <- renderPlotly({
    getMaxGraph(salaries)
    
  })
  
  output$avg_graph <- renderPlotly({
    getAvgGraph(salaries)
  })
  
  
  
  
})