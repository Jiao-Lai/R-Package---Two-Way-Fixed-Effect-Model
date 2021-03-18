## code to prepare `GSS` dataset goes here

## Import all csv files.
setwd("~/gssquery/data-raw")
files = list.files(pattern = "*.csv$")

for (i in seq(2000, 2018, 2))
{
  oname = paste("GSS", i, sep = "")
  assign(oname, read.csv(files[(i - 2000) / 2 + 1], encoding = "UTF-8"))
}

### Combine all the 10 dataset.
GSS.all <- gtools::smartbind(
  GSS2000,
  GSS2002,
  GSS2004,
  GSS2006,
  GSS2008,
  GSS2010,
  GSS2012,
  GSS2014,
  GSS2016,
  GSS2018
)

### Extract column names exist in all 10 datasets.
colnames <- c(
  names(GSS2000),
  names(GSS2002),
  names(GSS2004),
  names(GSS2006),
  names(GSS2008),
  names(GSS2010),
  names(GSS2012),
  names(GSS2014),
  names(GSS2016),
  names(GSS2018)
)
name.tab <- table(colnames)
common.colnames <- names(name.tab[name.tab == 10])

### Select subset of data where variables are in all 10
### datasets.
GSS <- GSS.all %>% select(common.colnames)

### Remove columns with non-ascii encoding.
col.rm <- c()
for (i in 1:ncol(GSS))
{
  if (length(tools::showNonASCII(levels(GSS[, i]))) != 0)
  {
    col.rm <- c(col.rm, i)
  }
}
GSS <- GSS[,-col.rm]

### Generate outcome variable `happy.score` and treatment
### status `election`/`re.election``, which will be used for
### quantitative analyses.
GSS <- GSS %>% mutate(election = ifelse(year %in% c(2000, 2004, 2008, 2012, 2016), 1, 0)) %>%
               mutate(happy.score = ifelse(happy == ("not too happy"), 1, 0)) %>%
               mutate(happy.score = ifelse(happy == ("pretty happy"), 2, happy.score)) %>%
               mutate(happy.score = ifelse(happy == ("very happy"), 3, happy.score))

GSS <- GSS %>% mutate(re.election = ifelse(year %in% c(2004,2012), 2, GSS$election)) %>%
               mutate(year = as.character(year))

### Use pre-processed data GSS.
usethis::use_data(GSS, overwrite = TRUE)
