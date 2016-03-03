#Kyle Goodwin
#INFO 498f
#Final Projects

#Read in data

#Start shiny server
shinyServer(function(input, output) {
  
  #Output a bar graph for the site
  output$bar_graph <- renderPlotly({
    
    
  })
  
  #Output a scatterplot for the site
  output$scatter <- renderPlotly({ 
  })
})