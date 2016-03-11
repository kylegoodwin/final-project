setwd("/Users/kylegoodwin/INFO498F/final-project/")

library(dplyr)
library(plotly)
library(shiny)

salaries <- read.csv("data/AnnualSalary.csv")
source("scripts/format.R")
salaries<- getIntegerData(salaries)
uw_salaries <- filterUW(salaries)

# function for making 
nzeromean <- function(x) {
  zeroVals <- x==0
  if (all(zeroVals)) 0 else mean(x[!zeroVals])
}

# function that draws dot plots
groupAverage <- function(uw_salaries, slider1, slider2, year) {
  groupAVG <- group_by(uw_salaries, job_title) %>%
              summarise(avg2011 = round(nzeromean(Sal2011)), avg2012 = round(nzeromean(Sal2012)),
              avg2013 = round(nzeromean(Sal2013)), avg2014 = round(nzeromean(Sal2014)))
  groupAvgYear <- select(groupAVG, job_title, contains(year)) %>%
                  filter(groupAVG[2] < slider2, groupAVG[2] > slider1)
  names(groupAvgYear)[2]<-paste("avg")
  groupAvgYear <- arrange(groupAvgYear, avg)
  p <- plot_ly(groupAvgYear, x = job_title, y = avg, mode = "markers",
               marker = list(color = "purple"), text = paste0(job_title)) %>%
       layout(title = "Salary Disparity Graph UW", xaxis = list(title = "Job Titles in Order of Salary", showticklabels = FALSE), 
              yaxis = list(title = "Annual Salary")
              )
  return (p)
} 