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

If you happen to modify the original matrix with which inverse was calculated
cached, then invoke `cachematrixobject$set(originalmatrix) to re-calculate
the inverse and update the cache. See the Example Usage.

### Example Usage

```
> source('cachematrix.R')

# Create original matrix
> mx <- matrix(c(7, 0, -3, 2, 3, 4, 1, -1, -2), nrow = 3, ncol = 3)

# Create the special matrix that caches the inverse of the original
> cmx <- makeCacheMatrix(mx)

# First time, calculates inverse and caches the result
> cacheSolve(cmx)
     [,1] [,2] [,3]
[1,]   -2    8   -5
[2,]    3  -11    7
[3,]    9  -34   21

#  Second time onwards, cached inverse is returned
> cacheSolve(cmx)
getting cached data
     [,1] [,2] [,3]
[1,]   -2    8   -5
[2,]    3  -11    7
[3,]    9  -34   21

# If you make changes to original matrix, then use set function to recalculate cached inverse
> mx <- matrix(c(1, 0, 5, 2, 1, 6, 3, 4, 0), nrow = 3, ncol = 3)
> cacheSolve(cmx)
getting cached data
     [,1] [,2] [,3]
[1,]   -2    8   -5
[2,]    3  -11    7
[3,]    9  -34   21

# Did you notice above that cacheSolve returned old cached inverse?
# Use set function and retry cacheSolve to get recalculated inverse
> cmx$set(mx)
> cacheSolve(cmx)
     [,1] [,2] [,3]
[1,]  -24   18    5
[2,]   20  -15   -4
[3,]   -5    4    1
> 
```
