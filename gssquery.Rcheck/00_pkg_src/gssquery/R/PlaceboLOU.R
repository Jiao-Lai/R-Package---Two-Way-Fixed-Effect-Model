#' Placebo test: leave one out.
#'
#' This function executes a leave one out falsification exercise on the effect of x on y.
#' Specifically, observations can be seen as groups by `out`. The total sample will be removed one group
#' at a time, and then the main analysis is re-examined.
#' This exercise tests if the main results are sensitive to certain subset of data.
#'
#'
#' @param data data containing variables to be analyzed, default is GSS.
#' @param y variable containing outcome variable in data.
#' @param x variable containing treatment status in data, has to be indicator having two levels.
#' @param FE fixed effects.
#' @param out variable specifing groups.

#' @return A data frame of coefficients from re-examined linear regression, and
#' corresponding p value.
#' @examples
#' data(GSS)
#' LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
#' PlaceboLOU(LmData,'happy.score','election','year','year')
#' @importFrom dplyr select mutate right_join distinct
#' @importFrom magrittr %>%
#' @importFrom dplyr na_if
#' @importFrom stats lm
#' @importFrom graphics plot points
#' @importFrom stats rbinom

PlaceboLOU <- function(data,y,x,FE,out){
  stopifnot(!is.null(data), !is.null(y), !is.null(x), !is.null(FE), !is.null(out),
            !anyDuplicated(c(y, x)))
  stopifnot (y %in% names(data), x %in% names(data), out %in% names(data))

  for (i in 1:length(FE))
  {
    if (!FE[i] %in% names(data))
    {
      stop("please enter valid name")
    }
  }

  cluster <- data %>% select(out) %>% distinct()
  coef = c()
  pval = c()
  for (i in cluster[,1])
  {
    LmData<-data%>%filter(!!as.name(out) != i)
    coef = c(coef, Analysis.lm(LmData,y,FE)$coefficients[x])
    pval = c(pval, summary(Analysis.lm(LmData,y,FE))$coefficients[, "Pr(>|t|)"][x])

  }
  return(cbind(cluster, as.data.frame(coef),as.data.frame(pval)))
}
