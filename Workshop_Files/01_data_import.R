library(tidyverse)
library(qualtRics)


mysurvey <- read_survey("2020 Vista Post-Course Survey.csv")

write_csv(mysurvey, path = "mysurvey.csv")

library(ggplot2)

ggplot(mysurvey) +
 aes(x = instructor1, y = Q4) +
 geom_boxplot(fill = "#0c4c8a") +
 theme_minimal()




# Import using readR



read_qualtrics <- function (path, skip) {
  
  #Saving the column names into object df.names
  df.names <- read_csv (path) %>% 
    names ()
  
  #Loading in the dataset with read_csv() skiping n = skip 
  #Using df.names as the column names
  df <- read_csv (path, col_names = df.names, skip = skip + 1)
  
  return (df)
}



df <- read_qualtrics ("2020 Vista Post-Course Survey.csv", skip = 2,  col_types="T")

print (df)



# import data
data <- read_csv("2020 Vista Post-Course Survey.csv")

### preview data ###
View(data)

### remove junk rows ###
### typically row 1 and 2 in qualtrics csv files ###
data <- data[-(c(1,2)),]





