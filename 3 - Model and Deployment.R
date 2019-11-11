iquitos
sj

pred_iquitos <- dengue_features_test[which(dengue_features_test$city == "0"),]
pred_sj <- dengue_features_test[which(dengue_features_test$city == "1"),]


library(caret)
library(ggplot2)



## Modeling Iquitos

set.seed(1234)

inTrain <- createDataPartition(y = iquitos$total_cases, p = .80, list = FALSE)
training <- iquitos[inTrain,]
testing <- iquitos[-inTrain,]

models <- c("svmLinear", "knn", "rf", "lm")
resum <- c()

for (i in models) {
  
  fit <- train(total_cases ~ ., data = training, method = i, na.action = na.pass)
  predicted_cases <- predict(fit, testing)
  hola <- postResample(pred = predicted_cases, obs = testing$total_cases)
  resum <- cbind(hola, resum)
  
}

colnames(resum) <-(models)

dengue_predictions <- cbind(testing, predicted_cases)

ggplot(dengue_predictions, aes(x = total_cases, y = predicted_cases)) + geom_point()
  
## Deployment

fit <- train(total_cases ~ ., data = iquitos, method = "knn")
predicted_cases <- predict(fit, pred_iquitos)

pred_iquitos <- cbind(pred_iquitos, predicted_cases)
pred_iquitos$predicted_cases <- as.integer(pred_iquitos$predicted_cases)





## Modeling SJ

set.seed(1234)

inTrain <- createDataPartition(y = sj$total_cases, p = .80, list = FALSE)
training <- sj[inTrain,]
testing <- sj[-inTrain,]

models <- c("svmLinear", "knn", "rf", "lm")
resum <- c()

for (i in models) {

fit <- train(total_cases ~ ., data = training, method = i, na.action = na.pass)
predicted_cases <- predict(fit, testing)
hola <- postResample(pred = predicted_cases, obs = testing$total_cases)
resum <- cbind(hola, resum)

}

colnames(resum) <-(models)

dengue_predictions <- cbind(testing, predicted_cases)

ggplot(dengue_predictions, aes(x = total_cases, y = predicted_cases)) + geom_point()

## Deployment

fit <- train(total_cases ~ ., data = sj, method = "knn")
predicted_cases <- predict(fit, pred_sj)


pred_sj <- cbind(pred_sj, predicted_cases)
pred_sj$predicted_cases <- as.integer(pred_sj$predicted_cases)


## writing csv

submission <- rbind(pred_sj, pred_iquitos)


submission <- submission[,c(1,2,3,6)]
submission$total_cases <- submission$predicted_cases
submission$predicted_cases <- NULL


submission[which(submission$city == "0"), "city"] <- "iq"
submission[which(submission$city == "1"), "city"] <- "sj"
submission[which(submission$total_cases < 0), "total_cases"] <- 0
submission$total_cases <- as.numeric(submission$total_cases)

str(submission)

write.csv(submission, file = "submission3.csv", row.names = F)
getwd()
