library(CrossCarry)
library(tidyverse)
library(splines)
data("Arterial")

carrydata <- createCarry(data=Arterial, treatment = "Treatment",
                         period = "Period",id="Subject", carrySimple = TRUE)
data <- carrydata$data
carry <- carrydata$carryover

model1 <- CrossGEE(response = "Pressure", treatment = "Treatment",
                       period = "Period", id="Subject",
                       carry=carry, data=data, correlation = "AR-M", Mv=1)

summary(model1$model)

model2 <- CrossGEE(response = "Pressure", treatment = "Treatment",
                   period = "Period", id="Subject",
                   carry=carry, data=data, correlation = "exchangeable", Mv=1)

model3 <- CrossGEEKron(response = "Pressure", treatment = "Treatment",
                      period = "Period", id="Subject", time="Time",
                      carry=carry, data=data, correlation = "AR-M", Mv=1)

model4 <- CrossGEESP(response = "Pressure", treatment = "Treatment",
                       period = "Period", id="Subject", time="Time",
                       carry=carry, data=data, correlation = "AR-M", Mv=1)



QICs <- cbind(model1$QIC,model2$QIC,model3$QIC, model4$QIC)
names(QICs) <- c("model1", "model2", "model3", "model4")
QICs
options(digits = 2)
summary(model3$model)

## Aproximate p-values for model 2



round(model3$Within,3)
round(model3$Between,3)
