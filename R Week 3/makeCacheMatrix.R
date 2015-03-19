## Functions to prepare the inputs
## and calculate the inverse of the mean of a matrix


## This function creates a special matrix object that can cache its inverse 

makeCacheMatrix <- function(x = matrix()) { 
                ## initialize the variable
                m <- NULL
                
                ## set the variables
                set <- function(y) {
                        x <<- y
                        m <<- NULL
                }
                
                ## set up and calculate the matrix
                get <- function() x
                setmatrix <- function(solve) m <<- solve
                getmatrix <- function() m
                
                ## list the values of the function in the frame
                list(set = set, get = get,
                     setmatrix = setmatrix,
                     getmatrix = getmatrix) 
        }





## This function computes the inverse of the matrix returned by makeCacheMatrix
## If the inverse has been previousely calculated retrieve from cache
 

cacheSolve <- function(x=matrix(), ...) {
                ## set the variable
                m <- x$getmatrix()
                
                ## check to see if the data was previously cached
                if(!is.null(m)) {
                        message("getting cached data")
                        return(m)
                }
                ## calculate the inverse
                data <- x$get()
                m <- solve(data, ...)
                x$setmatrix(m)
                
                ## display the calculated inverse
                m
        }
