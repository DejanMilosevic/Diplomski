set.seed(100)

rows <- sample(nrow(pavle_data_sredjen_copy))
shuffle_data <- pavle_data_sredjen_copy[rows,]

library(caret)

set.seed(101)

train.indices <- createDataPartition(shuffle_data$`total.week.diff.(t)`, p=0.70, list = F)
train.data <- shuffle_data[train.indices,]
test.data <- shuffle_data[-train.indices,]

lm1 <- lm(formula = `total.week.diff.(t)` ~ . - 
            (korisnik + week.in.year +
               `favorite.sport.diff.(t-3)` + `favorite.sport.diff.(t-2)` +
            `favorite.sport.diff.(t-1)` + `number.of.tickets.(t-2)`), 
            data = train.data)

summary(lm1)

library(car)

sort(sqrt(vif(lm1)))

dev.off()

par(mfrow=c(1,1))

plot(lm1)

lm1.leverage <- hatvalues(lm1)
plot(lm1.leverage)

length(which(lm1.leverage > 2*(44+1)/nrow(train.data)))



lm1.predict <- predict(lm1, newdata = test.data)

test.lm1 <- cbind(test.data, pred = lm1.predict)

ggplot(data = test.lm1) + xlim(-10000,10000) +
  geom_density(mapping = aes(x=`total.week.diff.(t)`, color = 'real')) +
  geom_density(mapping = aes(x=pred, color = 'predicted')) +
  scale_colour_discrete(name ="total.week.diff.(t) distribution") +
  theme_classic()


lm1.test.RSS <- sum((lm1.predict - test.data$`total.week.diff.(t)`)^2)

lm1.test.RMSE <- sqrt(lm1.test.RSS/nrow(test.data))

lm1.test.RMSE

mean(test.data$`total.week.diff.(t)`)

lm1.test.RMSE/mean(test.data$`total.week.diff.(t)`)

lm1.test.MAE <- mean(abs(lm1.predict - test.data$`total.week.diff.(t)`))

lm1.test.MAE

lm.test.TSS <- sum((mean(train.data$`total.week.diff.(t)`) - test.data$`total.week.diff.(t)`)^2)

lm1.test.R2 <- 1 - lm1.test.RSS/lm.test.TSS
lm1.test.R2

rezultati[1,] <- c(lm1.test.RMSE,lm1.test.MAE,lm1.test.R2)









lm2 <- lm(formula = `total.week.diff.(t)` ~ 
            `total.week.payin.(t-2)` + `total.week.payin.(t-1)`  + 
            `total.week.diff.(t-2)` + `total.week.diff.(t-1)` +   
            `median.payin.on.ticket.(t-2)` + `median.payin.on.ticket.(t-1)` +
            `favorite.no..of.matches.diff.(t-1)` + `X2nd.favorite.no..of.matches.diff.(t-1)`, 
          data = train.data)


summary(lm2)

sort(sqrt(vif(lm2)))

dev.off()
par(mar = c(1,1,1,1))
par(mfrow=c(2,2))

plot(lm2)

lm2.leverage <- hatvalues(lm2)
plot(lm2.leverage)

length(which(lm2.leverage > 2*(8+1)/nrow(train.data)))



lm2.predict <- predict(lm2, newdata = test.data)

test.lm2 <- cbind(test.data, pred = lm2.predict)

ggplot(data = test.lm2) + xlim(-10000,10000) +
  geom_density(mapping = aes(x=`total.week.diff.(t)`, color = 'real')) +
  geom_density(mapping = aes(x=pred, color = 'predicted')) +
  scale_colour_discrete(name ="total.week.diff.(t) distribution") +
  theme_classic()

lm2.test.RSS <- sum((lm2.predict - test.data$`total.week.diff.(t)`)^2)

lm2.test.RMSE <- sqrt(lm2.test.RSS/nrow(test.data))

lm2.test.RMSE

lm2.test.RMSE/mean(test.data$`total.week.diff.(t)`)

lm2.test.MAE <- mean(abs(lm2.predict - test.data$`total.week.diff.(t)`))

lm2.test.MAE

lm2.test.R2 <- 1 - lm2.test.RSS/lm.test.TSS
lm2.test.R2

rezultati[2,] <- c(lm2.test.RMSE,lm2.test.MAE,lm2.test.R2)


