library(support.CEs)

des1 <- rotation.design(attribute.names = list(Region = c("Reg_A", "Reg_B", "Reg_C"),
                                               Eco = c("Conv.", "More", "Most"),
                                               Price = c("1", "1.1", "1.2")),
                        nalternatives = 2, nblocks = 1)
des1

questionnaire(choice.experiment.design = des1)

data("syn.res1")

syn.res1

desmat1 <- make.design.matrix(choice.experiment.design = des1,
                              optout = TRUE, categorical.attributes = c("Region", "Eco"),
                              continuous.attributes = c("Price"), unlabeled = TRUE)

desmat1

dataset1 <- make.dataset(respondent.dataset = syn.res1, 
                         choice.indicators = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9"),
                         design.matrix = desmat1)

library(survival)
clogout1 <- clogit(RES ~ ASC + Reg_B + Reg_C + More + Most + More:F + Most:F + Price + strata(STR), 
                   data = dataset1)

clogout1

gofm(clogout1)

# Calculating the marginal willingness to pay
mwtp(output = clogout1, monetary.variables = c("Price"),
     nonmonetary.variables = c("Reg_B", "Reg_C", "More", "Most", "More:F", "Most:F"), 
     confidence.level = 0.90, seed = 987)
