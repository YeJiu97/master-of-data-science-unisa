# Factorials / Permutations / Combinations

expand.grid(1:16, 1:16)



# binom coef (n, k) =  n! / (k! * (n-k)!)

factorial(16)/(factorial(14) * factorial(2))

choose(16, 2)

t(combn(1:16, 2))



# Discrete Choice Experiment

rm(list=ls())
gc()

library(support.CEs)

# Nice and easy "lucky" design of 9 questions only
# Balanced fractional factorial design - every level appears the same number of times

des1 <- rotation.design(attribute.names = list(Region = c("Reg_A", "Reg_B", "Reg_C"),
                                               Eco = c("Conv.", "More", "Most"),
                                               Price = c("1", "1.1", "1.2")),
                        nalternatives = 2, nblocks = 1)
des1



# Assume that you want to have 8 questions only
# Unbalanced fractional factorial design tries to be as close as possible to balanced,
# however allows some levels to be more frequent than others

library(AlgDesign)

# There are three steps:

# 1. Prepare a full-factorial design for your factors and levels.
ffd <- gen.factorial(c(3,3,3), varNames = c("Region", "Eco", "Price"), factors = "all")

# 2. Extract 8 questions from the full-factorial design.
# There can be any number you need.
alt_des <- optFederov(~., ffd, 8)$design

# 3. Use the same function as before but with an extra parameter of the
# given design prepared on step 2.
des2 <- rotation.design(candidate.array = alt_des,
                        attribute.names = list(Region = c("Reg_A", "Reg_B", "Reg_C"),
                                               Eco = c("Conv.", "More", "Most"),
                                               Price = c("1", "1.1", "1.2")),
                        nalternatives = 2, nblocks = 1)
des2

####

# When you have experiment design file you can proceed as per class presentation.

questionnaire(choice.experiment.design = des1)

# or 

questionnaire(choice.experiment.design = des2)


####

# Discrete Choice Experiment

rm(list=ls())
gc()

library(support.CEs)

des1 <- rotation.design(attribute.names = list(Region = c("Reg_A", "Reg_B", "Reg_C"),
                                               Eco = c("Conv.", "More", "Most"),
                                               Price = c("1", "1.1", "1.2")),
                        nalternatives = 2, nblocks = 1, row.renames = FALSE, randomize = TRUE, seed = 987)

questionnaire(choice.experiment.design = des1)

data("syn.res1")
syn.res1[1:3, ]


desmat1 <- make.design.matrix(choice.experiment.design = des1,
                              optout = TRUE, categorical.attributes = c("Region", "Eco"),
                              continuous.attributes = c("Price"), unlabeled = TRUE)

desmat1[1:3, ]

dataset1 <- make.dataset(respondent.dataset = syn.res1, 
                         choice.indicators = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9"),
                         design.matrix = desmat1)
dataset1[1:10, ]

library(survival)
clogout1 <- clogit(RES ~ ASC + Reg_B + Reg_C + More + Most + More:F + Most:F + Price + strata(STR), 
                   data = dataset1)

clogout1

gofm(clogout1)

# Calculating the marginal willingness to pay
mwtp(output = clogout1, monetary.variables = c("Price"),
     nonmonetary.variables = c("Reg_B", "Reg_C", "More", "Most", "More:F", "Most:F"), 
     confidence.level = 0.90, seed = 987)



