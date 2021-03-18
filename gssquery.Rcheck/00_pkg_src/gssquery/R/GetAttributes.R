#' Get all attributes in given data.
#'
#' This function returns all attributes in data
#'
#'
#' @param  data given data

#' @return The names of all attributes in data.
#' @examples
#' data(GSS)
#' GetAttributes(GSS)


GetAttributes <- function(data) {
  stopifnot(!is.null(data))
  attrs = names(data)
  return(attrs)
}
