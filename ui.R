#Kyle Goodwin and Conor Reiland
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
                  plotlyOutput("pie_chart"),
                  p(textOutput("pie_text"))
                  )
                )
                ),
              
              #Second Tab --------------------------------------------------------- 
              tabPanel('UW Overview',
                sidebarLayout(
                  sidebarPanel(
                    h1("UW Overview"),
                    #Select Year for comparisons
                    selectInput("year_uw", label = h3("Year"), 
                                choices = list("2014" = 'Sal2014', "2013" = 'Sal2013', "2012" = 'Sal2012',
                                               "2011" = 'Sal2011'), 
                                selected = 'Sal2014'),
                    
                    radioButtons("choice", label = h3("Salary Statistic"),
                                 choices = list("Average" = 1, "Maximum" = 2), 
                                 selected = 1)
                  ),
                  mainPanel(
                    h2("Total UW Salary Spending: "),
                    h1(textOutput("uw_total")),
                    plotlyOutput("uw_bar_graph"),
                    p(textOutput("uw_bar_summary")),
                    h2("Trends in Salary Spending:"),
                    plotlyOutput("uw_line_graph"),
                    p(textOutput("uw_line_text"))
                    
                  ) 
                )
              ),
              #Third Tab
              tabPanel('UW Salary Comparison',
                       sidebarLayout(
                         sidebarPanel(
                           h1("Comparison Tool"),
                           p("See how much your favorite professor makes compared to the head 
                             football coach."),
                           h2("UW Employee Name"),
                           textInput("first_name", label = h3("First Name"), value = "David"),
                           textInput("last_name", label = h3("Last Name"), value = "Stearns")
                         ),
                         mainPanel(
                           h2("The head football coach makes:"),
                           h2(textOutput("sal_compare_text")),
                           plotlyOutput("sal_compare_graph")
                           
                         ) 
                       )
              ),
              
              #Fourth tab - About --------------------------------------------------
              tabPanel('About',
                     sidebarLayout(
                       sidebarPanel(
                         tags$img(src = "https://environment.uw.edu/wp-content/themes/coenv-wordpress-theme/assets/img/logo-1200x1200.png", width = "90%"),
                         h2("Contact:"),
                         p("Kyle Goodwin: kjgood1@uw.edu"),
                         p("Conor Reiland: creiland@uw.edu")
                         ),
                       mainPanel(
                         h2("Washington State Salaries: Why should you care?"),
                         p("The data used throughout this site is from Washington State’s Office of Financial Management,
and can be found at fiscal.wa.gov. The data we used gave us information on salaries from 2011 to 2014 in Washington State.
There were also other categories in the data set such as employee name, agency title and job title. With the salaries and 
other information there were a lot of ideas and questions that could have been answered. We as a group wanted to see exactly
how these salaries compared to one another from the different departments we have in this state. We showed this in a couple
different visual representations. We dug even further and decided to analyze and show a visual representation of just UW salaries
because we were curious on how the salaries matched with one another to the school we attend at. In conclusion, there are a lot of
jobs in Washington State and at the University of Washington and we visually wanted to see what these categorized salaries looked 
like when they are put up next to each other."),
                         h2("Frame:"),
                         p("We noticed that the way this data was displayed on the fiscal.wa.gov site was not optimal for your typical college student
                           or average Washington tax payer. On their site, you were able to see just the raw data, but no insights or comparisons that
                           make the data meaningful. We wanted to improve the way a user interacts with this data to make it more meaningful."),
                         h2("Results:"),
                         p("The data shows how the UW salary spending is the largest single part of the Washington State salary spending,
and how although the average UW employee with the title “President” earns more than the average athletics coach, the head football coach
has by far the highest salary of any employee at UW and even in the state. Coach Sarkisian earned 33 times the average professor at UW and
52 times the average engineer. This shows a disparity between the amount of schooling and hard work necessary in each field and the salaries
of employees in those fields."),
                         h2("Important Notes:"),
                         p(" All data used is from 2011-2014, as new data is not currently available. This was a final project for 
                           Mike Freeman's INFO 498f course at the University of Washington.")
                           
                         ) 
                       )
                       )
                   
                   
         )
        )
