#' Get subset data containing certain attributes, which can be used for analyses such as
#' linear regressions.
#'
#' This function selects subset of data including outcome variable of interest, treatment of interest,
#' fixed effects. Users can also select other control variables affecting the selected outcome variable.
#'
#' @param data data containing variables to be analyzed, default is GSS.
#' @param y variable containing outcome variable in data, has to be numeric.
#' @param x variable containing treatment status in data, has to be indicator having two levels.
#' @param FE fixed effects to be included.
#' @param common.na.strings values where to be replaced by NA
#' @param ... control variables to be selected from data.
#' @return Clean data with selected outcome, treatment, fixed effects, and control variables.
#'         The data can be used for analyses like linear regressions.
#' @examples
#' data(GSS)
#' GetCleanLmData(GSS,'happy.score','election','year',
#' c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b","DK NA"),'age','income')
#' @importFrom dplyr select mutate
#' @importFrom magrittr  %>%
#' @importFrom dplyr na_if

GetCleanLmData <- function(data , y , x , FE ,common.na.strings, ...)
  {
  #### Error handlings.
  stopifnot(!is.null(data), !is.null(y), !is.null(x), !anyDuplicated(c(y,x,FE)) )
  if (length(y) > 1)
  {
    y <- y[1]
    print("Outcome variable should be one column. Only the first variable will be selected.")

  }
  if (length(x) > 1)
  {
    x <- x[1]
    print("Treatment variable should be one column. Only the first variable will be selected.")
  }
  if (!y %in% names(data) | !x %in% names(data))
  {
    stop("please enter valid name")
  }
  for (i in 1:length(FE))
  {
    if (!FE[i] %in% names(data))
    {stop("please enter valid name")}
  }

  treatment <- data %>% select(x)

  if (length(table(treatment)) != 2)
  {
    stop(print("Treatment status must be indicator with two levels."))
  }

  outcome <- data %>% select(y)

  if (class(outcome[, 1]) != "numeric")
  {
    stop(print("Outcome variable must be numeric."))
  }

  dots = list(...)
  stopifnot(dots %in% names(data), !anyDuplicated(dots))

  ### Main codes.
  controls <- data %>% select(...)
  names.controls <- names(controls)
  if (x %in% names.controls)
  {
    controls <- controls %>% select(-x)

  }
  if (y %in% names.controls)
  {
    controls <- controls %>% select(-y)
  }

  if (!is.null(FE))
  {
    cluster <- data %>% select(FE)
    LmData <- cbind(outcome, treatment, cluster, controls)
  }else
  { LmData <- cbind(outcome, treatment, controls) }

 ### clean data.
 if(is.null(common.na.strings))
 {
   return(LmData)
 }else{

  for (i in 1:ncol(LmData))
  {
    for (j in common.na.strings)
    {
      LmData[, i] <- na_if(LmData[, i], j)
    }
  }

  return(LmData)
     }
}
