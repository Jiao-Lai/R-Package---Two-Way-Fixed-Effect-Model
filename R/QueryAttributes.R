#' Query specific attributes from data.
#'
#' This function returns attributes of interest in a given data file.
#'
#'
#' @param  data data file provided
#' @param  ... attributes of interest

#' @return  attributes of interest in data.
#' @examples
#' data(GSS)
#' QueryAttributes(GSS,"age","income")
#'@importFrom magrittr  %>%


QueryAttributes <- function(data, ...) {
  #### Error handlings.
  dots = list(...)
  n <- length(dots)
  if (n == 0)
  {
    stop("Please enter at least one valid name.")
  }else
  {
    stopifnot(dots %in% names(data), !anyDuplicated(dots))
    Attributes <- data %>% select(...)
    return(Attributes)
  }
}

