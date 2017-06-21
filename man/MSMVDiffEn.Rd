\name{MSMVSampEn}
\alias{MSMVSampEn}
\title{Multivariate Multiscale Differential Entropy}
\usage{
    MSMVSampEn(mat, M, tau, r, eps = 1, 
               scaleMat = TRUE, fun = mean, ...)
}
\arguments{
    \item{mat}{pxn matrix containing a p-variate time series}

    \item{M}{vector of length p specifying the embedding dimension}

    \item{tau}{vector of length p specifying the time lag parameter}

    \item{eps}{Time scale parameter. eps = 1 is equivalent to MVSampEn}

    \item{scaleMat}{if TRUE, the rows of mat are scaled to have zero mean and unit variance. Importantly, the scaling takes place after coarsegraining. This is important because coarsegraining reduces the volatility of a time series, so that a fixed similarity threshold r actually results in a more relaxed tolerance at larger timescales, which can confound the entropy estimates. Scaling the data after coarsegraining allows r to be specified as a fixed proportion of the sample variance. This should always be set to true unless the user wishes to perform some form of manual scaling.}
                    
    \item{fun}{By default, coarsegraining is accomplished by segmenting the time series into bins of length eps, and then computing the mean within each bin. Occassionally, it is interesting to examine summary statistics other than the mean; for example, computing the variance within each bin allows for the analysis of the volatility of the time series at different time scales. The default is 'mean', but alternative functions can be supplied here. The user should be aware that certain functions, such as the variance, require a minimum number of observations, and so may not work with very small time scales.}
               
    \item{...}{Optional parameters to be passed to 'fun'}}
\value{Scalar value indicating the estimated sample entropy at time scale eps.}

\description{Convenience wrapper for \code{\link{MVDiffEn}} allowing for the easy computation of entropy at different time scales. The function coarsegrains a time series according to eps, and then applies the MVDiffEn() function.}
\examples{
# Generate a 3-dimensional time series containing white noise.
data <- matrix(rnorm(3000), nrow = 3)

# Compute entropy at a few timescales
scales = 1:5
ent <- sapply(scales,
              function(x) MSMVDiffEn(data, M = c(2,2,2), tau = c(1,1,1),
                                     eps = x, scaleMat = TRUE))

# Plot
plot(scales, ent,
     xlab = 'Time Scale', ylab = 'Entropy')
     
# Examine the volatility of the time series at a longer scale
MSMVSampEn(data, M = c(2,2,2), tau = c(1,1,1),
           eps = 10, scaleMat = TRUE,
           fun = var)
}
