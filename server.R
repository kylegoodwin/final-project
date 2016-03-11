#Kyle Goodwin and Conor Reiland
#INFO 498f
#Final Project - Washington Salary Comparison Tool

#Read in data
#setwd("/Users/kylegoodwin/INFO498F/final-project/")
salaries <- read.csv("data/AnnualSalary.csv")

#This file contains functions that format the data in a better way
source("scripts/format.R")

#This file contains the state-level graphs
source("scripts/state-level-visualization.r")

#This file contains functions that manipulate the data for use at a UW-wide level
source("scripts/UW_data.R")

#Format data, take out the commas, read strings as integers
salaries<- getIntegerData(salaries)
uw_salaries <- filterUW(salaries)


#Start shiny server
shinyServer(function(input, output) {
  
  #State tab outputs -----------------
  #Output a bar graph for the site
  output$pie_chart <- renderPlotly({
    grouped <- summarizeWa(salaries,input$year)
    pieChart(grouped$total)
  })
  
  #Output a bargraph for the site
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
  
  #UW tab outputs ---------------------------------
  #Get UW salary type comparison based on input type
  output$uw_bar_graph <- renderPlotly({
    returnBar(salaries,input$choice)
    
  })
  
  #Get proper summary for uw salary comparison
  output$uw_bar_summary <- renderText({
    returnSummary(input$choice)
  })
  
  #Get line plot for UW overview
  output$uw_line_graph <- renderPlotly({
    getLineGraph(uw_salaries)
  })
  
  #Get line plot text
  output$uw_line_text <- renderText({
    lineGraphSummary()
  })
  
  #Get total uw spending
  output$uw_total <- renderText({
    paste0("$",getTotalSpending(uw_salaries,input$year_uw))
  })
  
  #Salary comparison tab ------------------------------
  #Display how many more times The head coach salary is
  
  output$sal_compare_text <- renderText({
    m <- compareToTop(uw_salaries,input$first_name,input$last_name)
    paste0(m,"X More than ",input$first_name," ",input$last_name)
  })
  
  #Get UW salary type comparison based on input type
  output$sal_compare_graph <- renderPlotly({
    getComparisonGraph(uw_salaries,input$first_name,input$last_name)
    
  })
  
  #Display information about pie graph
  output$pie_text <- renderText({
    getPieText()
  })
  
  output$activeTab <- reactive({
    return(input$tab)
  })
  outputOptions(output, 'activeTab', suspendWhenHidden=FALSE)

})