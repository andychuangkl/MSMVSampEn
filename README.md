# MSMVSampEn
R package implementing the multiscale multivariate sample entropy
measure described by Ahmed and Mandic (2011). The implementation is more or less
a direct translation of the author's Matlab code, though some changes have been
made for speed and efficiency:

* The embedding function has been rewritten in C++,
for a substantial speedup. 
* The authors estimate B<sup>m</sup>(r) by computing the full distance matrix
for the embedded delay vectors, which can easily exhaust system RAM for even
moderately sized datasets. Instead, I simply tally the number of vectors lying
within the distance threshold r, sidestepping the distance matrix calculation
entirely.

## Installation
The package can easily be installed with the `devtools` package using
```r
devtools::install_github('areshenk/MSMVSampEn')
```
Entropy is then computed using the `MSMVSampEn()` function. For example, 
to compute the entropy of a 3-variate time series containing white noise,
we create a `3xN` matrix
```r
data <- matrix(rnorm(3000), nrow = 3)
```
and then do
```r
MSMVSampEn(mat = data, M, tau, r, eps, scaleMat = T)
```
where `M` is the embedding dimension, `rau` is the time lag parameter, `r` is the 
similarity threshold, `eps` is the time scale, and `scaleMat = T` specifies that the data are scaled.

## Features
MSMVSampEn is capable of computing sample entropy for univariate or multivariate signals at arbitrary time scales. Currently, it only implements the coarsegraining procedure described by Ahmed and Mandic, although, as Humeau-Heurtier (2015) points out, this method has serious shortcomings. In the future, I hope to implement more sophistic methods of extracting informations at larger timescales. 

The package allows for the specification of an arbitrary summary statistic to be used during coarsegraining by passing a function argument to MSMVSampEn(). This function is applied to each bin during coarsegraining. When this function in the mean (default), this gives the usual sample entropy, though, as Humeau-Heurtier mentions, other statistics (such as higher moments), are occasionally interesting.

## References
Ahmed, M. U., & Mandic, D. P. (2011). Multivariate multiscale entropy: A tool for complexity analysis of multichannel data. Physical Review E, 84(6), 061918.

Humeau-Heurtier, A. (2015). The multiscale entropy algorithm and its variants: A review. Entropy, 17(5), 3110-3123.
