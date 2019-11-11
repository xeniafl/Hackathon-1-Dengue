library(readr)
library(ggplot2)
library(caret)
library(party)
library(corrplot)


## Data understanding:

# summary(dengue_df)
# table(dengue_df$city)
# table(dengue_df$total_cases)
# 
# ggplot(dengue_df) + geom_col(aes(x = city, y = total_cases))
# ggplot(dengue_df) + geom_histogram(aes(x = total_cases, fill = city))
# 
# rowSums(is.na(dengue_df))

## pre processing:

# week start date is logically the same as week of year

dengue_df$week_start_date <- NULL

# Year and NDVI are colinear with the city

dengue_df$year <- NULL
dengue_df$ndvi_ne <- NULL
dengue_df$ndvi_nw <- NULL
dengue_df$ndvi_se <- NULL
dengue_df$ndvi_sw <- NULL

