##' Fast approximation
##' 
##' Fast approximation
##' @param time Original ordered time points
##' @param new.time New time points
##' @param equal If TRUE a list is returned with additional element
##' @param type Type of matching, nearest index, nearest greater than
##'     or equal (right), number of elements smaller than y otherwise
##'     the closest value above new.time is returned.
##' @param sorted Set to true if new.time is already sorted
##' @param ... Optional additional arguments
##' @author Klaus K. Holst
##' @examples
##' id <- c(1,1,2,2,7,7,10,10)
##' fast.approx(unique(id),id)
##' 
##' t <- 0:6
##' n <- c(-1,0,0.1,0.9,1,1.1,1.2,6,6.5)
##' fast.approx(t,n,type="left")
##' @aliases  indexstrata
##' @export
fast.approx <- function(time,new.time,equal=FALSE,type=c("nearest","right","left"),sorted=FALSE,...) {
    if (!sorted) {
        ord <- order(new.time,decreasing=FALSE)
        new.time <- new.time[ord]
    }
    A <- NULL
    if (NCOL(time)>1) {
        A <- time
        time <- A[,1,drop=TRUE]
    }
    if (is.unsorted(time)) warnings("'time' will be sorted")
    type <- agrep(type[1],c("nearest","right","left"))-1
    arglist <- list("FastApprox",
                    time=sort(time),
                    newtime=new.time,
                    equal=equal,
                    type=type,
                    PACKAGE="mets")
    res <- do.call(".Call",arglist)
    if (!sorted) {
        oord <- order(ord)
        if (!equal) return(res[oord])
        res <- lapply(res,function(x) x[oord])
    }
    if (!is.null(A)) {
        A[res,,drop=FALSE]
    }
    return(res)
}


##' @export
indexstrata <- function(jump.times,jump.strata,eval.times,eval.strata,nstrata,equal=FALSE,
			type=c("nearest","right","left"),sorted=FALSE,start.time=NULL)
{   # {{{
	stopifnot(is.numeric(jump.times))
	stopifnot(is.numeric(eval.times))
	if (any(eval.strata<0) | any(eval.strata>nstrata-1)) stop("eval.strata index not ok\n"); 
	if (any(jump.strata<0) | any(jump.strata>nstrata-1)) stop("jump.strata index not ok\n"); 
	N <- length(jump.times)
	index <- rep(0,length(eval.times))

	for (i in unique(eval.strata)) {
	   wherej <- which(eval.strata==i)
	   whereJ <- which(jump.strata==i)
	   if (!is.null(start.time)) iindex <- fast.approx(c(start.time,jump.times[whereJ]),eval.times[wherej],equal=equal,type=type,sorted=sorted) 
	   else iindex <- fast.approx(jump.times[whereJ],eval.times[wherej],equal=equal,type=type,sorted=sorted) 
	   index[wherej] <- whereJ[iindex]
	}
	return(index)
}# }}}
