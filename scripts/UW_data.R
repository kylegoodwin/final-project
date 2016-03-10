require(dplyr)
require(knitr)
require(magrittr)
require(plotly)
require(RColorBrewer)

#reads in the functions from the format file
#setwd("C:/info498f/final-project/scripts/")
#source("format.R")

#reads in the data and reformats it for data wrangling
#setwd("C:/info498f/final-project/data/")
#data <- read.csv("AnnualSalary.csv")
#clean_data <- getIntegerData(data)

#filters the data to show only UW employees
#UW_data <- filterUW(clean_data)

#creates a data frame that contains only the salaries and replaces all of the values of 0
#with NA, allowing for a column of averages to be added

wrangleData <- function(UW_data){
  df <- select(UW_data, contains("Sal"))
  df[df == 0] <- NA
  df$avg = apply(df,1,mean,na.rm=TRUE)
  
  #adds a new column that shows the average salary between 2011 and 2014
  UW_data <- mutate(UW_data, avg = round(df$avg, digits = 0))
  
  #creates a data frame of the salaries of only professors
  professor <- filter(UW_data, grepl("PROFESSOR", job_title))
  #professor <- rename(professor, "Average Professor Salary" = avg)
  
  #creates a data frame of the salaries of only lecturers
  lecturer <- filter(UW_data, grepl("LECTURER", job_title))
  #lecturer <- rename(lecturer, "Average Lecturer Salary" = avg)
  
  
  #creates a data frame of the salaries of only athletic coaches
  coach <- filter(UW_data, grepl("COACH", job_title))
  #coach <- rename(coach, "Average Coach Salary" = avg)
  
  
  #creates a data frame of the salaries of only the custodians
  custodian <- filter(UW_data, grepl("CUSTODIAN", job_title))
  #custodian <- rename(custodian, "Average Custodian Salary" = avg)
  
  
  #creates a data frame of everyone holding the title "president" including all vice, assistant, and 
  #associate presidents
  president <- filter(UW_data, grepl("PRESIDENT", job_title))
  #president <- rename(president, "Average President Salary" = avg)
  
  
  #creates a data frame of the salaries of nurses
  nurse <- filter(UW_data, grepl("NURSE", job_title))
  #nurse <- rename(nurse, "Average Nurse Salary" = avg)
  
  
  #creates a data frame that contains the salary of deans
  dean <- filter(UW_data, grepl("DEAN", job_title))
  #dean <- rename(dean, "Average Dean Salary" = avg)
  
  
  #creates a data frame that contains the salary of engineers
  engineer <- filter(UW_data, grepl("ENGINEER", job_title))
  #engineer <- rename(engineer, "Average Engineer Salary" = avg)
  
  
  
  #creates a dataframe that contains the average and maximum salaries for each general position
  job_title <- c("Professor", "Lecturer", "Coach", "Custodian", "President", "Nurse", "Dean", "Engineer")
  avg_salary <- c(mean(professor[["avg"]]), mean(lecturer[["avg"]]), mean(coach[["avg"]]), 
                       mean(custodian[["avg"]]), mean(president[["avg"]]), mean(nurse[["avg"]]),
                       mean(dean[["avg"]]), mean(engineer[["avg"]]))
  max_salary <- c(max(professor[["avg"]]), max(lecturer[["avg"]]), max(coach[["avg"]]), 
                       max(custodian[["avg"]]), max(president[["avg"]]), max(nurse[["avg"]]),
                       max(dean[["avg"]]), max(engineer[["avg"]]))
   return (jobs_data_frame <- data.frame(job_title, avg_salary, max_salary))

}


getAvgGraph <- function(data){
  jobs_data_frame <- wrangleData(data)
  
  #rearanges the data frame to be in descending order based on the avg_salary column
  avg_salary_graph <- arrange(jobs_data_frame, desc(avg_salary))
  
  #creates a bar graph showing the average salaries in each job type
  avg_graph <- plot_ly(avg_salary_graph, x = job_title, y = avg_salary, type = "bar", 
                       marker = list(color = brewer.pal(6, "PRGn"))) %>% 
    layout(title = "Average Salaries for Job Types at the University of Washington", xaxis = list(title = "Job Title"), yaxis = list(title = "Average Salary"))
  
  return(avg_graph)
  
}


getMaxGraph <- function(data){
  
  jobs_data_frame <- wrangleData(data)
  
  #rearanges the job data to be in descending order based on the max_salary_column
  max_salary_graph <- arrange(jobs_data_frame, desc(max_salary))
  
  #creates a bar graph that shows the maximum salary in each job type
  max_graph <- plot_ly(max_salary_graph, x = job_title, y = max_salary, type = "bar", 
                       marker = list(color = brewer.pal(6, "PRGn"))) %>% 
    layout(title = "Maximum Salaries for Job Types at the University of Washington", xaxis = list(title = "Job Title"), yaxis = list(title = "Maximum Salary"))
  
  return(max_graph)
  
}

                    



 

