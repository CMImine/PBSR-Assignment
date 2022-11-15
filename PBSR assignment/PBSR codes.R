#3

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


##==============================================================================================================
##==============================================================================================================
##Problem 4
library(ggplot2)
library(MASS)
library(stats)
plot(Insurance$Holders,Insurance$Claims
     ,xlab = 'Holders',ylab='Claims',pch=20)
grid()


############   PART A   ####################
#Claimsi = β0 + β1 Holdersi + εi, i = 1, 2, · · · , n

# Claimsi ∼ N(μi, σ2), where
#μi = β0 + β1 Holdersi + εi, i = 1, 2, · · · , n


# Neg log likelihood

NegLogLike<- function(theta,data){
  sigma = theta[3]
  n = nrow(data)
  l=0
  for(i in 1:n){
    mu = theta[1]+theta[2]*data$Holders[i]
    l = l + log(dnorm(data$Claims[i],mean = mu,sd=sigma))
  }
  return(-l)
}


theta_initial=c(0.01,0.1,10)
NegLogLike(theta_initial,Insurance)

fit = optim(theta_initial
            ,NegLogLike
            ,data=Insurance,
            lower = 0, upper = Inf)
ggplot(data=Insurance)+geom_line(aes(Holders, fit$par[1]+fit$par[2]*Holders))+geom_point(aes(Holders,Claims))
theta_hat = fit$par
theta_hat



BIC=2*NegLogLike(theta_hat,Insurance)+log(nrow(Insurance))*2

BIC


#---------------------------------------------------------#

#### PART B ######


#Claimsi = β0 + β1 Holdersi + εi, i = 1, 2, · · · , n
#Assume : εi ∼ Laplace(0, σ2). Note that β0, β1 ∈ R and σ ∈ R+.
#(i) Clearly write down the negative-log-likelihood function in R. Then use optim function to estimate MLE
##of θ = (β0, β1, σ)
#(ii) Calculate Bayesian Information Criterion (BIC) for the model.


laplace<-function(x,loc, b){
  exp(-abs(x-loc)/b)/(2*b)
}


NegLogLike<- function(theta,data){
  sigma = theta[3]
  n = nrow(data)
  l=0
  for(i in 1:n){
    mu = theta[1]+theta[2]*data$Holders[i]
    l = l + log(laplace(data$Claims[i],loc = mu,b = sigma))
    #print(l)
  }
  return(-l)
}



theta_initial=c(8,0.1,10)
NegLogLike(theta_initial,Insurance)

fit = optim(theta_initial
            ,NegLogLike
            ,data=Insurance)


ggplot(data=Insurance)+geom_line(aes(Holders, fit$par[1]+fit$par[2]*Holders))+geom_point(aes(Holders,Claims))
theta_hat = fit$par
theta_hat



BIC=2*NegLogLike(theta_hat,Insurance)+log(nrow(Insurance))*2
BIC




####PART C



dataIn=Insurance[-c(61),]
NegLogLike<- function(theta,data){
  sigma = theta[3]
  n = nrow(data)
  l=0
  for(i in 1:n){
    mu = theta[1]+theta[2]*data$Holders[i]
    l = l + log(dlnorm(data$Claims[i],meanlog = mu,sdlog = sigma))
    
  }
  return(-l)
}


theta_initial=c(1,0.1,10)
NegLogLike(theta_initial,dataIn)

fit = optim(theta_initial
            ,NegLogLike
            ,data=dataIn)

ggplot(data=dataIn)+geom_line(aes(Holders, fit$par[1]+fit$par[2]*Holders))+
  geom_point(aes(Holders,Claims))
theta_hat = fit$par
theta_hat



BIC=2*NegLogLike(theta_hat,dataIn)+log(nrow(dataIn))*2
BIC


## PART D



NegLogLike<- function(theta,data){
  sigma = theta[3]
  n = nrow(data)
  l=0
  for(i in 1:n){
    if (data$Claims[i]!=0){
    mu = theta[1]+theta[2]*data$Holders[i]
    l = l + log(dgamma(data$Claims[i],shape = mu,scale = sigma))
    #print(l)
    
    }
  }
  return(-l)
}

theta_initial=c(1,0.1,1)
NegLogLike(theta_initial,Insurance)


fit = optim(theta_initial
            ,NegLogLike
            ,data=Insurance)


theta_hat = fit$par
theta_hat
BIC=2*NegLogLike(theta_hat,Insurance)+log(nrow(Insurance))*2
BIC


#=======================================================================================================================================================
