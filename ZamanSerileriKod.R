library(readxl)
library(psych)
library(fpp)


g3 <- read_excel(".../zaman serileri veri.xlsx", sheet = "TP YISGUCU2 G3")
str(g3)
sum(is.na(g3)) # 0





# zaman serisi olarak tanimlama
data_ts <- ts(g3$Data, frequency = 12, start = c(2014, 01))



# zaman serisinin grafigi
ts.plot(data_ts,gpars=list(xlab="Zaman", ylab="Istihdam"))



# serinin ACF ve PACF grafikleri
library(forecast)
Acf(data_ts, lag.max = length(data_ts)/2, ylim=c(-1,1), lwd=3)
Pacf(data_ts, lag.max = length(data_ts)/2, ylim=c(-1,1), lwd=3)

# Serideki dongunun tamamini incelemek icin grafikler gecikme uzunlugu maksimum olacak sekilde cizildi
Acf(data_ts, lag.max = length(data_ts), ylim=c(-1,1), lwd=3)
Pacf(data_ts, lag.max = length(data_ts), ylim=c(-1,1), lwd=3)


# serinin mevsimsellik periyodu
decompose_data <- decompose(data_ts)
autoplot(decompose_data) # mevsimsel periyot = 12







################################################################################
# toplamsal ayristirma
################################################################################

# Merkezsel Hareketli Ortalama 
maofdata_ts<- ma(data_ts, order = 12, centre = TRUE)  # germe sayisi = 12
length(maofdata_ts)

# Mevsimsel bileseni (hata terimi de mevcut)
mevsim <- data_ts - maofdata_ts

# Mevsim serisinin ortalamalari
donemort <- t(matrix(data = mevsim, nrow = 12, ncol = 108/12))

colMeans(donemort, na.rm = T)
sum(colMeans(donemort, na.rm = T))
mean(colMeans(donemort, na.rm = T))

# mevsimsel endeks degerlerinin hesabi
endeks <- colMeans(donemort, na.rm = T)- mean(colMeans(donemort, na.rm = T))
length(endeks)

# endeks degerlerini seri boyunca yazdirma islemi
indeks<-  matrix(data = endeks, nrow = 108)
length(indeks)


# trent bileseni (hata terimi de mevcut)
trenthata<- data_ts-indeks


# seriyi hatadan arindirmak icin trenthata serisine dogrusal regresyon islemi uygulanir.
trent <- tslm(trenthata[, 1]~trend) #ciktida yer alan fitted values orijinal serinin trent bilesenidir. 


# tahmin serisi (mevsimsel endeks + saf trent serisi)
tahmin <- indeks + trent[["fitted.values"]]


# orijinal seri ile tahmin serisinin uyumu
plot(window(data_ts), ylab="", xlab = "", lty=1, col=4, lwd=2, main = "Toplamsal Ayristirma Modeli")
lines(window(tahmin), lty=3, col=2, lwd=3)
legend("topleft", c(expression(paste(Orjinalseri)), expression(paste(ToplamsalModelTahmin))), 
       lwd=c(2,2), lty=c(1,3), cex=0.7, col=c(4,2))



# Modelin Guvenilirligi
# hata serisi
hata<- data_ts-indeks-trent[["fitted.values"]]

Box.test (hata, lag = 50, type = "Ljung")
Box.test (hata, lag = 107, type = "Ljung")
# p < 0.05, hatalar ak akgurultu degil

par(mfrow=c(2,1))
Acf(hata, main="Toplamsal Model Hata", lag.max = length(hata), ylim=c(-1,1), lwd=3)
Pacf(hata, main=NA, lag.max = length(hata), ylim=c(-1,1), lwd=3)
# hatalar ak akgurultu degil
par(mfrow=c(1,1))











################################################################################
# Carpimsal model
################################################################################
mevsim2 <- data_ts/maofdata_ts

donemort2 <- t(matrix(data=mevsim2, nrow = 12, ncol = 108/12))

colMeans(donemort2, na.rm = T)
sum(colMeans(donemort2, na.rm = T))
mean(colMeans(donemort2, na.rm = T))


endeks2 <- colMeans(donemort2, na.rm = T)/mean(colMeans(donemort2, na.rm = T))

indeks2 <-  matrix(data = endeks2, nrow = 108)

trenthata2 <- data_ts/indeks2
str(trenthata2)

trent2 <- tslm(trenthata2[, 1]~trend)

tahmin2 <- indeks2*trent2[["fitted.values"]]


# orijinal seri ile tahmin serisinin uyumu
plot(window(data_ts), ylab="", xlab="", lty=1, col=4, lwd=2, main = "Carpimsal Ayristirma Modeli")
lines(window(tahmin2), lty=3, col=2, lwd=3)
legend("topleft",c(expression(paste(Orjinalseri)), expression(paste(CarpimsalTahmin))),
       lwd=c(2,2),lty=c(1,3), cex=0.6, col=c(4,2))



# Modelin Guvenilirligi
hata2 <- data_ts-tahmin2

Box.test (hata2, lag = 50, type = "Ljung")
Box.test (hata2, lag = 107, type = "Ljung")
# p < 0.05, hatalar ak akgurultu degil

par(mfrow=c(2,1))
Acf(hata2, main="Carpimsal Hata", lag.max = length(hata2), ylim=c(-1,1), lwd=3)
Pacf(hata2, main=NA, lag.max = length(hata2), ylim=c(-1,1), lwd=3)
# hatalar ak akgurultu degil

par(mfrow=c(1,1))




################################################################################
# 2 modelin karsilastirilmasi
################################################################################
plot(window(data_ts), ylab="", xlab = "", lty=1, col=4, lwd=2)
lines(window(tahmin), lty=3, col=2, lwd=3)
lines(window(tahmin2), lty=2, col=3, lwd=3)
legend("topleft", c(expression(paste(Orjinalseri)), expression(paste(T_Tahmin)), expression(paste(C_Tamin))), 
       lwd=c(2,2,2), lty=c(1,3,2), cex=0.7, col=c(4,2,3))











###########################################################################
# Holt-Winters
###########################################################################
Holt <- ets(data_ts, model = "AAN")
summary(Holt)


tahmin_holt <- Holt[["fitted"]]


ongoru_holt <- forecast(Holt, h=5)
str(ongoru_holt)
ongoru_holt[["mean"]]

plot( window(data_ts), xlab="", ylab="",lty=1, col=4, lwd=2, xlim = c(2014, 2024), main = "Holt-Winters Modeli")
lines(window(tahmin_holt), lty=3, col=2, lwd=3)
lines(window(ongoru_holt[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(Orjinalseri)),expression(paste(H-WTahmin)), expression(paste(H-W.ongoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))




#hata serisi
hata_holt <- Holt[["residuals"]]


# Modelin Guvenilirligi
Box.test (hata_holt, lag = 50, type = "Ljung")
Box.test (hata_holt, lag = 107, type = "Ljung")


par(mfrow=c(2,1))
Acf(hata_holt, main="Holt-Winters Modeli Hata", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_holt, main=NA,lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))


checkresiduals(Holt)
checkresiduals(Holt, lag = 107)
# hatalar ak akgurultu degil










################################################################################
# Toplamsal Winters Yontemi 
################################################################################

Winters1<- ets(data_ts, model = "AAA")

summary(Winters1)

tahmin_winters1 <- Winters1[["fitted"]]


ongoru_winters1 <- forecast(Winters1, h=5)
ongoru_winters1[["mean"]]


plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024), main = "Toplamsal Winters Modeli")
lines(window(tahmin_winters1), lty=3, col=2, lwd=3)
lines(window(ongoru_winters1[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(ToplamsalWintersTahmin)), expression(paste(ToplamsalWintersOngoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))



# Modelin Guvenilirligi
hata_winters1 <- Winters1[["residuals"]]

Box.test (hata_winters1, lag = 50, type = "Ljung")
Box.test (hata_winters1, lag = 107, type = "Ljung")
# hatalar beyaz gurultu


par(mfrow=c(2,1))
Acf(hata_winters1, main="Toplamsal Winters Hata", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_winters1, main=NA,lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))

checkresiduals(Winters1, lag = 107)









################################################################################
# Carpimsal Winters Yontemi 
################################################################################

Winters2 <- ets(data_ts, model = "MAM")

summary(Winters2)


tahmin_winters2 <- Winters2[["fitted"]]


ongoru_winters2 <- forecast(Winters2, h=5)
ongoru_winters2[["mean"]]


plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024), main = "Carpimsal Winters Modeli")
lines(window(tahmin_winters2), lty=3, col=2, lwd=3)
lines(window(ongoru_winters2[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(CarpimsalWintersTahmin)), expression(paste(CarpimsalWintersOngoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))




# Modelin Guvenilirligi
hata_winters2 <- Winters2[["residuals"]]

Box.test (hata_winters2, lag = 50, type = "Ljung")
Box.test (hata_winters2, lag = 107, type = "Ljung")
# hatalar beyaz gurultu


par(mfrow=c(2,1))
Acf(hata_winters2, main="Carpimsal Winters Hata", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_winters2, main=NA,lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))

checkresiduals(Winters2, lag = 107)




################################################################################
# 2 modelin karsilastirilmasi
################################################################################

plot( window(data_ts), xlab="", ylab="",lty=1, col=4, lwd=2, xlim = c(2014, 2024))
lines(window(tahmin_winters1), lty=3, col=2, lwd=3)
lines(window(ongoru_winters1[["mean"]]), lty=1, col=2, lwd=3)
lines(window(tahmin_winters2), lty=3, col=3, lwd=3)
lines(window(ongoru_winters2[["mean"]]), lty=1, col=3, lwd=3)
legend("topleft", c(expression(paste(Orjinalseri)),
                    expression(paste(ToplamsalWintersTahmin)), expression(paste(ToplamsalWintersOngoru)),
                    expression(paste(CarpimsalWintersTahmin)), expression(paste(CarpimsalWintersOngoru))),
       lwd=c(2,3,3,3,3),lty=c(1,3,1,3,1), cex=0.7, col=c(4,2,2,3,3))










################################################################################
# ARIMA
################################################################################
library(lmtest)
# serinin duraganlastirilmasi
diff_data_ts <- diff(data_ts, lag = 1) # duragan degil

par(mfrow=c(2,1))
Acf(diff_data_ts, lag.max = 107, ylim=c(-1,1), lwd=3, main = "1. fark istihdam serisi")
Pacf(diff_data_ts, lag.max = 107, ylim=c(-1,1), lwd=3, main = NA)

Box.test (diff_data_ts, lag = 50, type = "Ljung")
Box.test (diff_data_ts, lag = 106, type = "Ljung")



diff2_data_ts <- diff(data_ts, lag = 2) # duragan degil

Acf(diff2_data_ts, lag.max = 106, ylim=c(-1,1), lwd=3, main = "2. fark istihdam serisi")
Pacf(diff2_data_ts, lag.max = 106, ylim=c(-1,1), lwd=3, main = NA)

Box.test (diff2_data_ts, lag = 50, type = "Ljung")
Box.test (diff2_data_ts, lag = 105, type = "Ljung")



diff3_data_ts <- diff(data_ts, lag = 3) # duragan degil

Acf(diff3_data_ts, lag.max = 105, ylim=c(-1,1), lwd=3, main = "3. fark istihdam serisi")
Pacf(diff3_data_ts, lag.max = 105, ylim=c(-1,1), lwd=3, main = NA)

Box.test (diff3_data_ts, lag = 50, type = "Ljung")
Box.test (diff3_data_ts, lag = 104, type = "Ljung")

par(mfrow=c(1,1))



# ARIMA(1,0,0)
arima1 <- Arima(data_ts, order = c(1,0,0), include.constant = TRUE)
summary(arima1)
coeftest(arima1)

tahmin_arima1 <- arima1[["fitted"]]

ongoru_arima1 <- forecast(arima1, h=5)

plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024), main = "ARIMA(1,0,0)")
lines(window(tahmin_arima1), lty=3, col=2, lwd=3)
lines(window(ongoru_arima1[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(ARIMA100Tahmin)), expression(paste(ARIMA100Ongoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))


# Modelin Guvenilirligi
hata_arima1 <- arima1[["residuals"]]
Box.test (hata_arima1, lag = 50, type = "Ljung")
Box.test (hata_arima1, lag = 107, type = "Ljung")

checkresiduals(arima1, lag = 107)
# hatalar ak akgurultu degil

par(mfrow=c(2,1))
Acf(hata_arima1, main="Hata ARIMA(1,0,0)", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_arima1, main=NA,lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))







# ARIMA(1,1,0)
arima2 <- Arima(data_ts, order = c(1,1,0), include.constant = TRUE)
summary(arima2)
coeftest(arima2)

tahmin_arima2 <- arima2[["fitted"]]

ongoru_arima2 <- forecast(arima2, h=5)

plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024), main = "ARIMA(1,1,0)")
lines(window(tahmin_arima2), lty=3, col=2, lwd=3)
lines(window(ongoru_arima2[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(ARIMA110Tahmin)), expression(paste(ARIMA110Ongoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))


# Modelin Guvenilirligi
# hatalar akgurultu mu?
hata_arima2 <- arima2[["residuals"]]
Box.test (hata_arima2, lag = 50, type = "Ljung")
Box.test (hata_arima2, lag = 107, type = "Ljung")

checkresiduals(arima2, lag = 107)
# hatalar ak akgurultu degil

par(mfrow=c(2,1))
Acf(hata_arima2, main="Hata ARIMA(1,1,0)", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_arima2, main=NA,lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))





# ARIMA(2,1,0)
arima3 <- Arima(data_ts, order = c(2,1,0), include.constant = TRUE)
summary(arima3)
coeftest(arima3)

tahmin_arima3 <- arima3[["fitted"]]

ongoru_arima3 <- forecast(arima3, h=5)

plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024))
lines(window(tahmin_arima3), lty=3, col=2, lwd=3)
lines(window(ongoru_arima3[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(ARIMA210Tahmin)), expression(paste(ARIMA210Ongoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))


# Modelin Guvenilirligi
hata_arima3 <- arima3[["residuals"]]
Box.test (hata_arima3, lag = 50, type = "Ljung")
Box.test (hata_arima3, lag = 107, type = "Ljung")

checkresiduals(arima3, lag = 107)
# hatalar ak akgurultu degil

Acf(hata_arima3, main="Hata AR??MA(2,1,0)", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_arima3, main="Hata AR??MA(2,1,0)",lag.max = 108, ylim=c(-1,1), lwd=3)






plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024))
lines(window(tahmin_arima1), lty=3, col=2, lwd=3)
lines(window(ongoru_arima1[["mean"]]), lty=1, col=2, lwd=3)
lines(window(tahmin_arima2), lty=3, col=3, lwd=3)
lines(window(ongoru_arima2[["mean"]]), lty=1, col=3, lwd=3)
lines(window(tahmin_arima3), lty=3, col=7, lwd=3)
lines(window(ongoru_arima3[["mean"]]), lty=1, col=7, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),
                    expression(paste(ARIMA100Tahmin)), expression(paste(ARIMA100Ongoru)),
                    expression(paste(ARIMA110Tahmin)), expression(paste(ARIMA110Ongoru)),
                    expression(paste(ARIMA210Tahmin)), expression(paste(ARIMA210Ongoru))),
       lwd=c(2,3,3,3,3,3,3),lty=c(1,3,1,3,1,3,1), cex=0.7, col=c(4,2,2,3,3,7,7))









# auto.arima
auto_arima <- auto.arima(data_ts)
summary(auto_arima) # ARIMA(1,0,0)(2,1,0)[12] with drift 

tahmin_auto_arima <- auto_arima[["fitted"]]
ongoru_auto_arima <- forecast(auto_arima, h=5)


plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024), main = "SARIMA (1,0,0)(2,1,0)[12]")
lines(window(tahmin_auto_arima), lty=3, col=2, lwd=3)
lines(window(ongoru_auto_arima[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(ARIMAautoTahmin)), expression(paste(ARIMAautoOngoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))


# Modelin Guvenilirligi
hata_auto_arima <- auto_arima[["residuals"]]
Box.test (hata_auto_arima, lag = 50, type = "Ljung")
Box.test (hata_auto_arima, lag = 107, type = "Ljung")

checkresiduals(auto_arima, lag = 107)
# hatalar ak akgurultu 

par(mfrow=c(2,1))
Acf(hata_auto_arima, main="Hata SARIMA (1,0,0)(2,1,0)[12]", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_auto_arima, main=NA, lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))









# SARIMA(1, 0, 0)(1, 0, 1)
sarima1 <- Arima(data_ts, order = c(1, 0, 1), seasonal = c(1, 0, 1))
coeftest(sarima1)
summary(sarima1)

tahmin_sarima1 <- sarima1[["fitted"]]

ongoru_sarima1 <- forecast(sarima1, h=5)

plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024))
lines(window(tahmin_sarima1), lty=3, col=2, lwd=3)
lines(window(ongoru_sarima1[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(SARIMA1Tahmin)), expression(paste(SARIMA1Ongoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))


# Modelin Guvenilirligi
hata_sarima1 <- sarima1[["residuals"]]
Box.test (hata_sarima1, lag = 50, type = "Ljung")
Box.test (hata_sarima1, lag = 107, type = "Ljung")

checkresiduals(sarima1, lag = 107)
# hatalar ak akgurultu degil

Acf(hata_sarima1, main="Hata SARIMA1", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_sarima1, main="Hata SARIMA1",lag.max = 108, ylim=c(-1,1), lwd=3)
# hatalar ak gurultu kabul edilebilir?







# SARIMA(1,0,0)(2,1,0)
sarima2 <- Arima(data_ts, order = c(1, 0, 0), seasonal = c(2, 1, 0))
coeftest(sarima2)
summary(sarima2)

tahmin_sarima2 <- sarima2[["fitted"]]

ongoru_sarima2 <- forecast(sarima2, h=5)

plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024))
lines(window(tahmin_sarima2), lty=3, col=2, lwd=3)
lines(window(ongoru_sarima2[["mean"]]), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(SARIMA2Tahmin)), expression(paste(SARIMA2ongoru))),
       lwd=c(2,3,3),lty=c(1,3,1), cex=0.7, col=c(4,2,2))


# Modelin Guvenilirligi
hata_sarima2 <- sarima2[["residuals"]]
Box.test (hata_sarima2, lag = 50, type = "Ljung")
Box.test (hata_sarima2, lag = 107, type = "Ljung")

checkresiduals(sarima2, lag = 107)
# hatalar ak akgurultu

Acf(hata_sarima2, main="Hata SAR??MA2", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_sarima2, main="Hata SAR??MA2",lag.max = 108, ylim=c(-1,1), lwd=3)





plot(window(data_ts), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(2014, 2024))
lines(window(tahmin_sarima1), lty=3, col=2, lwd=3)
lines(window(ongoru_sarima1[["mean"]]), lty=1, col=2, lwd=3)
lines(window(tahmin_sarima2), lty=3, col=3, lwd=3)
lines(window(ongoru_sarima2[["mean"]]), lty=1, col=3, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(SARIMA1Tahmin)), expression(paste(SARIMA1Ongoru)), 
                    expression(paste(SARIMA2Tahmin)), expression(paste(SARIMA2ongoru))),
       lwd=c(2,3,3,3,3),lty=c(1,3,1,3,1), cex=0.7, col=c(4,2,2,3,3))






# Regresyon
################################################################################
# Toplamsal dogrusal regresyon
t<-1:108   # zaman terimi


sin1 <- sin(2*3.1416*t/12)
cos1 <- cos(2*3.1416*t/12)


data_topreg <-as.data.frame(cbind(data_ts, t, sin1, cos1))
names(data_topreg)<- c("data_ts", "t", "sin1", "cos1")
str(data_topreg)

topreg_model1 <- lm(data_ts~t+sin1+cos1)
summary(topreg_model1) # Adjusted R-squared:  0.5931, tum terimler anlamli


tahmin_topreg <-predict(topreg_model1)
str(tahmin_topreg)
tahmin_topreg_sinir <- predict(topreg_model1, interval = 'confidence' ,level = .95)


t_new <- 109:113
sin_new <- sin(2*3.1416*t_new/12)
cos_new <- cos(2*3.1416*t_new/12)
new_data <- data.frame(t_new,sin_new,cos_new)
names(new_data)<- c("t", "sin1", "cos1")
ongoru_topreg <- predict(topreg_model1, newdata = new_data)
str(ongoru_topreg)
str(new_data)


data_ts2 <- ts(g3$Data, frequency = 1)
ts.plot(data_ts2,gpars=list(xlab="Zaman", ylab="Istihdam"))


plot(window(data_ts2), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(1, 120), main = "Toplamsal Regresyon Modeli")
lines(window(tahmin_topreg), lty=3, col=2, lwd=3)
lines(seq(109,113), window(ongoru_topreg), lty=1, col=2, lwd=3)
lines(window(tahmin_topreg_sinir[,2]), lty=3, col=3, lwd=3)
lines(window(tahmin_topreg_sinir[,3]), lty=3, col=3, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(TopRegTahmin)), expression(paste(TopRegOngoru)),expression(paste(TopRegTahminGA))),
       lwd=c(2,3,3,3),lty=c(1,3,1,3), cex=0.7, col=c(4,2,2,3))



# Modelin Guvenilirligi
##durbin-watson testi
dwtest(data_ts ~ t + sin1 + cos1) # hatalar ak akgurultu degil


hata_topreg <- resid(topreg_model1)
Box.test (hata_topreg, lag = 50, type = "Ljung")
Box.test (hata_topreg, lag = 107, type = "Ljung")
# hatalar ak akgurultu degil

par(mfrow=c(2,1))
Acf(hata_topreg, main="Hata Toplamsal Regresyon", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_topreg, main=NA, lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))







# toplamsal regresyon modeli 2
sin2<-sin(2*3.1416*2*t/12)
cos2<-cos(2*3.1416*2*t/12)

data_topreg2 <- as.data.frame(cbind(data_ts, t, sin1, cos1, sin2, cos2))

names(data_topreg2) <- c("data_ts", "t", "sin1", "cos1", "sin2", "cos2")


topreg_model2 <- lm(data_ts ~ t + sin1 + cos1 + sin2 + cos2)
summary(topreg_model2) # Adjusted R-squared:  0.5953,  sin2 ve cos2 anlamsiz






# toplamsal regresyon modeli 3
sin3 <- sin1^2
cos3 <- cos1^2


data_topreg3 <-as.data.frame(cbind(data_ts, t, sin1, cos1, sin3, cos3))
names(data_topreg3) <- c("data_ts", "t", "sin1", "cos1", "sin3", "cos3")

topreg_model3 <- lm(data_ts ~ t + sin1 + cos1 + sin3 + cos3)
summary(topreg_model3) # Adjusted R-squared:  0.5893, cos3 anlamsiz
topreg_model3 <- lm(data_ts ~ t + sin1 + cos1 + sin3)
summary(topreg_model3) # sin3 de anlamsiz






# Carpimsal Dogrusal Regresyon Modeli
s1<-t*sin(2*3.1416*t/12)
c1<-t*cos(2*3.1416*t/12)


data_carreg <- as.data.frame(cbind(data_ts, t, s1, c1))

names(data_carreg) <- c("data_ts", "t", "s1", "c1")

carreg_model <- lm(data_ts ~ t + s1 + c1)
summary(carreg_model) # Adjusted R-squared:  0.574, c1 anlamsiz


tahmin_carreg <-predict(carreg_model)
tahmin_carreg_sinir <- predict(carreg_model, interval = 'confidence' ,level = .95)
tahmin_carreg_sinir[,2]
tahmin_carreg_sinir[,3]


t_new <- 109:113
s_new <- t_new*sin(2*3.1416*t_new/12)
c_new <- t_new*cos(2*3.1416*t_new/12)
new_data_c <- data.frame(t_new,s_new,c_new)
names(new_data_c)<- c("t", "s1", "c1")
ongoru_carreg <- predict(carreg_model, newdata = new_data_c)



plot(window(data_ts2), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(1, 120), main = "Carpimsal Regresyon Modeli")
lines(window(tahmin_carreg), lty=3, col=2, lwd=3)
lines(window(tahmin_carreg_sinir[,2]), lty=3, col=3, lwd=3)
lines(window(tahmin_carreg_sinir[,3]), lty=3, col=3, lwd=3)
lines(seq(109,113), window(ongoru_carreg), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(CarRegTahmin)), expression(paste(CarRegOngoru)),expression(paste(CarRegTahminGA))),
       lwd=c(2,3,3,3),lty=c(1,3,1,3), cex=0.7, col=c(4,2,2,3))



# Modelin Guvenilirligi
##durbin-watson testi
dwtest(data_ts~t+s1+c1) # hatalar ak akgurultu degil

hata_carreg <- resid(carreg_model)
Box.test (hata_carreg, lag = 50, type = "Ljung")
Box.test (hata_carreg, lag = 107, type = "Ljung")
# hatalar ak akgurultu degil

par(mfrow=c(2,1))
Acf(hata_carreg, main="Hata Carpimsal Regresyon", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_carreg, main=NA, lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))
# hatalar ak akgurultu degil






# Carpimsal model 2
s2<-t*sin(2*3.1416*2*t/12)
c2<-t*cos(2*3.1416*2*t/12)


data_carreg2 <- as.data.frame(cbind(data_ts, t, s1, c1, s2, c2))

names(data_carreg2)<- c("data_ts", "t", "s1", "c1", "s2", "c2")


carreg.model2 <- lm(data_ts ~ t + s1 + c1 + s2 + c2)
summary(carreg.model2) # R-squared:  0.5708, c1, s2, c2 anlamsiz







# Karesel regresyon
t2 <- t^2


karesel_model <- lm(data_ts ~ t + t2)
summary(karesel_model) # Adjusted R-squared:  0.5081, t ve t2 anlamli degil



karesel_tahmin <- predict(karesel_model)
karesel_tahmin_sinir <- predict(karesel_model, interval = 'confidence' ,level = .95)


t_new <- 109:113
t2_new <- t_new^2
new_data_karesel <- data.frame(t_new,t2_new)
names(new_data_karesel)<- c("t", "t2")
ongoru_karesel <- predict(karesel_model, newdata = new_data_karesel)


plot(window(data_ts2), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(1, 120), main = "Karesel Regresyon Modeli")
lines(window(karesel_tahmin), lty=3, col=2, lwd=3)
lines(window(karesel_tahmin_sinir[,2]), lty=3, col=3, lwd=3)
lines(window(karesel_tahmin_sinir[,3]), lty=3, col=3, lwd=3)
lines(seq(109,113), window(ongoru_karesel), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(KareselTahmin)), expression(paste(KareselOngoru)),expression(paste(KareselTahminGA))),
       lwd=c(2,3,3,3),lty=c(1,3,1,3), cex=0.7, col=c(4,2,2,3))


# Modelin Guvenilirligi
##durbin-watson testi
dwtest(data_ts~t+t2) # hatalar ak akgurultu de??il

hata_karesel <- resid(karesel_model)
Box.test (hata_karesel, lag = 50, type = "Ljung")
Box.test (hata_karesel, lag = 107, type = "Ljung")
# hatalar ak akgurultu de??il

par(mfrow=c(2,1))
Acf(hata_karesel, main="Hata Karesel Regresyon", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_karesel, main=NA, lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))
# hatalar ak akgurultu de??il







# Kubik Regresyon
t3 <- t^3

kubik_model <- lm(data_ts ~ t + t2 + t3)
summary(kubik_model) # Adjusted R-squared:  0.6884, tum terimler anlamli



kubik_tahmin <- predict(kubik_model)
kubik_tahmin_sinir <- predict(kubik_model, interval = 'confidence' ,level = .95)


t_new <- 109:113
t2_new <- t_new^2
t3_new <- t_new^3
new_data_kubik <- data.frame(t_new,t2_new,t3_new)
names(new_data_kubik)<- c("t", "t2","t3")
ongoru_kubik <- predict(kubik_model, newdata = new_data_kubik)


plot(window(data_ts2), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(1, 120), ylim = c(24000, 33000), main = "Kubik Regresyon Modeli")
lines(window(kubik_tahmin), lty=3, col=2, lwd=3)
lines(window(kubik_tahmin_sinir[,2]), lty=3, col=3, lwd=3)
lines(window(kubik_tahmin_sinir[,3]), lty=3, col=3, lwd=3)
lines(seq(109,113), window(ongoru_kubik), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(KubikTahmin)), expression(paste(KubikOngoru)),expression(paste(KubikTahminGA))),
       lwd=c(2,3,3,3),lty=c(1,3,1,3), cex=0.7, col=c(4,2,2,3))


# Modelin Guvenilirligi
##durbin-watson testi
dwtest(data_ts~t+t2+t3) # hatalar ak akgurultu de??il

hata_kubik<- resid(kubik_model)
Box.test (hata_kubik, lag = 50, type = "Ljung")
Box.test (hata_kubik, lag = 107, type = "Ljung")
# hatalar ak akgurultu de??il

par(mfrow=c(2,1))
Acf(hata_kubik, main="Hata Kubik Regresyon", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_kubik, main=NA, lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))
# hatalar ak akgurultu de??il









# Ustel Regresyon
# log(y) = log(a) + x*log(b)

ustel_model <- lm(log(data_ts) ~ t)
summary(ustel_model) # Adjusted R-squared:  0.5065, t anlamli

ustel_tahmin <- predict(ustel_model)
ustel_tahmin<- exp(ustel_tahmin)

ustel_tahmin_sinir <- predict(ustel.model, interval='confidence',level=0.95)
ustel_tahmin_alt <- exp(ustel_tahmin_sinir[,2])
ustel_tahmin_ust <- exp(ustel_tahmin_sinir[,3])

t_new <- 109:113
new_data_ustel <- data.frame(t_new)
names(new_data_ustel)<- c("t")
ongoru_ustel <- predict(ustel_model, newdata = new_data_ustel)
ongoru_ustel <- exp(ongoru_ustel)

plot(window(data_ts2), xlab="", ylab="", lty=1, col=4, lwd=2, xlim = c(1, 120), ylim = c(24000, 33000), main = "Ustel Regresyon Modeli")
lines(window(ustel_tahmin), lty=3, col=2, lwd=3)
lines(window(ustel_tahmin_alt), lty=3, col=3, lwd=3)
lines(window(ustel_tahmin_ust), lty=3, col=3, lwd=3)
lines(seq(109,113), window(ongoru_ustel), lty=1, col=2, lwd=3)
legend("topleft", c(expression(paste(OrjinalSeri)),expression(paste(UstelTahmin)), expression(paste(UstelOngoru)),expression(paste(UstelTahminGA))),
       lwd=c(2,3,3,3),lty=c(1,3,1,3), cex=0.7, col=c(4,2,2,3))


# Modelin Guvenilirligi
##durbin-watson testi
dwtest(log(data_ts) ~ t) # hatalar ak akgurultu de??il

hata_ustel <- resid(ustel_model)
Box.test (hata_ustel, lag = 50, type = "Ljung")
Box.test (hata_ustel, lag = 107, type = "Ljung")
# hatalar ak akgurultu de??il

par(mfrow=c(2,1))
Acf(hata_ustel, main="Hata Ustel Regresyon", lag.max = 108,  ylim=c(-1,1), lwd=3)
Pacf(hata_ustel, main=NA, lag.max = 108, ylim=c(-1,1), lwd=3)
par(mfrow=c(1,1))
# hatalar ak akgurultu de??il

