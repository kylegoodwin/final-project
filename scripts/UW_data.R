require(dplyr)
require(knitr)
require(magrittr)
require(plotly)
require(RColorBrewer)

getAverages <- function(UW_data){
  df <- select(UW_data, contains("Sal"))
  df[df == 0] <- NA
  df$avg = apply(df,1,mean,na.rm=TRUE)
  
  return (mutate(UW_data, avg = round(df$avg, digits = 0)))
}

wrangleData <- function(UW_data){
  
  #adds a new column that shows the average salary between 2011 and 2014
  UW_data <- getAverages(UW_data)
  
  #creates a data frame of the salaries of only professors
  professor <- filter(UW_data, grepl("PROFESSOR", job_title))
  
  #creates a data frame of the salaries of only lecturers
  lecturer <- filter(UW_data, grepl("LECTURER", job_title))
  
  #creates a data frame of the salaries of only athletic coaches
  coach <- filter(UW_data, grepl("COACH", job_title))
  
  #creates a data frame of the salaries of only the custodians
  custodian <- filter(UW_data, grepl("CUSTODIAN", job_title))
  
  #creates a data frame of everyone holding the title "president" including all vice, assistant, and 
  #associate presidents
  president <- filter(UW_data, grepl("PRESIDENT", job_title))
  
  #creates a data frame of the salaries of nurses
  nurse <- filter(UW_data, grepl("NURSE", job_title))
  
  #creates a data frame that contains the salary of deans
  dean <- filter(UW_data, grepl("DEAN", job_title))
  
  #creates a data frame that contains the salary of engineers
  engineer <- filter(UW_data, grepl("ENGINEER", job_title))
  
  
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
    layout(title = "", xaxis = list(title = "Job Title"), yaxis = list(title = "Average Salary"))
  
  return(avg_graph)
  
}

avgBarSummary <- function(){
  return("This bar graph shows the average salary from 2011 to 2014 of employees of the University of Washington. 
          For the sake of clarity, the President and Dean values refer to anyone with the title President or Dean, 
          including all associate, assistant, and vice presidents and deans. The graph clearly shows that the average 
          salary of employees with the title President earn almost twice as much as everyone else. Interestingly, 
          as shown by the bar graph, the average custodian earns more than than the average lecturer at UW. Also, 
          the average athletic coach earns more than both the average engineer and average nurse. ")
}


getMaxGraph <- function(data){
  
  jobs_data_frame <- wrangleData(data)
  
  #rearanges the job data to be in descending order based on the max_salary_column
  max_salary_graph <- arrange(jobs_data_frame, desc(max_salary))
  
  #creates a bar graph that shows the maximum salary in each job type
  max_graph <- plot_ly(max_salary_graph, x = job_title, y = max_salary, type = "bar", 
                       marker = list(color = brewer.pal(6, "PRGn"))) %>% 
    layout(title = "", 
           xaxis = list(title = "Job Title"), yaxis = list(title = "Maximum Salary"))
  
  return(max_graph)
  
}

maxBarSummary <- function(data){
  return("This bar graph shows the value of the highest salary in each type of job at the University of 
          Washington. Shockingly, the highest paid athletic coach (Sarkisian) earns nearly five times more 
          than the president of the university. The salaries of each of the other job types pail in comparison 
          to the maximum coach salary. Besides the obvious disparity between the coach salary and the rest of 
          the salaries, the remainder of the bars on the graph remain largely unchanged in comparison to one another. ")
}

getLineGraph <- function(data){
  
  UW_data <- data
  
  total_2011 <- sum(select(UW_data, Sal2011))
  total_2012 <- sum(select(UW_data, Sal2012))
  total_2013 <- sum(select(UW_data, Sal2013))
  total_2014 <- sum(select(UW_data, Sal2014))
  
  year <- c(2011, 2012, 2013, 2014)
  total_salary_spending <- c(total_2011, total_2012, total_2013, total_2014)
  
  total_salary_df <- data.frame(year, total_salary_spending)
  
  line_graph <- plot_ly(total_salary_df, x =  year, y = total_salary_spending, name = "Total Salary Spending at the University of Washington", 
          line = list(color = rgb(133/255,117/255,158/255), shape = "spline", smoothing = 1.3, width = 5), 
          marker = list(color = rgb(197/255, 189/255, 104/255), size = 15)) %>% 
          layout(title = "", 
                 xaxis = list(title = "Year"), yaxis = list(title = "Amount Spent of Salaries"))
  
  return(line_graph)
}

lineGraphSummary <- function(){
  return("The line graph above shows the an upward trend in the state's spending on salaries. 
          Starting at about $2 billion, the spending increases by about $100 million each year, 
          ending at over $2.3 billion in 2014. ")
}

getHighestPaid <- function(data, yearname){
  data <- select_(data, "employee_name", "job_title", yearname) %>% rename_("salary" = yearname) %>% 
    arrange(desc(salary))
  
  top <- top_n(data, 1, salary)
  
  return(top)
}

returnBar <- function(data,num){
  if(num == 1){
    return (getAvgGraph(data))
  }else{
    return (getMaxGraph(data))
  }
}

returnSummary <- function(num){
  if(num == 1){
    return (avgBarSummary())
  }else{
    return (maxBarSummary())
  }
}


#UW analyisis ----------------------
filterPerson <- function(data,firstname,lastname){
  
  name = paste0(toupper(lastname),", ",toupper(firstname))
  regex = paste0("^",name)
  return( filter(data, grepl(regex,employee_name)) %>% getAverages() %>% top_n(1,avg)) 
  
}

getPersonSalary <- function(data,firstname,lastname){
  data <- filterPerson(data,firstname,lastname)
  return(data$avg[1])
}

compareToTop <- function(data,firstname,lastname){
  sark <- getPersonSalary(data,"STEPHEN","SARKISIAN")
  person <- getPersonSalary(data,firstname,lastname)
  
  return(round(sark/person,digits=0))
}

#Make graph comparing the salary of an employee to top salary
getComparisonGraph <- function(data, firstname, lastname){
  
  person_salary <- getPersonSalary(data, firstname, lastname)
  sark_salary <- getPersonSalary(data, "Stephen", "Sarkisian")
  Name <- c(paste(firstname, lastname, sep = " "), "Sarkisian")
  Salary <- c(person_salary, sark_salary)
  
  df <- data.frame(Name, Salary)
  
  #creates a bar graph showing the average salaries in each job type
  sarkComparisonGraph <- plot_ly(df, x = Name, y = Salary, type = "bar", 
                                 marker = list(color =  list(rgb(133/255,117/255,158/255),rgb(197/255, 189/255, 104/255))))
  
  return(sarkComparisonGraph)
}
