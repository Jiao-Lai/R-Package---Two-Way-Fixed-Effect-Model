#' Event study: lead effect.
#'
#' This function examines if there is lead effect on the relationship between x and y.
#'
#'
#' @param data data containing variables to be analyzed.
#' @param y outcome variable.
#' @param x treatment variable.
#' @param time time fixed effect.
#' @param FE fixed effects to to included.

#' @return summary of regression on lead treatment.
#' @examples
#' data(GSS)
#' LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
#' LeadEffect(LmData,'happy.score','election','year', 'year')

#' @importFrom dplyr right_join select rename mutate
#' @importFrom magrittr %>%
#' @importFrom stats lm
#' @importFrom dplyr na_if
#' @importFrom rlang :=

LeadEffect <-
  function(data, y, x, time, FE) {
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

    ### Get lead treatment.
    treatment <- LmData %>% select(FE, x) %>% distinct()
    treatment.post2 <- treatment %>% rename(x.post2 = !!x) %>%
      mutate(`:=`(!!time, !!as.name(time) - 2)) %>% select(x.post2,
                                                           FE)
    LmData.post2 <- treatment.post2 %>% right_join(LmData) %>%
      select(-x) %>% mutate(`:=`(!!time, as.character(!!as.name(time)))) %>%
      rename(y = !!y)
    lm.post2 <- summary(lm(y ~ ., LmData.post2))
    return(lm.post2)

  }
