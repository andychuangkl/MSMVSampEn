# MSMVSampEn
R package (in progress) implementing the multiscale multivariate sample entropy
measure described by Ahmed and Mandic (2011). The implementation is more or less
a direct translation of the author's Matlab code, though some changes have been
made for speed an efficiency:

* The embedding function has been rewritten in C++,
for a substantial speedup. 
* The authors estimate B<sup>m</sup>(r) by computing the full distance matrix
for the embedded delay vectors, which can easily exhaust system RAM for even
moderately sized datasets. Instead, I simply tally the number of vectors lying
within the distance threshold r, sidestepping the distance matrix calculation
entirely.

Ahmed, M. U., & Mandic, D. P. (2011). Multivariate multiscale entropy: A tool for complexity analysis of multichannel data. Physical Review E, 84(6), 061918.
