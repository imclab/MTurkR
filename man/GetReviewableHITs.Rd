\name{GetReviewableHITs}
\alias{GetReviewableHITs}
\alias{reviewable}
\title{Get Reviewable HITs}
\description{Get HITs that are currently reviewable.}
\usage{
GetReviewableHITs(	hit.type = NULL, status = NULL, response.group = "Minimal", 
					return.all = TRUE, pagenumber = "1", pagesize = "10", 
					sortproperty = "Enumeration", sortdirection = "Ascending", 
					keypair = credentials(), print = getOption('MTurkR.print'), 
					log.requests = getOption('MTurkR.log'),
                    sandbox = getOption('MTurkR.sandbox'),
                    validation.test = getOption('MTurkR.test'))
}
\arguments{
  \item{hit.type}{An optional character string containing a HITTypeId to consider when looking for reviewable HITs.}
  \item{status}{An optional character string of either \dQuote{Reviewable} or \dQuote{Reviewing} limiting the search to HITs of with either status.}
  \item{response.group}{A character string specifying what details of each HIT to return. API currently only supports \dQuote{Minimal}. For more information, see \url{http://docs.amazonwebservices.com/AWSMechTurk/latest/AWSMturkAPI/ApiReference_HITDataStructureArticle.html}.}
  \item{return.all}{A logical indicating whether all QualificationTypes (as opposed to a specified page of the search results) should be returned. Default is \code{TRUE}.}
  \item{pagenumber}{An optional character string indicating which page of search results should be returned. Most users can ignore this.}
  \item{pagesize}{An optional character string indicating how many search results should be returned by each request, between 1 and 100. Most users can ignore this.}
  \item{sortproperty}{One of \dQuote{Title}, \dQuote{Reward}, \dQuote{Expiration}, \dQuote{CreationTime}, \dQuote{Enumeration}. Ignored if \code{return.all=TRUE}. Most users can ignore this.}
  \item{sortdirection}{Either \dQuote{Ascending} or \dQuote{Descending}. Ignored if \code{return.all=TRUE}. Most users can ignore this.}
  \item{keypair}{A two-item character vector containing an AWS Access Key ID in the first position and the corresponding Secret Access Key in the second position. Set default with \code{\link{credentials}}.}
  \item{print}{Optionally print the results of the API request to the standard output. Default is \code{TRUE}.}
  \item{log.requests}{A logical specifying whether API requests should be logged. Default is \code{TRUE}. See \code{\link{readlogfile}} for details.}
  \item{sandbox}{Optionally execute the request in the MTurk sandbox rather than the live server.  Default is \code{FALSE}.}
  \item{validation.test}{A logical specifying whether only the pre-request checks should be conducted and the request URL returned (without executing the request). Default is \code{FALSE}.}
}
\details{A simple function to return the HITIds of HITs currently in \dQuote{Reviewable} or \dQuote{Reviewing} status. To retrieve additional details about each of these HITs, see \code{\link{GetHIT}}. This is an alternative to \code{\link{SearchHITs}}.

\code{reviewable()} is an alias.
}
\value{A dataframe containing only a column of HITIds.}
\references{
\href{http://docs.amazonwebservices.com/AWSMechTurk/latest/AWSMturkAPI/ApiReference_GetReviewableHITsOperation.html}{API Reference}
}
\author{Thomas J. Leeper}
%\note{}
\seealso{
\code{\link{GetHIT}}

\code{\link{GetHITsForQualificationType}}

\code{\link{SearchHITs}}
}
\examples{
\dontrun{
GetReviewableHITs()
}
}
\keyword{HITs}