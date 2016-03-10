#Kyle Goodwin
#INFO 498f
#Final Project

#Import web and plotting libraries
library(shiny)
library(plotly)

#Create UI for web app
shinyUI(navbarPage('Washington State Budget: Salary Spending', theme = "bootstrap.css",
                   
              #First tab, overview  ---------------------------------------------------------  
              tabPanel('State Overview',
  
                sidebarLayout(
                  sidebarPanel(
                    
                    h1("State Overview"),
                    p("Select a year from the dropdown menu to see an overview of salary spending
                      during that time. Select which departments you would like to compare in the 
                      bar graph."),
                    
                    #Select Year for comparisons
                    selectInput("year", label = h3("Year"), 
                                choices = list("2014" = 'Sal2014', "2013" = 'Sal2013', "2012" = 'Sal2012',
                                               "2011" = 'Sal2011'), 
                                selected = 'Sal2014'),
                    
                    #Select department for comparison
                    checkboxGroupInput("departments", label = h3("Departments"), 
                                       choices = list("UW" = "University of Washington", "Social/Health Services" = "Social and Health Services",
                                                      "Transportation" = "Transportation", "Corrections" = "Corrections",
                                                      "WSU" = "Washington State University"),
                                       selected = list("University of Washington","Social and Health Services","Transportation",
                                                       "Washington State University","Corrections"))
                  ),
                
                
                #Output Spending comparison piechart
                mainPanel(
                  h2("Total Spending: "),
                  h1(textOutput("overview_text")),
                  h2("Salary Spending by Department"),
                  plotlyOutput("bar_chart"),
                  p(textOutput("bar_text")),
                  h2("Percentage of State Salary Spending"),
                  plotlyOutput("pie_chart")
                  )
                )
                ),
              
              #Second Tab --------------------------------------------------------- 
              tabPanel('UW Overview',
                sidebarLayout(
                  sidebarPanel(
                    h1("UW Overview")
                  ),
                  mainPanel(
                    plotlyOutput("avg_graph"),
                    plotlyOutput("max_graph")
                  ) 
                )
              ),
              #Third Tab
              tabPanel('UW Analysis',
                titlePanel("University of Washington Analysis")
                       ),
              
              #Fourth tab
              tabPanel('About')
                   
                   
         )
        )
