#' Linear regression of fixed effect model.
#'
#' This function runs fixed effect model to analyze if a given independent variable affects
#'  the chosen outcome variable. Fixed effect(s) is included in the regression.
#'
#' @param data data containing variables to be analyzed.
#' @param y outcome variable.
#' @param FE fixed effects to to included.

#' @return the fit of lm
#' @examples
#' data(GSS)
#' LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
#' Analysis.lm(LmData,'happy.score','year')
#' @importFrom dplyr select mutate rename
#' @importFrom magrittr %>%
#' @importFrom dplyr na_if
#' @importFrom stats lm
### rely on packages dplyr, naniar.
Analysis.lm <- function(data, y, FE)
{
  ##### Error handlings.
  stopifnot(!is.null(data), !is.null(y), !is.null(FE), !anyDuplicated(c(y,
    FE)))
  if (!y %in% names(data) )
  {
    stop("please enter valid name")
  }
  for (i in 1:length(FE))
  {
    if (!FE[i] %in% names(data))
    {stop("please enter valid name")}
  }
  LmData <- data

  for (i in FE)
  {
    if (class(LmData[, i]) != "character")
    {
      LmData[, i] <- as.character(LmData[, i])
    }
  }

  LmData <- LmData %>% rename(y = !!y)
  lm(y ~ ., LmData)

}
