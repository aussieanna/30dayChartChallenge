
library(tidyverse)
library(lubridate)
library(scales)
library(ggfx)
library(zoo)
library(ggthemes)

#Import data
#The date is character format as year-month needs to be changed to a date format for graphing, use the as.yearmon function from the zoo package
monthly_analysis_data_f0a6 <- read_csv("20_upwards/monthly_analysis_data_f0a6.csv") %>% mutate(date = as.Date(as.yearmon(`year-month`)))

#Graph cumulative installed kW
ggplot(monthly_analysis_data_f0a6, aes(x=date, y=cumulative_installed_kw)) +
  geom_line() +
  theme_minimal() + 
  scale_y_log10(
    "Total capacity (kw)",
    labels = scales::label_number_si()
  ) + 
  scale_x_date(
    NULL,
    breaks = scales::breaks_width("2 years"), 
    labels = scales::label_date("'%y")
  )

#Graph installations each month
ggplot(monthly_analysis_data_f0a6, aes(x=date, y=installations_in_month)) +
  geom_line(colour="#CD5555") +
  theme_economist() + 
  scale_y_log10(
    "Solar panel installations per month (log)",
    labels = scales::label_number_si()
  ) + 
  scale_x_date(
    NULL,
    breaks = scales::breaks_width("2 years"), 
    labels = scales::label_date("%Y")
  ) + 
  labs(title="Solar panel installations increased rapidly in Australia\nbetween 2008 and 2012")
