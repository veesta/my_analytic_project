"1_raw_to_analytic_data_script.R"

library(tidyverse)

raw_data <-read_csv(file="rawData.csv")

str(raw_data)

#View(raw_data)
