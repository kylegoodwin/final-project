#Kyle Goodwin
#INFO 498f
#Final Projects

#Read in data
#setwd("/Users/kylegoodwin/INFO498F/final-project/")
salaries <- read.csv("data/AnnualSalary.csv")
source("scripts/format.R")
source("scripts/state-level-visualization.r")
source("scripts/UW_data.R")

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
  
  #Get description text for Wa Bar graph
  output$bar_text <- renderText({
    getBarText()
  })
  
  #Get overview text for WA
  output$overview_text <- renderText({
    paste0("$",getTotalSpending(salaries,input$year))
  })
  
  #Get UW salary type comparison based on input type
  output$uw_bar_graph <- renderPlotly({
    returnBar(salaries,input$choice)
    
  })
  
  #Get proper summary for above
  output$uw_bar_summary <- renderText({
    returnSummary(input$choice)
  })
  
  #Get line plot for UW overview
  output$uw_line_graph <- renderPlotly({
    getLineGraph(uw_salaries)
  })
  
  #Get line plot for UW overview
  output$uw_line_text <- renderText({
    lineGraphSummary()
  })
  
  #Get total uw spending
  output$uw_total <- renderText({
    paste0("$",getTotalSpending(uw_salaries,input$year_uw))
  })
  
  output$sal_compare_text <- renderText({
    m <- compareToTop(uw_salaries,input$first_name,input$last_name)
    paste0(m,"x More than your favorite professor")
  })
  
  #Get UW salary type comparison based on input type
  output$sal_compare_graph <- renderPlotly({
    getComparisonGraph(uw_salaries,input$first_name,input$last_name)
    
  })
  
  
 
})