#Manipulate Data
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
  
  return(data);
  
}


#This function will summarize the way each agency in the state of washington spends money
summarizeWa <- function(data){
  grouped_summary <- group_by(data,Agency_Title) %>% summarise(total = sum(Sal2014))
  wa_total = sum(grouped_summary$total)
  
  big <- filter(grouped_summary, total/wa_total >= .05)
  others <- filter(grouped_summary, total/wa_total < .05)
  
  other_total <- sum(others$total)
  
  others <- slice(others, 1)
  others$total[1] <- other_total
  others$Agency_Title[1] <- "Other Agencies"
  
  
  grouped_summary <- 

  
  
  
  return(grouped_summary);
  
}




