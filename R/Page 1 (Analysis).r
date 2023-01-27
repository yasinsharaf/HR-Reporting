#connect to mysql database table
library(RMySQL)
mysqlconnection = dbConnect(RMySQL::MySQL(),
+                             dbname='employees',
+                             host='localhost',
+                             port=3306,
+                             user='yourusername',
+                             password='yourpassword')
dbListTables(mysqlconnection)
result = dbSendQuery(mysqlconnection, "select * from hiring_statistics")
hiring_statistics = fetch(result, n = -1)
print(hiring_statistics)

#find unique age groups
unique(hiring_statistics[c("AgeGroup")])

#load packages
#magrittr (for pipe operator)
#dplyr (for summarize function)

#create percentile table showing 25th, 50th, and 75th percentiles
#of starting salary based on age group
#store output in a function
library(magrittr)
library(dplyr)
percentiles <- hiring_statistics %>%
  group_by(AgeGroup) %>%
  summarize("25th Percentile" = quantile(StartingSalary, probs = 0.25),
            "50th Percentile" = quantile(StartingSalary, probs = 0.50),
            "75th Percentile" = quantile(StartingSalary, probs = 0.75))

#export new dataframe to csv to add to power bi
write.csv(percentiles, "C:\\Users\\yasin\\OneDrive\\Desktop\\Project 1 Power BI Code\\CSV FIles\\Percentiles.csv", 
          row.names = TRUE)
