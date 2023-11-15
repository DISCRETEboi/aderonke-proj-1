### date: Nov. 15, 2023
### student id: ******
### program purpose: data analysis using R

library(dplyr)

## 1
cdrc_data <- read.csv("hh_churn_lsoa11_2023.csv")

cdrc_data_bkp <- cdrc_data #not needed (just backing up dataset)

## 2
cdrc_data_menai <- filter(cdrc_data, area == "W01000092")
cdrc_data_menai_W01000092 <- unlist(cdrc_data_menai[1, -1])

cdrc_data_menai_sub <- cdrc_data_menai_W01000092[cdrc_data_menai_W01000092 > 0.5 & cdrc_data_menai_W01000092 < 0.8]
print(cdrc_data_menai_sub)
print(names(cdrc_data_menai_sub))

## 3
cdrc_data$ARMI <- round(rowMeans(cdrc_data[, -c(1, 28)]), 3)
cdrc_data$ARMIctgrs <- cut(cdrc_data$ARMI, breaks = c(0, 0.2, 0.5, 1), labels = c("Low", "Medium", "High"))





