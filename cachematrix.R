##
## Matrix inversion is usually a costly computation and there may be
## some benefit to caching the inverse of a matrix rather than computing
## it repeatedly. This API is to create a special matrix object that
## caches the inverse of itself.
##
## makeCacheMatrix: This function creates a special "matrix" object that can
##	cache its inverse.
##
## cacheSolve: This function computes the inverse of the special "matrix"
##	returned by makeCacheMatrix above. If the inverse has already been
##	calculated (and the matrix has not changed), then cacheSolve should
##	retrieve the inverse from the cache.
##

##
## This function creates a special "matrix" object that can cache
## its inverse.
##

makeCacheMatrix <- function(x = matrix()) {
		i <- NULL

		set <- function(y) {
			x <<- y
			i <<- NULL
		}

		get <- function() {
			x
		}

		set_inverse <- function(inverse) {
			i <<- inverse
		}

		get_inverse <- function() {
			i
		}

		list(set = set, get = get,
			set_inverse = set_inverse,
			get_inverse = get_inverse)
}


##
## This function computes the inverse of the special "matrix" returned
## by makeCacheMatrix. If the inverse has already been calculated
## then cacheSolve returns the inverse from the cache.
##
## Notes:
##   1. Assumes that the matrix is invertible
##   2. Once inverse is cached, its not invalidated on further changes to matrix
##

cacheSolve <- function(x, ...) {

		i <- x$get_inverse()

		if(!is.null(i)) {
			message("getting cached data")
			return(i)
		}

		data <- x$get()
    #print(data)
		i <- solve(data, ...)
		x$set_inverse(i)

		i
}

## End
