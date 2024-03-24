
rm(list=ls())
gc()

# Load necessary libraries
library(support.CEs)

library(support.CEs)

des2 <- rotation.design(attribute.names = list(
  Cuisine = c("Chinese", "Indian", "Japanese"),
  Delivery = c("Dining.in", "Delivery", "Pick.up"),
  Price = c("20", "30", "50"),
  Distance = c("Walking Distance", "Short Drive", "Long Drive")), # Corrected the attribute names and levels
  nalternatives = 2, 
  nblocks = 1)

questionnaire(choice.experiment.design = des2)

save(des2, file = "design.RData")

