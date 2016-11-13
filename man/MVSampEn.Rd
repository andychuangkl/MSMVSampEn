\name{MVSampEn}
\alias{MVSampEn}
\title{Multivariate Sample Entropy}
\usage{
    MVSampEn(mat, M, tau, r, scaleMat = TRUE)
}
\arguments{
    \item{mat}{pxn matrix containing a p-variate time series}

    \item{M}{vector of length p specifying the embedding dimension}

    \item{tau}{vector of length p specifying the time lag parameter}

    \item{r}{scalar similarity threshold}

    \item{scaleMat}{if TRUE, the rows of mat are scaled to have zero mean and unit variance}
}
\value{
    Scalar value indicating the estimated sample entropy
}
\description{
    Computes the multivariate sample entropy, as specified by Ahmed and Mandic (2011).
    The procedure is more or less a direct translation of the author's Matlab code, with several changes made for efficiency. Specifically, the embedding function has been rewritten in C++, resulting in a substantial speedup. Additionally, rather than computing the full distance matrix for the embedded delay vectors, which can easily exhaust system RAM for even moderately sized datasets, the code simply tallies the number of vectors lying within the similarity threshold.
}
\examples{
    # Generate a 3-dimensional time series containing white noise.
    data <- matrix(rnorm(3000), nrow = 3)

    # Compute entropy
    MVSampEn(data, M = c(2,2,2), tau = c(1,1,1), r = .5, scaleMat = TRUE)
}
