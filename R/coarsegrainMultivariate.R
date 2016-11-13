coarsegrainMultivariate = function(mat, eps){
    # Function coarsegrains a multivariate time series given by a
    # pxn matrix mat (where p is the number of variables)
    return(t(apply(mat, 1, function(x) MSMVSampEn:::coarsegrainUnivariate(x, eps))))
}
