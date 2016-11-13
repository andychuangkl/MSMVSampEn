MVSampEn = function(mat, M, tau, r, scaleMat = TRUE){
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
  A  <- embed(mat, M, tau)
  v1 <- similarityCount(A, r)
  p1 <- 2 * v1 / (N * (N-1))

  # Error checking
  if (p1 == 0)
    stop('Zero matches found for p1. Consider increasing the tolerance r')

  I  <- diag(rep(1, nVariables))
  M2 <- matrix(rep(M, nVariables), nrow = nVariables, byrow = T) + I
  B  <- NULL
  for (i in 1:nVariables){
    dummy <- embed(mat, M2[i,], tau)
    B     <- rbind(B, dummy)
  }
  v2 <- similarityCount(B, r)
  p2 <- 2 * v2 / (nVariables * N * (nVariables * N-1))

  # Error checking
  if (p2 == 0)
    stop('Zero matches found for p2. Consider increasing the tolerance r')

  return(log(p1) - log(p2))

}
