#3
attach(faithful)
hist(faithful$waiting,xlab = 'waiting',probability = T,col='pink',main='')
mlemod1 <- function(theta,data){
  alpha = theta[1]
  s1 = theta[2]
  mu = theta[3]
  s2 = theta[4]
  p = 
}
#5
library(quantmod)
getSymbols('TCS.NS')
tail(TCS.NS)
plot(TCS.NS$TCS.NS.Adjusted)
getSymbols('^NSEI')
tail(NSEI)
plot(NSEI$NSEI.Adjusted)
TCS_rt = diff(log(TCS.NS$TCS.NS.Adjusted))
Nifty_rt = diff(log(NSEI$NSEI.Adjusted))
retrn = cbind.xts(TCS_rt,Nifty_rt)
retrn = na.omit(data.frame(retrn))
plot(retrn$NSEI.Adjusted,retrn$TCS.NS.Adjusted
     ,pch=20
     ,xlab='Market Return'
     ,ylab='TCS Return'
     ,xlim=c(-0.18,0.18)
     ,ylim=c(-0.18,0.18))
grid(col='grey',lty=1)
#rtcs = a + b rni + error
rtcs = mean(retrn$TCS.NS.Adjusted)
rni = mean(retrn$NSEI.Adjusted)
row = cor(retrn$TCS.NS.Adjusted,retrn$NSEI.Adjusted)
sdtcs = sqrt(var(retrn$TCS.NS.Adjusted))
sdnifty = sqrt(var(retrn$NSEI.Adjusted))
n = nrow(retrn)
b1 = row*(sdtcs/sdnifty)
a1 = sdtcs - b1*sdnifty
lin_mod = summary(lm(TCS.NS.Adjusted~NSEI.Adjusted, data = retrn))
a2 = lin_mod$coefficients [1,1]
b2 = lin_mod$coefficients [2,1]
rtcs_hat = a1 + b1 * retrn$NSEI.Adjusted
error = retrn$TCS.NS.Adjusted - rtcs_hat
sigma1 = sqrt(var(error))
Method_of_Moments <- c(a1,b1,sigma1)
k = (n-2)/n
errornew = retrn$TCS.NS.Adjusted - (a2+ b2*retrn$NSEI.Adjusted)
sigma2 = (sqrt(var(errornew)))*k
OLS <- c(a2,b2, sigma2)
Parameters <- c("alpha", "beta", "sigma")
table = data.frame(Parameters, Method_of_Moments,OLS)
table
est1 = 3200 - ( 200*b1)
est2 = 3200 - ( 200*b2)
