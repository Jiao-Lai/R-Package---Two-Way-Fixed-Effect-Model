#' Event study: lag effect.
#'
#' This functions examines if there is a lag effect on the relationship between x and y.
#'
#'
#' @param data data containing variables to be analyzed.
#' @param y outcome variable.
#' @param x treatment variable.
#' @param time time fixed effect.
#' @param FE fixed effects to to included.

#' @return summary of lm fit on lag treatment.
#' @examples
#' data(GSS)
#' LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
#' LagEffect(LmData,'happy.score','election','year', 'year')

#' @importFrom dplyr right_join select rename mutate
#' @importFrom magrittr %>%
#' @importFrom stats lm
#' @importFrom dplyr na_if
#' @importFrom rlang :=
LagEffect <- function(data, y, x, time, FE)
{

  stopifnot(!is.null(data), !is.null(y), !is.null(x), !is.null(time),
    !is.null(FE), !anyDuplicated(c(y, x, FE)), time %in% FE)

  if (!y %in% names(data) | !x %in% names(data))
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

  LmData[, time] <- as.numeric(LmData[, time])

  treatment <- LmData %>% select(FE, x) %>% distinct()

  ### Lag effect.
  treatment.pre2 <- treatment %>% rename(x.pre2 = !!x) %>%
    mutate(`:=`(!!time, !!as.name(time) + 2)) %>% select(x.pre2,
    FE)
  LmData.pre2 <- treatment.pre2 %>% right_join(LmData) %>%
    select(-x) %>% mutate(`:=`(!!time, as.character(!!as.name(time)))) %>%
    rename(y = !!y)
  lm.pre2 <- summary(lm(y ~ ., LmData.pre2))
  return(lm.pre2)

}

