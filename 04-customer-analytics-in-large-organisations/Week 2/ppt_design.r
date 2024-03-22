library(AlgDesign)

ffd <- gen.factorial(c(2,2,4), varNames = c("HAC", "ECO", "PRI"), factors = "all")
ffd

library(support.CEs)
des1 <- rotation.design(attribute.names = list(
  Region = c('region_A', 'region_B', 'region_c'),
  Eco = c('Conv', 'More', 'Most'),
  Price = c('1', '1.1', '1.2')),
  nalternatives = 2, nblocks = 1, row.renames = FALSE,
  randomize = TRUE, seed = 987)

questionnaire(choice.experiment.design = des1)


data("syn.res1")
syn.res1[1:3, ]

desmat1 <- make.design.matrix(choice.experiment.design = des1,
                              optout = TRUE, categorical.attributes = c("Region", "Eco"),
                              continuous.attributes = c("Price"), unlabeled = TRUE)
desmat1[1:3, ]



dataset1 <- make.dataset(respondent.dataset = syn.res1,
                         choice.indicators = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9"), design.matrix = desmat1)

dataset1


library(survival)
clogout1 <- clogit(RES ~ ASC + region_B + region_c + More + Most + Price + strata(STR), data = dataset1)

gofm(clogout1)


mwtp(output = clogout1, monetary.variables = c("Price"), 
     nonmonetary.variables = c("region_B", "region_c", "More", "Most", "More:F",
                               "Most:F"), confidence.level = 0.90, seed = 987)
