data_bez_autlajera <- read.csv("maxbet_without_outliers_grouped.csv")

subdata_bez_autlajera <- data_bez_autlajera

subdata_bez_autlajera$Unnamed..0 <- NULL

id_bez_autlajera = unique(subdata_bez_autlajera$korisnik)

id_new_bez_autlajera = c()

for(i in 1:length(id_bez_autlajera)){
  print(paste("ID broj: ", i))
  k=0
  for(j in 1:length(subdata_bez_autlajera$korisnik)){
    if(id_bez_autlajera[i]==subdata_bez_autlajera$korisnik[j]){
      k=k+1
    }
    if(k>=5){
      break
    }
  }
  if(k>=5){
    id_new_bez_autlajera <- c(id_new_bez_autlajera,id_bez_autlajera[i])
  }
}

subdata_new_bez_autlajera <- data.frame()

for(p in 1:length(subdata_bez_autlajera$korisnik)){
  print(paste("Observacija broj: ", p))
  for(r in 1:length(id_new_bez_autlajera)){
    if(subdata_bez_autlajera$korisnik[p] == id_new_bez_autlajera[r]){
      subdata_new_bez_autlajera <- rbind(subdata_new_bez_autlajera,subdata_bez_autlajera[p,])
      break
    }
  }
}

write.csv(subdata_new_bez_autlajera, "ocisceni_dataset_bez_autlajera.csv", row.names = F)

apply(subdata_new_bez_autlajera, 2, function(x) sum(is.na(x)))

for(d in 1:ncol(subdata_new_bez_autlajera)){
  subdata_new_bez_autlajera[,d] = as.numeric(subdata_new_bez_autlajera[,d])
}



corr.matrix <- cor(subdata_new_bez_autlajera, method = "spearman")

write.csv(corr.matrix, "korelaciona_matrica_bez_autlajera.csv", row.names = F)

subdata_new_bez_autlajera$verified <- NULL
subdata_new_bez_autlajera$week.deposit.diff.. <- NULL
subdata_new_bez_autlajera$frequency <- NULL
subdata_new_bez_autlajera$average.number.of.combinations <- NULL
subdata_new_bez_autlajera$cashout.win <- NULL
subdata_new_bez_autlajera$cashback.win <- NULL
subdata_new_bez_autlajera$diff.between.payin.and.win.time <- NULL
subdata_new_bez_autlajera$number.of.authorization.ticket <- NULL
subdata_new_bez_autlajera$number.of.approved.ticket <- NULL
subdata_new_bez_autlajera$stedev.odds.on.ticket <- NULL
subdata_new_bez_autlajera$average.hit.odd <- NULL
subdata_new_bez_autlajera$average.diff.between.match.kickoff.time.and.ticket.payin.time <- NULL
subdata_new_bez_autlajera$average.diff.between.gray.and.real.odds <- NULL
subdata_new_bez_autlajera$average.win.odd.value <- NULL
subdata_new_bez_autlajera$average.loss.odd.value <- NULL
subdata_new_bez_autlajera$X..2nd.fs.in.total.sport.diff <- NULL
subdata_new_bez_autlajera$X..fs.in.total.sport.payin <- NULL
subdata_new_bez_autlajera$X..2nd.fs.in.total.sport.payin <- NULL
subdata_new_bez_autlajera$X..fs.in.total.league.diff <- NULL
subdata_new_bez_autlajera$X..2nd.fs.in.total.league.diff <- NULL
subdata_new_bez_autlajera$X..fs.in.total.league.payin <- NULL
subdata_new_bez_autlajera$X..2nd.fs.in.total.league.payin <- NULL
subdata_new_bez_autlajera$X..fs.in.total.bet.diff <- NULL
subdata_new_bez_autlajera$X..2nd.fs.in.total.bet.diff <- NULL
subdata_new_bez_autlajera$favorite.no..of.matches <- NULL
subdata_new_bez_autlajera$X2nd.favorite.no..of.matches <- NULL
subdata_new_bez_autlajera$favourite.hour <- NULL
subdata_new_bez_autlajera$week.no..of.leagues <- NULL
subdata_new_bez_autlajera$week.no..of.sports <- NULL
subdata_new_bez_autlajera$week.no..of.prematch.mathces <- NULL
subdata_new_bez_autlajera$week.no..of.live.mathces <- NULL
subdata_new_bez_autlajera$week.no..of.favourite.mathces <- NULL
subdata_new_bez_autlajera$average.week.league.risk.value<- NULL
subdata_new_bez_autlajera$week.live.payin<- NULL
subdata_new_bez_autlajera$week.live.diff<- NULL
subdata_new_bez_autlajera$week.live.margin..<- NULL
subdata_new_bez_autlajera$week.prematch.payin<- NULL
subdata_new_bez_autlajera$week.prematch.diff<- NULL
subdata_new_bez_autlajera$week.prematch.margin..<- NULL


subdata_new_bez_autlajera$number.of.distinct.payin.on.ticket.value <- NULL
subdata_new_bez_autlajera$total.week.win <- NULL
subdata_new_bez_autlajera$favorite.sport.payin <- NULL
subdata_new_bez_autlajera$X2nd.favorite.sport.payin <- NULL
subdata_new_bez_autlajera$favorite.league.payin <- NULL
subdata_new_bez_autlajera$X2nd.favorite.league.payin <- NULL
subdata_new_bez_autlajera$favorite.bet.payin <- NULL
subdata_new_bez_autlajera$X2nd.favorite.bet.payin <- NULL
subdata_new_bez_autlajera$favourite.hour.payin <- NULL
subdata_new_bez_autlajera$favorite.no..of.matches.payin <- NULL
subdata_new_bez_autlajera$X2nd.favorite.no..of.matches.payin <- NULL
subdata_new_bez_autlajera$median_odds <- NULL
subdata_new_bez_autlajera$average.payin.on.live <- NULL
subdata_new_bez_autlajera$median.risk.value.on.tickets <- NULL
subdata_new_bez_autlajera$average.payin.on.prematch <- NULL


subdata_new_bez_autlajera$average.payin.on.ticket <- NULL
subdata_new_bez_autlajera$problematic_ticket_cluster <- NULL
subdata_new_bez_autlajera$favorite.sport <- NULL
subdata_new_bez_autlajera$X2nd.favorite.sport <- NULL
subdata_new_bez_autlajera$X..fs.in.total.sport.diff <- NULL
subdata_new_bez_autlajera$favorite.league <- NULL
subdata_new_bez_autlajera$X2nd.favorite.league <- NULL
subdata_new_bez_autlajera$favorite.bet <- NULL
subdata_new_bez_autlajera$X2nd.favorite.bet <- NULL

write.csv(subdata_new_bez_autlajera, "ocisceni_dataset_bez_autlajera_izbacene_kolone.csv", row.names = F)


niz_kolona <- c("korisnik","week.in.year")

for(t in 3:ncol(subdata_new_bez_autlajera)){
  naziv_kolone = colnames(subdata_new_bez_autlajera)[t]
  niz_kolona = c(niz_kolona, c(paste(naziv_kolone, ".(t-", 3:1, ")", sep = "")))
}

niz_kolona <- c(niz_kolona, "total.week.diff.(t)")

niz_kolona

pavle_data <- data.frame(matrix(ncol = length(niz_kolona),nrow = 0))

colnames(pavle_data) <- niz_kolona



for(indeks in 1:length(id_new_bez_autlajera)){
  print(id_new_bez_autlajera[indeks])
  
  pavle_data_kor <- data.frame(matrix(ncol = length(niz_kolona),nrow = 0))
  colnames(pavle_data_kor) <- niz_kolona
  
  korisnik_data = subdata_new_bez_autlajera[subdata_new_bez_autlajera$korisnik==id_new_bez_autlajera[indeks],]

  brojac_red = 1
  for(i in 4:nrow(korisnik_data)){
    brojac_kolona = 3
    for(j in 3:ncol(korisnik_data)){
      pavle_data_kor[brojac_red, brojac_kolona] = korisnik_data[i-3,j]
      pavle_data_kor[brojac_red, brojac_kolona+1] = korisnik_data[i-2,j]
      pavle_data_kor[brojac_red, brojac_kolona+2] = korisnik_data[i-1,j]
      brojac_kolona = brojac_kolona + 3
    }
    pavle_data_kor$`total.week.diff (t)`[brojac_red] = korisnik_data$total.week.diff[i]
    pavle_data_kor$week.in.year[brojac_red] = korisnik_data$week.in.year[i]
    pavle_data_kor$korisnik = korisnik_data$korisnik[i]
    brojac_red = brojac_red + 1
  }
  pavle_data <- rbind(pavle_data, pavle_data_kor)
}

apply(pavle_data,2,function(x) sum(is.na(x)))

str(pavle_data)



pavle_data_sredjen <- data.frame(matrix(ncol = length(niz_kolona),nrow = 0))

colnames(pavle_data_sredjen) <- niz_kolona


for(indeks in 1:length(id_new_bez_autlajera)){
  print(id_new_bez_autlajera[indeks])
  
  pavle_data_kor <- data.frame(matrix(ncol = length(niz_kolona),nrow = 0))
  colnames(pavle_data_kor) <- niz_kolona
  
  korisnik_data = subdata_new_bez_autlajera[subdata_new_bez_autlajera$korisnik==id_new_bez_autlajera[indeks],]
  
  brojac_red = 1
  for(i in 4:nrow(korisnik_data)){
    if((korisnik_data$week.in.year[i] - korisnik_data$week.in.year[i-1] != 1) ||
       (korisnik_data$week.in.year[i] - korisnik_data$week.in.year[i-2] != 2) ||
       (korisnik_data$week.in.year[i] - korisnik_data$week.in.year[i-3] != 3)){
      
      next
    }
      
    brojac_kolona = 3
    for(j in 3:ncol(korisnik_data)){
      pavle_data_kor[brojac_red, brojac_kolona] = korisnik_data[i-3,j]
      pavle_data_kor[brojac_red, brojac_kolona+1] = korisnik_data[i-2,j]
      pavle_data_kor[brojac_red, brojac_kolona+2] = korisnik_data[i-1,j]
      brojac_kolona = brojac_kolona + 3
    }
    pavle_data_kor$`total.week.diff (t)`[brojac_red] = korisnik_data$total.week.diff[i]
    pavle_data_kor$week.in.year[brojac_red] = korisnik_data$week.in.year[i]
    pavle_data_kor$korisnik = korisnik_data$korisnik[i]
    brojac_red = brojac_red + 1
  }
  pavle_data_sredjen <- rbind(pavle_data_sredjen, pavle_data_kor)
}

write.csv(pavle_data, "finalni_dataset_1.csv", row.names = F)
write.csv(pavle_data_sredjen_copy, "finalni_dataset_2.csv", row.names = F)

pavle_data_sredjen_copy <- pavle_data_sredjen

pavle_data_sredjen_copy$`week.deposit.out.(t-3)` <- NULL
pavle_data_sredjen_copy$`week.deposit.out.(t-2)` <- NULL
pavle_data_sredjen_copy$`week.deposit.out.(t-1)` <- NULL
pavle_data_sredjen_copy$`week.deposit.diff.(t-3)` <- NULL
pavle_data_sredjen_copy$`week.deposit.diff.(t-2)` <- NULL
pavle_data_sredjen_copy$`week.deposit.diff.(t-1)` <- NULL
pavle_data_sredjen_copy$`payin.on.live.(t-3)` <- NULL
pavle_data_sredjen_copy$`payin.on.live.(t-2)` <- NULL
pavle_data_sredjen_copy$`payin.on.live.(t-1)` <- NULL
pavle_data_sredjen_copy$`payin.on.prematch.(t-3)` <- NULL
pavle_data_sredjen_copy$`payin.on.prematch.(t-2)` <- NULL
pavle_data_sredjen_copy$`payin.on.prematch.(t-1)` <- NULL


columns_for_results <- c("RMSE","MAE","R-squared")

rezultati <- data.frame(matrix(ncol = 3,nrow = 6), row.names = 
                        c("lr_bez_fs", "lr_sa_fs","knn_bez_fs","knn_sa_fs","forest_bez_fs","forest_sa_fs"))
colnames(rezultati) <- columns_for_results

library(ggplot2)
ggplot(data, aes(x=number.of.different.ip.adress)) + geom_histogram(binwidth = 0.5) + xlim(0,50)

columns_for_shapiro = c("number.of.tickets","week.deposit.in","total.week.payin","total.week.diff",
                        "average.payin.on.ticket","average.win.odd.value","favorite.sport.payin",
                        "favorite.no..of.matches","payin.on.live","number.of.different.ip.adress")

indexes_of_columns_for_shapiro <- which(colnames(data) %in% columns_for_shapiro)

boxplot(data$payin.on.live)