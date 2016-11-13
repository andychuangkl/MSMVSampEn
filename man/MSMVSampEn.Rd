\name{MSMVSampEn}
\alias{MSMVSampEn}
\title{Multivariate Multiscale Sample Entropy}
\usage{
    MSMVSampEn(mat, M, tau, r, eps = 1, scaleMat = TRUE)
}
\arguments{
    \item{mat}{pxn matrix containing a p-variate time series}

    \item{M}{vector of length p specifying the embedding dimension}

    \item{tau}{vector of length p specifying the time lag parameter}

    \item{r}{scalar similarity threshold}

    \item{eps}{Time scale parameter. eps = 1 is equivalent to MVSampEn}

    \item{scaleMat}{if TRUE, the rows of mat are scaled to have zero mean and unit variance}
}
\value{
    Scalar value indicating the estimated sample entropy at time scale eps.
}
\description{
    Convenience wrapper for \code{\link{MVSampEn}} allowing for the easy
    computation of entropy at different time scales. The function coarsegrains
    a time series according to eps, and then applies the MVSampEn() function.
}
\examples{
    # Generate a 3-dimensional time series containing white noise.
    data <- matrix(rnorm(3000), nrow = 3)

    # Compute entropy at a few timescales
    scales = 1:5
    ent <- sapply(scales,
                  function(x) MSMVSampEn(data, M = c(2,2,2), tau = c(1,1,1),
                                         r = .5, eps = x, scaleMat = TRUE))

    # Plot
    plot(scales, ent,
         xlab = 'Time Scale', ylab = 'Entropy')
}
