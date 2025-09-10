pkgname <- "CrossCarry"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "CrossCarry-Ex.timings", pos = 'CheckExEnv')
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
library('CrossCarry')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("CrossGEE")
### * CrossGEE

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: CrossGEE
### Title: Run a GEE model for data from a crossover experiment
### Aliases: CrossGEE

### ** Examples

data(Water)
model <- CrossGEE(response="LCC", covar=c("Age"), period="Period",
                  treatment = "Treatment", id="ID", carry="Carry_Agua",
                  family=gaussian(),correlation ="AR-M", Mv=1 ,data=Water)

model$QIC
model$model

## Aproximate p-values
(pvalues <- 2 * pnorm(abs(coef(summary(model$model))[,5]), lower.tail = FALSE))

summary(model$model)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("CrossGEE", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("CrossGEEKron")
### * CrossGEEKron

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: CrossGEEKron
### Title: Run a GEE model for data from a crossover experiment with
###   repeated measures
### Aliases: CrossGEEKron

### ** Examples

data(Arterial)

carrydata <- createCarry(data=Arterial, treatment = "Treatment",
 period = "Period",id="Subject")

data <- carrydata$data
carry <- carrydata$carryover
model <- CrossGEEKron(response = "Pressure", treatment = "Treatment",
period = "Period", id="Subject", time="Time",
 carry=c("Carry_B","Carry_C"),data=data, correlation = "AR-M", Mv=1)

model$QIC
model$Within
model$Between
summary(model$model)

## Aproximate p-values for model
(pvalues <- 2 * pnorm(abs(coef(summary(model$model))[,5]), lower.tail = FALSE))

model2 <- CrossGEEKron(response = "Pressure", treatment = "Treatment",
 period = "Period", id="Subject", time="Time",
 carry=c("Carry_B","Carry_C"), data=data,
 correlation = "AR-M", Mv=1,formula=Pressure ~ Treatment+
 Period+ Carry_B+Carry_C)

model2$QIC
model2$Within
model2$Between
summary(model2$model)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("CrossGEEKron", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("CrossGEESP")
### * CrossGEESP

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: CrossGEESP
### Title: Run a semi-parametric GEE model for data from a crossover
###   experiment with repeated measures
### Aliases: CrossGEESP

### ** Examples

data(Arterial)

carrydata <- createCarry(data=Arterial, treatment = "Treatment",
                         period = "Period",id="Subject", carrySimple = FALSE)
data <- carrydata$data
carry <- carrydata$carryover
model1 <- CrossGEESP(response = "Pressure", treatment = "Treatment",
                    period = "Period", id="Subject", time="Time",
                    carry=carrydata$carryover,data=data,
                    correlation = "exchangeable")


model2 <- CrossGEESP(response = "Pressure", treatment = "Treatment",
                     period = "Period", id="Subject", time="Time",
                     carry=carrydata$carryover,data=data, correlation = "AR-M")


model1$QIC
model2$QIC
summary(model1$model)
summary(model2$model)

## Aproximate p-values for model 2

(pvalues <- 2 * pnorm(abs(coef(summary(model2$model))[,5]), lower.tail = FALSE))

model1$graph[[1]]
model1$graph[[2]]
plot <- model1$graph[[1]] + ggplot2::xlab("Time in minutes")+
ggplot2::ylab("Change in systolic blood pressure")
plot



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("CrossGEESP", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("computeqic")
### * computeqic

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: computeqic
### Title: Quasi Information Criterion
### Aliases: computeqic

### ** Examples


library(gee)
data(Arterial)
fit <- gee(Pressure ~ Time + Treatment, id=Subject,
       data=Arterial, family=gaussian, corstr="AR-M")
computeqic(fit)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("computeqic", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("createCarry")
### * createCarry

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: createCarry
### Title: Add carryover dummy variables
### Aliases: createCarry

### ** Examples

data(Water)
carryover <- createCarry(data=Water,
                         treatment = "Treatment", id = "ID",
                         period = "Period", carrySimple = FALSE)
carryover$carryover
carryover$data



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("createCarry", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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
