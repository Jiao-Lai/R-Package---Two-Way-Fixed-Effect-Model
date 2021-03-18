pkgname <- "gssquery"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "gssquery-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('gssquery')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("Analysis.lm")
### * Analysis.lm

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Analysis.lm
### Title: Linear regression of fixed effect model.
### Aliases: Analysis.lm

### ** Examples

data(GSS)
LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
Analysis.lm(LmData,'happy.score','year')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Analysis.lm", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GetAttributes")
### * GetAttributes

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GetAttributes
### Title: Get all attributes in given data.
### Aliases: GetAttributes

### ** Examples

data(GSS)
GetAttributes(GSS)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GetAttributes", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GetCleanLmData")
### * GetCleanLmData

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GetCleanLmData
### Title: Get subset data containing certain attributes, which can be used
###   for analyses such as linear regressions.
### Aliases: GetCleanLmData

### ** Examples

data(GSS)
GetCleanLmData(GSS,'happy.score','election','year',
c("DK", "IAP", "UNCODEABLE & IAP", ".a", ".b","DK NA"),'age','income')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GetCleanLmData", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("LagEffect")
### * LagEffect

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: LagEffect
### Title: Event study: lag effect.
### Aliases: LagEffect

### ** Examples

data(GSS)
LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
LagEffect(LmData,'happy.score','election','year', 'year')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("LagEffect", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("LeadEffect")
### * LeadEffect

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: LeadEffect
### Title: Event study: lead effect.
### Aliases: LeadEffect

### ** Examples

data(GSS)
LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
LeadEffect(LmData,'happy.score','election','year', 'year')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("LeadEffect", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("PlaceboLOU")
### * PlaceboLOU

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: PlaceboLOU
### Title: Placebo test: leave one out.
### Aliases: PlaceboLOU

### ** Examples

data(GSS)
LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
PlaceboLOU(LmData,'happy.score','election','year','year')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("PlaceboLOU", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("PlaceboTSReshuffle")
### * PlaceboTSReshuffle

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: PlaceboTSReshuffle
### Title: Placebo test on effect of x on y.
### Aliases: PlaceboTSReshuffle

### ** Examples

data(GSS)
LmData <- GetCleanLmData (GSS,'happy.score', 'election', 'year', 'age', 'income')
PlaceboTSReshuffle(LmData,'happy.score','election','year')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("PlaceboTSReshuffle", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("PlotAttribute")
### * PlotAttribute

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: PlotAttribute
### Title: Plot of specific attribute of data.
### Aliases: PlotAttribute

### ** Examples

data(GSS)
PlotAttribute(GSS,'age','year')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("PlotAttribute", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("QueryAttributes")
### * QueryAttributes

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: QueryAttributes
### Title: Query specific attributes from data.
### Aliases: QueryAttributes

### ** Examples

data(GSS)
QueryAttributes(GSS,"age","income")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("QueryAttributes", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
