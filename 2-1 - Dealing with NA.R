dengue_df

# instead of removing NAs we can predict them (because most are colinear and testset has nas)

naintrain <- colSums(is.na(dengue_df))
naintest <- colSums(is.na(dengue_features_test))
nainfo <- cbind(naintrain, naintest)

dengue_df <- na.omit(dengue_df)

# summary(dengue_df)

ggplot(dengue_df, aes(x = precipitation_amt_mm)) + geom_density() + facet_wrap(~ city)

dengue_df$reanalysis_dew_point_temp_k[is.na(dengue_df$reanalysis_dew_point_temp_k)] <- 
  mean(na.omit(dengue_df$reanalysis_dew_point_temp_k))

dengue_features_test$reanalysis_dew_point_temp_k[is.na(dengue_features_test$reanalysis_dew_point_temp_k)] <- 
  mean(na.omit(dengue_df$reanalysis_dew_point_temp_k))

dengue_df$precipitation_amt_mm[is.na(dengue_df$precipitation_amt_mm)] <- 
  mean(na.omit(dengue_df$precipitation_amt_mm))

dengue_features_test$reanalysis_min_air_temp_k[is.na(dengue_features_test$reanalysis_min_air_temp_k)] <- 
  (dengue_df$station_min_temp_c +273))

dengue_features_test$reanalysis_min_air_temp_k[is.na(dengue_features_test$precipitation_amt_mm)] <- 
  mean(na.omit(dengue_df$precipitation_amt_mm))

summary(dengue_df)
