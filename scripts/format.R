#Kyle Goodwin
#This file Manipulate Data to make it more easily visualized
require(dplyr)


#This function changes the salaries from strings with commas to 
#integers for easier sorting and manipulation
getIntegerData <- function(data){
  data <- rename(data, Sal2013 = Sal20131)
  data <- rename(data, Sal2012 = Sal20121)
  data <- rename(data, Sal2011 = Sal20111)
  
  data$Sal2011 <- as.numeric(gsub(",", "", data$Sal2011))
  data$Sal2012 <- as.numeric(gsub(",", "", data$Sal2012))
  data$Sal2013 <- as.numeric(gsub(",", "", data$Sal2013))
  data$Sal2014 <- as.numeric(gsub(",", "", data$Sal2014))
  
  return (data)
  
}

#This function filters the data to display only salaries related to UW
filterUW <- function(data){
  data <- filter(data, Agency_Title == "University of Washington")
  
  return(data)
  
}


#This function will summarize the way each agency in the state of washington spends money
#for kyles visualizaion
summarizeWa <- function(data,yearname){
  
  #Filter year for changing data interactivly
  data <- filterYear(data,yearname)
  
  grouped_summary <- group_by(data,Agency_Title) %>% summarise(total = sum(salaries))
  wa_total = sum(grouped_summary$total)
  
  big <- filter(grouped_summary, total/wa_total >= .05)
  others <- filter(grouped_summary, total/wa_total < .05)
  
  other_total <- sum(others$total)
  
  others <- slice(others, 1)
  others$total[1] <- other_total
  others$Agency_Title[1] <- "Other Agencies"
  
  grouped_summary <- bind_rows(big,others) %>% arrange(desc(total))

  return(grouped_summary)
  
}

#This function selects the column of salaries from a given year
filterYear <- function(data, yearname){
  return(select_(data,"Agency_Title",yearname) %>% rename_( "salaries" = yearname))
  
}

#This function returns the data in a format thats readable by the Bar Chart funciton in plotly
getBarData <- function(data,departments){
  return(filter(data, Agency_Title %in% departments)$total)
}

getHighestPaid <- function(data){
  
}

#This function gets the total spending on salaries for a given year
getTotalSpending <- function(data,yearname){
  data <- filterYear(data,yearname)
  
  return(prettyNum(sum(data$salaries),big.mark=",",scientific=FALSE))
  
}





