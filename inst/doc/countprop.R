## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(countprop)
data(singlecell)

head(singlecell, 2)

## ----mle----------------------------------------------------------------------
mle <- mleLR(singlecell)

# Maximum likelihood estimates of model parameters
mle$mu
mle$Sigma.inv

## ----lambdaselect-------------------------------------------------------------
mle2 <- mlePath(singlecell, n.lambda=10, n.cores=1)
mle2$min.idx # Index of smallest lambda value

# Plot EBIC for different lambda values
ebicPlot(mle2)

## ----lambdaselect2------------------------------------------------------------
mle3 <- mlePath(singlecell, n.lambda=10, lambda.min.ratio = 0.0001, n.cores=1)
mle3$min.idx

ebicPlot(mle3)

## ----lnvariation--------------------------------------------------------------
# Variation matrix
logitNormalVariation(mle3$est.min$mu, mle3$est.min$Sigma)

# Phi matrix
logitNormalVariation(mle3$est.min$mu, mle3$est.min$Sigma, type="phi")

# Rho matrix
logitNormalVariation(mle3$est.min$mu, mle3$est.min$Sigma, type="rho")

## ----naivevar-----------------------------------------------------------------
# Naive (empirical) variation matrix
naiveVariation(singlecell)

# Naive (empirical) Phi matrix
naiveVariation(singlecell, type="phi")

# Naive (empirical) Rho matrix
naiveVariation(singlecell, type="rho")

