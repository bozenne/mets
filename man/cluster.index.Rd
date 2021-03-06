% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clusterindex-reshape.R
\name{cluster.index}
\alias{cluster.index}
\alias{countID}
\alias{pairRisk}
\alias{mystrata}
\alias{mystrata2index}
\title{Finds subjects related to same cluster}
\usage{
cluster.index(
  clusters,
  index.type = FALSE,
  num = NULL,
  Rindex = 0,
  mat = NULL,
  return.all = FALSE,
  code.na = NA
)
}
\arguments{
\item{clusters}{list of indeces}

\item{index.type}{if TRUE then already list of integers of index.type}

\item{num}{to get numbering according to num-type in separate columns}

\item{Rindex}{index starts with 1, in C is it is 0}

\item{mat}{to return matrix of indeces}

\item{return.all}{return all arguments}

\item{code.na}{how to code missing values}
}
\description{
Finds subjects related to same cluster
}
\examples{
i<-c(1,1,2,2,1,3)
d<- cluster.index(i)
print(d)

type<-c("m","f","m","c","c","c")
d<- cluster.index(i,num=type,Rindex=1)
print(d)
}
\references{
Cluster indeces
}
\seealso{
familycluster.index familyclusterWithProbands.index
}
\author{
Klaus Holst, Thomas Scheike
}
