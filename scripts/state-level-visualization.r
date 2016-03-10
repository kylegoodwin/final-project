#State Level Trends Visualization
require(dplyr)
require(plotly)
library(RColorBrewer)

# This function creates a pie chart, showing the distribution of salary spending for 
# each department in washington state
pieChart <- function(data){
  
  #Format data Properly
  ds <- data.frame(labels = c("All Others", "University of Washington", "Social and Health Services","Transportation","Corrections","Washington State University"),
                   values = data)
  
  #Set appropriate colors
  m <- list(colors = list("gray","purple","gold","green","red","crimson"))
  
  #Change font color to white
  f <- list(color = "white")
  
  #Return the plot
  return (plot_ly(ds, labels = labels, values = values, type = "pie", marker = m,insidetextfont = f) %>% 
    layout(title = "", margin = list(t = 50)))
  
}

# This function creates a bar chart showing the distribution of
# salary values by department 
barChart <- function(xvalues,yvalues){

  
  p <- plot_ly(
    x = xvalues,
    y = yvalues,
    name = "Dept Salaries",
    type = "bar",
    marker = list(color = brewer.pal(6, "PRGn"))
  ) %>% layout(xaxis = list(title="",tickangle = 0), yaxis = list(title="Salary Spending"))
  
  return (p)
  
}

getBarText <- function(){
  return("This bar chart allows you visually compare the salary spending of each department
         of the State of Washington, allowing you easily see how much larger the University
         of Washington’s salary budget is than the rest of the State. Because UW’s salary spending
         is such a large part of the total State budget, we believe it is important for people to be
         able to see how this money is allocated. ")
}


