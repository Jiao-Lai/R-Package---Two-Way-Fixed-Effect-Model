#' A package which can perform fixed effect model and robustness test.
#'
#' `gssquery` is a package for final project of stats 290. This package can be used to perform fixed
#'  effect model and robustness tests. GSS data is included to run example of the effect of US
#'  presidential elections on household happiness. Robustness tests such as event study, leave one out
#'  falsification exercise, treatment re-shuffling are also provided.
#'
#' The package provides 9 functions:
#' * [`GetCleanLmData`][GetCleanLmData()] which selects variables from data `GSS` and clean the data.
#' * [`Analysis.lm`][Analysis.lm()] which runs linear regression of fixed effect model for given data.
#' * [`LagEffect`][LagEffect()] which examines if there is any lag effect of the main results.
#' * [`LeadEffect`][LeadEffect()] which examines if there is any lag effect of the main results.
#' * [`PlaceboLOT`][PlaceboLOT()] which examines falsification exercise of leave one out to check the subset sensitivity of main results.
#' * [`GetAttributes`][GetAttributes()] which returns all attributes in given data.
#' * [`gssquery`][gssquery()] which returns attributes of user interest in a given data..
#' * [`PlotAttributes`][PlotAttributes()] which returns the bar plot or mean value by group of an attribute of user interest.
#' * [`PlaceboTSReshuffle`][PlaceboTSReshuffle()] which tests if the main effect is sensitive to treatment re-shuffling.

#' The source code of the package further demonstrates:
#'
#' * [R markdown](https://rmarkdown.rstudio.com/) syntax in documenting functions, including references to functions and data within the same package and from other packages using the [`roxygen2` package](https://cran.r-project.org/package=roxygen2/vignettes/rd-formatting.html)
#' * Including a data set [`GSS`] as part of the package
#' * Importing functions from other packages using `importFrom` directives
#' * Use of [utils::globalVariables()] to get around warnings produced when checking the package, something that happens a lot when using [ggplot2::ggplot()], for instance.
#'
#' @seealso [`GetCleanLmData`][GetCleanLmData()]
#' @seealso [`Analysis.lm`][Analysis.lm()]
#' @seealso [`LagEffect`][LagEffect()]
#' @seealso [`LeadEffect`][LeadEffect()]
#' @seealso [`PlaceboLOT`][PlaceboLOT()]
#' @seealso [`GetAttributes`][GetAttributes()]
#' @seealso [`gssquery`][gssquery()]
#' @seealso [`PlotAttributes`][PlotAttributes()]
#' @seealso [`PlaceboTSReshuffle`][PlaceboTSReshuffle()]

#' @importFrom utils globalVariables
#' @docType package
#' @name gssquery
NULL
#### These three variables are created inside functions `PlotAttribute`, `LagEffect, `LeadEffect` to better
#### finish the job.
utils::globalVariables(names = c("count",
                                 "x.post2",
                                 "x.pre2"))

