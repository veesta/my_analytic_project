"1_raw_to_analytic_data_script.R"

library(tidyverse)

raw_data <-read_csv(file="rawData.csv")

str(raw_data)

#View(raw_data)

raw_data <-read_csv(file="rawData.csv" ,na=c("","NA","-999","-888"))