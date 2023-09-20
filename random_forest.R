
set.seed(101)

forest_train.data <- shuffle_data[train.indices,]
forest_test.data <- shuffle_data[-train.indices,]


install.packages("randomForest")
library(randomForest)
library(Metrics)

names(forest_train.data) <- make.names(names(forest_train.data))
names(forest_test.data) <- make.names(names(forest_test.data))

random_forest400 <- randomForest(
  formula = `total.week.diff..t.` ~  . - (korisnik + week.in.year),
  data = forest_train.data,
  ntree = 400,
  importance = TRUE
)

forest400.predict <- predict(random_forest400, newdata = forest_test.data)



forest400.test.RMSE <- rmse(actual = forest_test.data$total.week.diff..t., predicted = forest400.predict)

forest400.test.MAE <- mae(actual = forest_test.data$total.week.diff..t., predicted = forest400.predict)


forest400.test.RSS <- sum((forest400.predict - forest_test.data$total.week.diff..t.)^2)

forest.test.TSS <- sum((mean(forest_train.data$total.week.diff..t.) - forest_test.data$total.week.diff..t.)^2)


forest400.test.R2 <- 1 - forest400.test.RSS/forest.test.TSS
forest400.test.R2


random_forest600 <- randomForest(
  formula = `total.week.diff..t.` ~  . - (korisnik + week.in.year),
  data = forest_train.data,
  ntree = 600,
  importance = TRUE
)



random_forest1 <- randomForest(
  formula = `total.week.diff..t.` ~  . - (korisnik + week.in.year),
  data = forest_train.data,
  importance = TRUE
)

random_forest1

plot(random_forest1)

forest1.predict <- predict(random_forest1, newdata = forest_test.data)

test.forest1 <- cbind(test.data, pred = forest1.predict)

ggplot(data = test.forest1) + xlim(-10000,10000) +
  geom_density(mapping = aes(x=`total.week.diff.(t)`, color = 'real')) +
  geom_density(mapping = aes(x=pred, color = 'predicted')) +
  scale_colour_discrete(name ="total.week.diff.(t) distribution - random forest") +
  theme_classic()



forest1.test.RMSE <- rmse(actual = forest_test.data$total.week.diff..t., predicted = forest1.predict)

forest1.test.MAE <- mae(actual = forest_test.data$total.week.diff..t., predicted = forest1.predict)


forest1.test.RSS <- sum((forest1.predict - forest_test.data$total.week.diff..t.)^2)

forest.test.TSS <- sum((mean(forest_train.data$total.week.diff..t.) - forest_test.data$total.week.diff..t.)^2)


forest1.test.R2 <- 1 - forest1.test.RSS/forest.test.TSS
forest1.test.R2

rezultati[5,] <- c(forest1.test.RMSE,forest1.test.MAE,forest1.test.R2)


random_forest2 <- randomForest(
  formula = `total.week.diff..t.` ~  `total.week.payin..t.2.` + `total.week.payin..t.1.`  +
    `total.week.diff..t.2.` + `total.week.diff..t.1.` +
    `median.payin.on.ticket..t.2.` + `median.payin.on.ticket..t.1.` + 
    `favorite.no..of.matches.diff..t.1.` + `X2nd.favorite.no..of.matches.diff..t.1.`,
  data = forest_train.data,
  importance = TRUE  
)

random_forest2


forest2.predict <- predict(random_forest2, newdata = forest_test.data)


test.forest2 <- cbind(test.data, pred = forest2.predict)

ggplot(data = test.forest2) + xlim(-10000,10000) +
  geom_density(mapping = aes(x=`total.week.diff.(t)`, color = 'real')) +
  geom_density(mapping = aes(x=pred, color = 'predicted')) +
  scale_colour_discrete(name ="total.week.diff.(t) distribution") +
  theme_classic()

forest2.test.RMSE <- rmse(actual = forest_test.data$total.week.diff..t., predicted = forest2.predict)

forest2.test.MAE <- mae(actual = forest_test.data$total.week.diff..t., predicted = forest2.predict)


forest2.test.RSS <- sum((forest2.predict - forest_test.data$total.week.diff..t.)^2)


forest2.test.R2 <- 1 - forest2.test.RSS/forest.test.TSS
forest2.test.R2


rezultati[6,] <- c(forest2.test.RMSE,forest2.test.MAE,forest2.test.R2)
