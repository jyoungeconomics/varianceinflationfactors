This is some R code for both creating the function for variance inflation factors (VIFs) as well as a quick example tacked on at the end of the script.
Essentially, the function takes an object of class "lm" or linear model and computes the Rsquared for subsequent cross-covariate regressions - once for each covariate on all other covariates.
The reciprocal of 1-Rsquared is the VIF, computed once for each cross-covariate regression.
A rule-of-thumb is to watch for any VIF>10 to call out that covariate as bringing about your multicollinearity.
As of now, there are no visualizations for the VIFs, that will come in a subsequent update given enough time.
