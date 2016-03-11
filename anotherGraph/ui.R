library(shiny)
library(plotly)

shinyUI(fluidPage(
  #sidebarPanel(
    column(4,
           sliderInput("slider", label = h3("Salaries by Range"), min = 0, 
                       max = 2800000, value = c(50000, 250000))
    ),
    
    hr(),
    
    radioButtons("year", label = h3("Select Year"),
                 choices = list("2011" = 11, "2012" = 12, "2013" = 13, "2014" = 14), 
                 selected = 11
  #  )
    ),
    mainPanel(
      plotlyOutput("rangeUW")
    )
  )
)