% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{canonicalize_mac}
\alias{canonicalize_mac}
\title{Converts a character vector of MAC addresses into canonical form}
\usage{
canonicalize_mac(mac)
}
\arguments{
\item{mac}{character vector of MAC address strings}
}
\description{
The canonical form for MAC addresses strings is 6, 2-character
octets separated by colons. This function returns \code{TRUE} if
an address string is in canonical format.
}
\examples{
canonicalize_mac("b8:e8:56:35:36:4")
}
