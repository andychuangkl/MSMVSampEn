\name{MVDiffEn}
\alias{MVDiffEn}
\title{Multivariate Differential Entropy}
\usage{
    MVDiffEn(mat, M, tau, scaleMat = TRUE)
}
\arguments{
    \item{mat}{pxn matrix containing a p-variate time series}

    \item{M}{vector of length p specifying the embedding dimension}

    \item{tau}{vector of length p specifying the time lag parameter}

    \item{scaleMat}{if TRUE, the rows of mat are scaled to have zero mean and unit variance}
}
\value{
    Scalar value indicating the estimated differential entropy
}
\description{
    Computes the multivariate differential (technically, "distribution") entropy, as specified by Karmakar (2015). Unlike SampEn, DiffEn computes the entropy of the distribution of pairwise distances of the embedded delay vectors. Because this requires storing all elements of the distance matrix in memory, large datasets can easily exhaust system RAM. For this reason, pairwise distances are randomly computed 1000 at a time, and the entropy is averaged over each sample of 1000.
}
\examples{
    # Generate a 3-dimensional time series containing white noise.
    data <- matrix(rnorm(3000), nrow = 3)

    # Compute entropy
    MVDiffEn(data, M = c(2,2,2), tau = c(1,1,1), scaleMat = TRUE)
}
