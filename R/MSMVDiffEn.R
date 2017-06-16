MSMVDiffEn = function(mat, M, tau, r, eps = 1, breaks = 100, 
                      scaleMat = TRUE, fun = mean, ...){
    # Wrapper for entropy.R that allows the user to specify an integer scale
    # parameter eps. The time series is coarsegrained, and then the entropy is
    # computed for the specified time scale.
    #
    # Function accepts six arguments:
    #   mat:      A pxn matrix containing a p-variate time series
    #   M:        A vector of length p specifying the embedding dimension
    #   tau:      A vector of length p specifying the time lag parameter
    #   r:        The similarity threshold
    #   eps:      An integer specifying the time scale
    #   scaleMat: Whether or not to scale the rows of the time series
    
    X <- coarsegrainMultivariate(mat, eps, fun, ...)
    return(MVDiffEn(X, M, tau, r, breaks, scaleMat))
}
