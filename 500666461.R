### date: Nov. 17, 2023
### student id: 500666461
### program purpose: Data Analysis using R

## loading required libraries *dplyr*, *stringr* and *ggplot2*
library(dplyr)
library(stringr)
library(ggplot2)

### Task 1
## reading the dataset into R
cdrc_data <- read.csv("hh_churn_lsoa11_2023.csv")
str(cdrc_data) #extraneous

### Task 2
## examining the LSOA code W01000092 Menai (Bangor), and identifying the residential mobility indices which are greater than 0.5 and less than 0.8.
cdrc_data_menai_df <- filter(cdrc_data, area == "W01000092")
cdrc_data_menai <- unlist(cdrc_data_menai_df[1, -1])
cdrc_data_menai_sub <- cdrc_data_menai[cdrc_data_menai > 0.5 & cdrc_data_menai < 0.8]
# printing the named vector
print(cdrc_data_menai_sub)
# printing the names of the vector
print(names(cdrc_data_menai_sub))
# printing the actual years
x <- str_replace(names(cdrc_data_menai_sub), "chn", "")
print(x)

### Task 3
## appending additional columns to the data
# adds column one (averaged residential mobility for each region) as ARMI
cdrc_data$ARMI <- round(rowMeans(cdrc_data[, -c(1, 28)]), 3)
# adds column two (grouping regions into low, medium and high) as ARMIgrpd
cdrc_data$ARMIgrpd <- cut(cdrc_data$ARMI,
                          breaks = c(0, 0.2, 0.5, 1),
                          labels = c("Low", "Medium", "High"))
str(cdrc_data)

### Task 4
## First insight (with chart)
avg_armi <- round(colMeans(cdrc_data[, 2:27]), 3)
years <- as.numeric(str_replace(names(avg_armi), "chn", ""))
ts_df <- data.frame(year = years, avg_rmi = avg_armi)

ggplot(ts_df, aes(x = year, y = avg_rmi)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  labs(x = "Year",
       y = "Average residential mobility index",
       title = "Trend of residential mobility index over time across regions") +
  theme_bw()

# The chart is a time series plot showing the change in residential mobility index (averaged across all the regions) over time from 1997 to 2022.
# The plot clearly shows a sharp downward trend in the residential mobility index over time. The downward trend is also observed to be uniform,
# with the line approximately straight. The inference from the chart is that, on average, as years pass by, the residential mobility decreases;
# with this trend applying to all regions.

## Second insight (with chart)
ggplot(cdrc_data, aes(x = chn1997, y = chn2022, color = ARMIgrpd)) +
  geom_point() +
  labs(x = "Residential mobility index in 1997",
       y = "Residential mobility index in 2022",
       color = "RMI level",
       title = "Correlation plot for the residential mobility index - year 2022 against 1997") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_text(size = 10),
        axis.ticks.x = element_blank(),
        axis.text.x = element_text(size = 10),
        axis.title = element_text(size = 15, margin = margin(t = 15)),
        plot.margin = margin(20, 0, 20, 0),
        plot.title = element_text(size = 20, face = "bold"))

# The residential mobility indices in 2022 are plotted against the residential mobility indices for 1997 to detect correlation in the indices
# across the extreme years. The plot clearly shows a positive and strong correlation. The points are classified in the plot according to the
# attribute Average Residential Mobility Index (ARMI) in the dataset. The interpretation from the plot could be that regions with high RMI in 1997
# would also very likely have high RMI in 2022. Correspondingly, regions with low RMI in 1997 would likely have low RMI in 2022.













