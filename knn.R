knn_data <- pavle_data_sredjen_copy

summary(knn_data)
str(knn_data)

apply(X = knn_data, 
      MARGIN = 2, 
      FUN = function(x) length(boxplot.stats(x)$out))

apply(X = knn_data, 
      MARGIN = 2, 
      FUN = function(x) shapiro.test(sample(x,size = 5000)))


knn_data_st = apply(X = knn_data[,-c(1,2,ncol(knn_data))],
                    MARGIN = 2,
                    FUN = function(x) scale(x, center = median(x), scale = IQR(x)))

knn_data_st <- as.data.frame(knn_data_st)

knn_data_st$korisnik <- knn_data$korisnik
knn_data_st$week.in.year <- knn_data$week.in.year
knn_data_st$`total.week.diff.(t)` <- knn_data$`total.week.diff.(t)`

knn_data_st <- knn_data_st[,names(knn_data)]

set.seed(100)

knn_shuffle_data <- knn_data_st[rows,]

knn_train.data <- knn_shuffle_data[train.indices,]
knn_test.data <- knn_shuffle_data[-train.indices,]


library(e1071)

numFolds = trainControl( method = "cv", number = 10)

cpGrid = expand.grid(.k = seq(from=50, to = 70, by = 1))

set.seed(200)

knn.cv <- train(x = knn_train.data[,-c(1,2,ncol(knn_data_st))],
                y = knn_train.data$`total.week.diff.(t)`,
                method = "knn",
                trControl = numFolds,
                tuneGrid = cpGrid)

knn.cv
plot(knn.cv)

optimal_k <- knn.cv$bestTune$k

install.packages('FNN')

library(FNN)


knn1.pred <- knn.reg(train = knn_train.data[,-c(1,2,ncol(knn_data_st))],
                     test = knn_test.data[,-c(1,2,ncol(knn_data_st))],
                     y = knn_train.data$`total.week.diff.(t)`,
                     k = optimal_k)


summary(knn1.pred)

test.knn1 <- cbind(knn_test.data, pred = knn1.pred$pred)

ggplot(data = test.knn1) + xlim(-10000,10000) +
  geom_density(mapping = aes(x=`total.week.diff.(t)`, color = 'real')) +
  geom_density(mapping = aes(x=pred, color = 'predicted')) +
  scale_colour_discrete(name ="total.week.diff distribution") +
  theme_classic()

knn1.test.RSS <- sum((knn1.pred$pred - knn_test.data$`total.week.diff.(t)`)^2)

knn1.test.RMSE <- sqrt(knn1.test.RSS/nrow(knn_test.data))

knn1.test.RMSE

knn1.test.MAE <- mean(abs(knn1.pred$pred - knn_test.data$`total.week.diff.(t)`))

knn1.test.MAE

knn.test.TSS <- sum((mean(knn_train.data$`total.week.diff.(t)`) - knn_test.data$`total.week.diff.(t)`)^2)

knn1.test.R2 <- 1 - knn1.test.RSS/knn.test.TSS
knn1.test.R2


rezultati[3,] <- c(knn1.test.RMSE,knn1.test.MAE,knn1.test.R2)




columns_fs_mutual_infk <- c("total.week.payin.(t-2)","total.week.payin.(t-1)",
                            "total.week.diff.(t-2)", "total.week.diff.(t-1)", 
                            "median.payin.on.ticket.(t-2)", "median.payin.on.ticket.(t-1)", 
                            "favorite.no..of.matches.diff.(t-1)", "X2nd.favorite.no..of.matches.diff.(t-1)")

columns_fs_fisher <- c('week.deposit.in.(t-3)', 'week.deposit.in.(t-2)',
                       'week.deposit.in.(t-1)', 'total.week.payin.(t-3)',
                       'total.week.payin.(t-2)', 'total.week.payin.(t-1)',
                       'payin.on.live.(t-3)', 'payin.on.live.(t-2)',
                       'payin.on.live.(t-1)', 'payin.on.prematch.(t-1)',
                       'favorite.sport.diff.(t-1)', 'favorite.no..of.matches.diff.(t-1)',
                       'X2nd.favorite.no..of.matches.diff.(t-1)')

indexes_of_columns_for_knn <- which(colnames(knn_data_st) %in% columns_fs_mutual_infk)

knn2.pred <- knn.reg(train = knn_train.data[,indexes_of_columns_for_knn],
                     test = knn_test.data[,indexes_of_columns_for_knn],
                     y = knn_train.data$`total.week.diff.(t)`,
                     k = optimal_k)

test.knn2 <- cbind(knn_test.data, pred = knn2.pred$pred)

ggplot(data = test.knn2) + xlim(-10000,10000) +
  geom_density(mapping = aes(x=`total.week.diff.(t)`, color = 'real')) +
  geom_density(mapping = aes(x=pred, color = 'predicted')) +
  scale_colour_discrete(name ="total.week.diff distribution") +
  theme_classic()

knn2.test.RSS <- sum((knn2.pred$pred - knn_test.data$`total.week.diff.(t)`)^2)

knn2.test.RMSE <- sqrt(knn2.test.RSS/nrow(knn_test.data))

knn2.test.RMSE

knn2.test.MAE <- mean(abs(knn2.pred$pred - knn_test.data$`total.week.diff.(t)`))

knn2.test.MAE

knn2.test.R2 <- 1 - knn2.test.RSS/knn.test.TSS
knn2.test.R2


rezultati[4,] <- c(knn2.test.RMSE,knn2.test.MAE,knn2.test.R2)
