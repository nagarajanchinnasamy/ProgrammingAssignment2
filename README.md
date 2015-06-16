### Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly. This API is to create a special matrix object that can cache its
inverse.

### API

This API has following two functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.  Note: It is assumed that the matrix
    supplied to makeCacheMatrix is always invertible.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` retrieves the inverse from the cache.

Computing the inverse of a square matrix is done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.


### Example Usage

> source('cachematrix.R')
> mx <- matrix(c(7, 0, -3, 2, 3, 4, 1, -1, -2), nrow = 3, ncol = 3)
> cmx <- makeCacheMatrix(mx)
> cacheSolve(cmx)
     [,1] [,2] [,3]
     [1,]   -2    8   -5
     [2,]    3  -11    7
     [3,]    9  -34   21
> cacheSolve(cmx)
getting cached data
     [,1] [,2] [,3]
[1,]   -2    8   -5
[2,]    3  -11    7
[3,]    9  -34   21
> 
