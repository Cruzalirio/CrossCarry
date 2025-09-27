# ===============================================================
# Example with the "Arterial" dataset using CrossCarry
# ===============================================================

library(CrossCarry)   # Main package
library(tidyverse)    # Data manipulation and graphics
library(splines)      # Splines (used in CrossGEESP)
library(corrplot)     # Correlation matrix visualization

# ===============================================================
# 1. Data preparation and creation of carry-over variable
# ===============================================================

data("Arterial")

carrydata <- createCarry(
  data = Arterial,
  treatment = "Treatment",
  period = "Period",
  id = "Subject",
  carrySimple = TRUE # simple carry-over effect based on previous treatment
)

data  <- carrydata$data
carry <- carrydata$carryover

# ===============================================================
# 2. CrossGEE models with different correlation structures
# ===============================================================

# Model 1: AR-M correlation, simple carry-over
model1 <- CrossGEE(
  response = "Pressure", treatment = "Treatment",
  period = "Period", id = "Subject",
  carry = carry, data = data,
  correlation = "AR-M", Mv = 1
)

summary(model1$model)

# Model 2: Exchangeable correlation
model2 <- CrossGEE(
  response = "Pressure", treatment = "Treatment",
  period = "Period", id = "Subject",
  carry = carry, data = data,
  correlation = "exchangeable", Mv = 1
)

# Model 3: Kronecker structure (distinguishes within- and between-period correlation)
model3 <- CrossGEEKron(
  response = "Pressure", treatment = "Treatment",
  period = "Period", id = "Subject", time = "Time",
  carry = carry, data = data,
  correlation = "AR-M", Mv = 1
)

# Model 4: Penalized splines for carry-over and time effects
model4 <- CrossGEESP(
  response = "Pressure", treatment = "Treatment",
  period = "Period", id = "Subject", time = "Time",
  carry = carry, data = data,
  correlation = "AR-M", Mv = 1
)

# ===============================================================
# 3. Model comparison using QIC
# ===============================================================

QICs <- cbind(model1$QIC, model2$QIC, model3$QIC, model4$QIC)
colnames(QICs) <- c("model1", "model2", "model3", "model4")
QICs

options(digits = 2)
summary(model3$model)

# ===============================================================
# 4. Within- and between-period correlations (Kronecker model)
# ===============================================================

round(model3$Within, 3)
round(model3$Between, 3)

corrplot(model3$Within, method = "color", type = "upper",
         tl.cex = 0.8, addCoef.col = "black",
         title = "Within-Period Correlation", mar = c(0,0,2,0))

corrplot(model3$Between, method = "color", type = "upper",
         tl.cex = 0.8, addCoef.col = "black",
         title = "Between-Period Correlation", mar = c(0,0,2,0))

# ===============================================================
# 5. Graphical outputs from CrossGEESP (model4)
# ===============================================================
# The objects in model4$graphs are ggplot objects.
# Below we enhance them with labels, titles, and a professional style.

# Graph 1: Treatment effect over time
model4$graphs[[1]] +
  labs(title = "Effect of Treatment over Time",
       x = "Time", y = "Estimated Response") +
  theme_classic(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    legend.position = "top",
    axis.text = element_text(color = "black")
  ) +
  scale_color_brewer(palette = "Dark2") +
  scale_fill_brewer(palette = "Dark2")

# Graph 2: Carry-over effect with splines
model4$graphs[[2]] +
  labs(title = "Spline-Based Carry-over Effect",
       x = "Time", y = "Estimated Carry-over") +
  theme_classic(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    legend.position = "top",
    axis.text = element_text(color = "black")
  ) +
  scale_color_brewer(palette = "Set1") +
  scale_fill_brewer(palette = "Set1")

# Graph 3: Joint treatment and carry-over effects
model4$graphs[[3]] +
  labs(title = "Treatment and Carry-over Effects",
       x = "Time", y = "Response") +
  theme_classic(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    legend.position = "top",
    axis.text = element_text(color = "black")
  ) +
  scale_color_brewer(palette = "Paired") +
  scale_fill_brewer(palette = "Paired")

