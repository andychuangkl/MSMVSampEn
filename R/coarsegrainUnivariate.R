coarsegrainUnivariate = function(x, eps, fun = mean, ...){
    # Function coarsegrains a vector x by partitioning it into bins of size eps
    # and computing the average within the bins.

    n <- length(x)
    r <- n %% eps
    return(apply(matrix(x[1:(n-r)], nrow = eps), 2, function(i) fun(i, ...)))
}
