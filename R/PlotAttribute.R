#' Plot of specific attribute of data.
#'
#' This function generate a bar-plot of an attribute with level <= 10, or a plot for mean value
#' by group.
#'
#'
#' @param  data data file
#' @param  attr an attribute from data
#' @param  group.by group by variable

#' @return A plot of attribute of interest.
#' @examples
#' data(GSS)
#' PlotAttribute(GSS,'age','year')
#' @importFrom dplyr select mutate summarise n filter group_by
#' @importFrom magrittr %>%
#' @importFrom tidyr drop_na
#' @importFrom ggplot2 geom_bar
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 ggtitle
#' @importFrom stats aggregate
#' @importFrom rlang :=

PlotAttribute <- function(data , attr , group.by )
{
  attr <- as.character(attr)
  if (!attr %in% names(data) | !group.by %in% names(data))
  {
    stop(cat("please enter valid column names, try {", names(data),
      "}", "\n", sep = "\t"))
  }
  stopifnot(attr != group.by)

  query <- data %>% select(group.by, attr)

  ### Barplot if levels of attribute <= 15, otherwise plot the mean value by group.
  if (length(table((query[, attr]))) <= 15)
  {
    query.plot <- query %>% group_by(!!as.name(attr), !!as.name(group.by)) %>%
      drop_na(!!as.name(attr)) %>% summarise(count = n())

    query.plot <- query.plot %>% filter(!(!!as.name(attr) %in%
      c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b")))
    ggplot(query.plot, aes(fill = !!as.name(group.by), x = !!as.name(attr),
      y = count)) + geom_bar(position = "dodge", stat = "identity") + ggtitle("Bar Plot by Group")
  } else
  {
    query <- data %>% select(group.by, attr) %>% mutate(`:=`(!!attr,
      as.numeric(!!as.name(attr)))) %>% filter(!(!!as.name(attr) %in%
      c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b"))) %>%
      drop_na(!!as.name(attr))
    query.plot <- aggregate(query[, 2], by = list(query[,
      1]), FUN = mean)
    names(query.plot) <- c(group.by, attr)
    ggplot(query.plot, aes(x = !!as.name(group.by), y = !!as.name(attr),
      )) + geom_point() + ggtitle("Plot of mean by group")

  }


}
