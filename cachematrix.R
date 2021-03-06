## The following functions are able to cache potentially 
## time-consuming inverse computation.

## The first one - makeCacheMean - creates a special 
## "matrix" object, which can cache it's inverse and is 
## actually a list containing functions to
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

## The second function computes the inverse of the "matrix"
## returned by makeCacheMatrix, but if the inverse has
## already been calculated (and the matrix has not 
## changed), the cacheSolve retrieves the inverse from
## the cache


## this fucntion creates a special "matrix" object that can
## cache its inverse

makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        set <- function(y) {
                x <<- y
                i <<- NULL
        }
        get <- function() x
        setinverse <- function(inverse) i <<- inverse
        getinverse <- function() i
        list(set = set,
             get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}

## this function computes the inverse of the "matrix"
## returned by makeCacheMatrix or retrieves the inverse
## from the cache

cacheSolve <- function(x, ...) {
        i <- x$getinverse()
        if (!is.null(i)) {
                message("getting cached data")
                return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setinverse(i)
        i
}