#' Placebo test on effect of x on y.
#'
#' This function executes a pacebo test on effect of x on y.
#' Specifically, treatment status is randomly re-shuffled for 100 times, and the effect is re-examined on each
#' re-shuffling. The coefficients from re-shuffled and original treatment status are ploted.
#' If the effect is robust, then the point from original treatment status should be an outlier.
#'
#'
#' @param data data containing variables to be analyzed, default is GSS.
#' @param y variable containing outcome variable in data.
#' @param x variable containing treatment status in data, has to be indicator having two levels.
#' @param FE fixed effects.

#' @return A plot of coefficients from re-shuffled and original treatment status.
#' @examples
#' data(GSS)
#' LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
#' PlaceboTSReshuffle(LmData,'happy.score','election','year')
#' @importFrom dplyr select mutate right_join distinct
#' @importFrom magrittr %>%
#' @importFrom dplyr na_if
#' @importFrom stats lm
#' @importFrom graphics plot points
#' @importFrom stats rbinom

PlaceboTSReshuffle <- function(data, y, x, FE)
{
  stopifnot(!is.null(data), !is.null(y), !is.null(x), !is.null(FE),
    !anyDuplicated(c(y, x, FE)))
  stopifnot (y %in% names(data), x %in% names(data))

  for (i in 1:length(FE))
  {
    if (!FE[i] %in% names(data))
    {
      stop("please enter valid name")
    }
  }
  for (i in FE)
  {
    if (class(data[, i]) != "character")
    {
      data[, i] <- as.character(data[, i])
    }
  }

  ### coef from original treatment.
  coef.o <- Analysis.lm(data, y, FE)$coefficients[x]

  ### mean value of treatment.
  treatment <- data %>% select(x, FE) %>% distinct()
  avg <- mean(treatment[, x])

  results.coef <- c()
  results.p <- c()

  ### random reshuffle treatment and then reestimate the main model.
  seed <- sample(1:1000, 100, replace = F)
  for (i in seq(seed))
  {
    data.falsification <- data %>% select(-x)
    set.seed(seed[i])
    treatment[, x] <- rbinom(nrow(treatment), 1, avg)
    data.falsification <- treatment %>% right_join(data.falsification) %>%
      rename(y = !!y)
    lm.fit = lm(y ~ ., data = data.falsification)
    summary(lm.fit)
    results.coef[i] <- lm.fit$coefficients[x]
    results.p[i] <- summary(lm.fit)$coefficients[, "Pr(>|t|)"][x]
  }

  ### plot both coef from original treatment and re-shuffled treatment to see if the original one is an outlier.
  plot(results.coef,main = "Random Treatment Status Re-shuffling \n red = coef.o")
  points(coef.o, col = "red")
}

