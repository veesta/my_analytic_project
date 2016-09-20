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

#create sets of scale items 
affective_commitment_items <- select (raw_data, AC1, AC2, AC3, AC4, AC5)
agreeableness_items <- select (raw_data, A1, A2, A3, A4, A5)
extroversion_items <- select (raw_data, E1, E2, E3, E4, E5)

#View (affective_commitment_items)


#checking for out of range values - make sure min and max is 1 - 5

psych::describe(extroversion_items)

psych::describe(agreeableness_items)

#fix error in agreeableness item A5

agreeableness_items

#turn impossible values into missing values 
#identify values less than one and greater than five and combine with pipe operator

is_bad_value <- agreeableness_items<1 | agreeableness_items>5
agreeableness_items[is_bad_value] <- NA

#View(agreeableness_items)

#check to see if you fixed the problem 

psych::describe(agreeableness_items)

psych::describe(affective_commitment_items)

#fix max or min in the affective items 
is_bad_value <- affective_commitment_items<1 | affective_commitment_items>7
affective_commitment_items[is_bad_value] <-NA

#View(affective_commitment_items)

psych::describe(affective_commitment_items)
psych::describe(extroversion_items)

#reverse key items with mutate command
#for agreeableness item A5 was reverse keyed, 2S should become 4s

agreeableness_items <- mutate(agreeableness_items, A5=6-A5)

#View(agreeableness_items)

#View(affective_commitment_items)

#reverse key affective commitment items - AC4 and AC5

affective_commitment_items <- mutate(affective_commitment_items, AC4=8-AC4)
affective_commitment_items <- mutate(affective_commitment_items, AC5=8-AC5)


#View(affective_commitment_items)

#Obtain scale scores- mean for each person based on items 

agreeableness        <- psych::alpha(as.data.frame(agreeableness_items),        check.keys=FALSE)$scores
extroversion         <- psych::alpha(as.data.frame(extroversion_items),         check.keys=FALSE)$scores
affective_commitment <- psych::alpha(as.data.frame(affective_commitment_items), check.keys=FALSE)$scores
                                    
#combine everything into analytic data 

analytic_data <- cbind(categorical_variables, agreeableness, extroversion, affective_commitment)

#view your table 
analytic_data

#save as RD data set 
save(analytic_data,file="study1_analytic_data.RData")
