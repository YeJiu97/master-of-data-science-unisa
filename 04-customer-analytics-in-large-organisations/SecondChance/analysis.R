library(support.CEs)
library(readxl)
library(survival)


# check the original survey questions generated by R code
load("Design.RData")
questionnaire(choice.experiment.design = des2)



# import survey data
survey_data <- read_excel("Numeric export Exploring Diverse Dining-Out Experiences_2.xlsx")
survey_data_dataframe <- as.data.frame(survey_data)
survey_data_dataframe<- survey_data_dataframe[-1,1:12]


# clean NA data
survey_data_dataframe <- na.omit(survey_data_dataframe)
# check whether NA valus is existing or not
anyNA_exists <- any(is.na(survey_data_dataframe))
if (anyNA_exists) {
  print("NA value exists")
} else {
  print("No NA Values")
}


colnames(survey_data_dataframe) <- c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "gender", "age", "ethnicity")


# add ID column in to survey_data_dataframe
survey_data_dataframe$ID <- seq_along(survey_data_dataframe$q1)
survey_data_dataframe$BLOCK <- 1

# make sure ID column is the first column
survey_data_dataframe <- survey_data_dataframe[, c("ID", "BLOCK", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "gender", "age", "ethnicity")]

# make a check for that
colnames(survey_data_dataframe)


# data matrix
desmat2 <- make.design.matrix(choice.experiment.design = des2, 
                              optout = TRUE,
                              categorical.attributes = c("Cuisine", "Delivery", "Distance"),
                              continuous.attributes = c("Price"), unlabeled = TRUE)

desmat2[1:3, ]


# 创建一个新的数据框，仅包含ID列和q1到q9列
# survey_data_subset <- survey_data_dataframe[, c("ID", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9")]

# 检查新数据框的列名，确认它包含了正确的列
# colnames(survey_data_subset)


# dataset
dataset2 <- make.dataset(respondent.dataset = survey_data_dataframe,
                         choice.indicators = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9"),
                         design.matrix = desmat2)

dataset2[1:4, ]


# dataset2 <- dataset1[, !colnames(dataset1) %in% c("age")]
clogout1 <- clogit(RES ~ ASC + Indian + Japanese + Delivery + Pick.up + Short.Drive + Long.Drive + Price + strata(STR), 
                   data = dataset2)


clogout1 <- clogit(RES ~ ASC + Asian.Cuisine + European.Cuisine + delivery + dining.in + 
                     # delivery:gender + delivery:type + dining.in:gender + dining.in:type +
                     Price + strata(STR), 
                   data = dataset1)
