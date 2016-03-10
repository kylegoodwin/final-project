require(dplyr)

#reads in the functions from the format file
source("format.R")

#reads in the data and reformats it for data wrangling
data <- read.csv("AnnualSalary.csv")
clean_data <- getIntegerData(data)

#filters the data to show only UW employees
UW_data <- filterUW(clean_data)

#adds a new column that shows the average salary between 2011 and 2014
