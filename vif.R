#begin by estimating your regression model, including all RHS variables (especially the ones you suspect of multicollinearity)
#rule-of-thumb is to look for VIF>10 for a covariate in order to conclude multicollinearity, but no hard rule for such

VIF <- function(moo){
  if(class(moo)!="lm") stop("Input for arg(VIF) must be of class `lm`")
  V <- matrix(NA,ncol(model.matrix(moo))-1,1)
  for(i in 2:ncol(model.matrix(moo))){
    colnames(model.matrix(moo))[i] -> M
    paste0(M,"~",paste(colnames(model.matrix(moo))[-1][!grepl(M,colnames(model.matrix(moo))[-1])],collapse = "+")) -> f
    moo1 <- lm(f,moo$model)
    cor(moo1$model[,1],moo1$fitted.values)^2 -> R2
    1/(1-R2) -> V[i-1]
  }
  V <- as.data.frame(V)
  rownames(V) <- colnames(model.matrix(moo))[-1]
  colnames(V) <- "VIF"
  return(V)
}

#a simple example
set.seed(123)
y <- rnorm(mean = pi,sd = 3*pi/2,n = 100) #pure randomness
x1 <- runif(min = -1,max = 1,n = 100)+(y/2)^2 #less pure randomness: transformed y plus noise
x2 <- bootstrap::Rainfall[1:100]+x1*runif(min = 3,max = 5,n = 100) #annual rainfall in Nevada City, CA plus random noise
x3 <- (runif(min = 3,max = 5,n = 100)+(100*x1)^2+sqrt(abs(y)))*0.001 #combining some of the random noise
cor(x1,x2) #correlated?
cor(x1,x3) #correlated?
cor(x2,x3) #correlated?
ols <- lm(y~x1+x2+x3) #set up a linear regression
summary(ols) #watch for massive insignificance in at least one covariate
VIF(ols) #take the function for a test drive on the toy regression
