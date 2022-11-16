# PBSR-Assignment
Group Assignment 2
Problem 3, 4, 5 are updated


This assignment was done by Sayantika Sengupta, Aniket Saha and Anjan Mondal. The problems 1 and 2 were done by Aniket Saha, 3 and 5 by Sayantika Sengupta and problem 4 by Anjan Mondal.

This assignment included various datasets and experiments which were modelled using various probability distributions like Gamma, lognormal, Laplace and various Mixture Models. These problems also required us to delve into model selection methods using Akaike Information Criterion and Bayesian Information Criterion. We also performed some Computational Finance techniques on TCS stock price dataset. For the TCS dataset, the daily returns of the stock price were modelled.


A Short Report on Our Work
-Sayantika, Anjan, Aniket

Question 1: 
We have determined the conditions for a geometric distribution to model X, the number of goals scored by home team.
Then we have used method of moments to get estimates of the parameters of the geometric and Poisson models and computed the given probabilities.
We have also chosen the Poisson model to be more appropriate to model X.

Question 2:
We defined a function which will give us the value of MLE based on the input data.
We have tried to understand the sampling distribution using some graphs.

Question 3:
We have fitted three models using the MLE method and computed the Akaike Information Criterion for each case.
We have found that the third model, which is a combination of 2 log-normal distributions as the best model to fit the data.
The required probability that P[60<waiting<70] is then computed to be 0.0908 (approximately).

Question 4:
We have used the insurance data set in R.
We have tried to model the variable "claim" based on a linear function of "holders".
Then, based on the nature of errors, we have used different models to estimate the parameters of the original linear model.
We have used normal, log-normal, Laplace and Gamma distributions in our problem.

Question 5:
We have downloaded the TCS dataset and calculated the daily log return and showed this using a plot.
Then we tried to come up with a model to estimate the return values based on the input data.
We have considered a linear model and estimated the parameters using the in-built 'lm function' in R.
This uses the Ordinary Least Squares method.
Then we have calculated the return values based on Nifty values in a table.
