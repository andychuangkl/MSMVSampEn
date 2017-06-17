MVDiffEn = function(mat, M, tau, r, breaks = 100, scaleMat = TRUE){
    # Returns the multivariate entropy of a time series. Function accepts
    # five arguments:
    #   mat:      A pxn matrix containing a p-variate time series
    #   M:        A vector of length p specifying the embedding dimension
    #   tau:      A vector of length p specifying the time lag parameter
    #   r:        The similarity threshold
    #   scaleMat: Whether or not to scale the rows of the time series
    
    # Error Handling
    if (!is.matrix(mat))
        stop('mat must be a matrix')
    
    if (!(is.numeric(M) && length(M) == dim(mat)[1]))
        stop('M must be a vector of length equals to the rows of mat')
    
    if (any(M <= 0))
        stop('M must be positive')
    
    if (!(is.numeric(tau) && length(tau) == dim(mat)[1]))
        stop('M must be a vector of length equals to the rows of mat')
    
    if (any(tau <= 0))
        stop('tau must be positive')
    
    # Scale data if necessary
    if (scaleMat) mat <- t(scale(t(mat)))
    
    #
    nVariables <- dim(mat)[1]
    nSamples   <- dim(mat)[2]
    
    MMax   <- max(M)
    tauMax <- max(tau)
    nn     <- MMax * tauMax
    
    # Count the number of match templates of length m closed within
    # the tolerance r.
    N  <- nSamples - nn
    A  <- MSMVSampEn:::vectorEmbed(mat, M, tau)
    
    # Do entropy piecewise if too many observations
    k <- dim(A)[1]
    if (k <= 1000){
        d  <- dist(A, method = 'maximum')
        p  <- hist(d, plot = F, breaks = breaks)$density
        p <- p[-which(p == 0)]
        ent <-  -1/(length(p)) * sum(p * log(p, base = 2))
        return(ent)
    } else {
        pad <- c(1:k, rep(NA, 1000 - k %% 1000))
        idx <- matrix(sample(pad, length(pad)),
                      nrow = length(pad) / 1000)
        ent <- numeric(dim(idx)[1])
        for (i in 1:length(ent)){
            idx.dummy <- idx[i,]
            idx.dummy <- idx.dummy[!is.na(idx.dummy)]
            dummy <- A[idx.dummy,]
            d  <- dist(dummy, method = 'maximum')
            p  <- hist(d, plot = F, breaks = breaks)$density
            p  <- p[p != 0]
            ent[i] <-  -1/(length(p)) * sum(p * log(p, base = 2))
        }
        return(mean(ent))
    }
}
