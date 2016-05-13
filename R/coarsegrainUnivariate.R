coarsegrainUnivariate = function(x, eps){
    # Function coarsegrains a vector x by partitioning it into bins of size eps
    # and computing the average within the bins.

    n <- length(x)
    r <- n %% eps
    return(colMeans(matrix(x[1:(n-r)], nrow = eps)))
}
