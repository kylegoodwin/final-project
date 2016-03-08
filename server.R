#Kyle Goodwin
#INFO 498f
#Final Projects

#Read in data
setwd("/Users/kylegoodwin/INFO498F/final-project/")
salaries <- read.csv("data/AnnualSalary.csv")
source("scripts/format.R")

#Format data, take out the commas, read strings as integers
salaries<- getIntegerData(salaries)
uw_salaries <- filterUW(salaries)
grouped <- summarizeWa(salaries)

pie(grouped$total)

#Start shiny server
shinyServer(function(input, output) {
  
  #Output a bar graph for the site
  output$bar_graph <- renderPlotly({
    
    
  })
  
  #Output a scatterplot for the site
  output$scatter <- renderPlotly({ 
  })
})