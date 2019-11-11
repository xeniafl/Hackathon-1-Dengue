library(readr)
library(ggplot2)
library(caret)
library(party)
library(corrplot)

dengue_labels_train <- read_csv("datasets/dengue_labels_train.csv")
dengue_features_train <- read_csv("datasets/dengue_features_train.csv")
dengue_features_test <- read_csv("datasets/dengue_features_test.csv")

dengue_df <- merge(dengue_features_train, dengue_labels_train)

dengue_df[which(dengue_df$city == "iq"), "city"] <- "0"
dengue_df[which(dengue_df$city == "sj"), "city"] <- "1"
dengue_df$city <- as.numeric(dengue_df$city)

dengue_features_test[which(dengue_features_test$city == "iq"), "city"] <- "0"
dengue_features_test[which(dengue_features_test$city == "sj"), "city"] <- "1"
dengue_features_test$city <- as.numeric(dengue_features_test$city)

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


dengue_df <- dengue_df[,c(1:3, 9, 12, 25)]
dengue_features_test <- dengue_features_test[,c(1:3, 9, 12)]

dengue_df$total_cases_week_before <- dengue_df$total_cases[c(1456, 1:1455)]

summary(dengue_df)
