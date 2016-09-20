"1_raw_to_analytic_data_script.R"

library(tidyverse)

raw_data <-read_csv(file="rawData.csv")

str(raw_data)

##how to view the table
#View(raw_data)

##add NA instead of numbers
raw_data <-read_csv(file="rawData.csv" ,na=c("","NA","-999","-888"))

#View(raw_data)

#create data with just categorical variables
categorical_variables <- select(raw_data, group, gender)

#tell R variables are categorical
categorical_variables$group <- as.factor(categorical_variables$group)

#assign labels to category
categorical_variables$gender <-as.factor(categorical_variables$gender)
levels(categorical_variables$gender) <- list("Male"=1, "Female"=2)
