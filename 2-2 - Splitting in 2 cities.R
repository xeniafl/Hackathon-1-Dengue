library(corrplot)
dengue_df


iquitos <- dengue_df[which(dengue_df$city == "0"),]
sj <- dengue_df[which(dengue_df$city == "1"),]

iquitos <- na.omit(iquitos)
sj <- na.omit(sj)


iquitos$week_start_date <- NULL
sj$week_start_date <- NULL
str(iquitos)

sj_correlation_matrix <- cor(sj)
corrplot(iquitos_correlation_matrix, tl.cex = 0.5, tl.srt = 45)
corrplot(sj_correlation_matrix, tl.cex = 0.5, tl.srt = 45)
