
rm(list=ls())
gc()

# Load necessary libraries
library(support.CEs)

des1 <- rotation.design(attribute.names = list(
  Cuisine = c("American Cuisine", "Asian Cuisine", "European Cuisine"),
  Delivery = c("take-away", "delivery", "dining-in"),
  Price = c("20", "40", "60"),
  Distance = c("Walking Distance", "Long Drive Distance", "Short Drive Distance")), # Corrected the attribute names and levels
  nalternatives = 2, 
  nblocks = 1)

questionnaire(choice.experiment.design = des1)

save(des1, file = "design.RData")
