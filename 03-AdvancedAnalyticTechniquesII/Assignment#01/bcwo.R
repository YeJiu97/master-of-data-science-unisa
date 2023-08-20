# ========= libraries ==========================================================
library(e1071)  # Load the e1071 package for naiveBayes
library(caret)
library(dplyr)
set.seed(123)  # for reproducibility

# ===========  Import dataset and explore ======================================
# import dataset
data <- read.csv("breast-cancer-wisconsin.data")  

# set column names for the dataset
column_names <- c("id_number", "clump_thickness", "cell_size_uniformity", "cell_shape_uniformity",
                  "marginal_adhesion", "single_epithelial_cell_size", "bare_nuclei",
                  "bland_chromatin", "normal_nucleoli", "mitoses", "class")

# modify the dataset
colnames(data) <- column_names

# missing values types
missing_formats <- c("?", "NA", "", "NaN", "nan")  # Add other formats as needed

# function for missing values
is_missing <- function(value) {
  return(value %in% missing_formats)
}

missing_counts <- sapply(data, function(column) sum(sapply(column, is_missing)))
print(missing_counts)

# Remove rows with "?" as missing values
data_cleaned <- data[data$bare_nuclei != "?", ]

# check the result
missing_counts_cleaned <- sapply(data_cleaned, function(column) sum(sapply(column, is_missing)))
print(missing_counts_cleaned)

nrow(data)
nrow(data_cleaned)

write.csv(data_cleaned, file =  "data_cleaned.csv")

# ============ naive bayes model ===============================================
# Remove the ID attribute
data_cleaned <- data_cleaned[, -which(names(data_cleaned) == "id_number")]

# Convert all attributes except "class" to numeric
numeric_columns <- setdiff(names(data_cleaned), "class")
data_cleaned[numeric_columns] <- sapply(data_cleaned[numeric_columns], as.numeric)

# Convert "class" to factor
data_cleaned$class <- as.factor(data_cleaned$class)

# Output data types of each column
column_types <- sapply(data_cleaned, class)
print(column_types)

# Train a naive Bayes model
model <- naiveBayes(class ~ ., data = data_cleaned)

# View summary of the trained model
summary(model)
print(model)



# Calculation
prior_probabilities <- c(0.6495601, 0.3504399)

conditional_probabilities <- list(
  clump_thickness = matrix(c(2.959368, 7.188285, 1.671743, 2.437907), ncol = 2, byrow = TRUE),
  cell_size_uniformity = matrix(c(1.306998, 6.577406, 0.8565007, 2.7242438), ncol = 2, byrow = TRUE),
  cell_shape_uniformity = matrix(c(1.415350, 6.560669, 0.9579102, 2.5691040), ncol = 2, byrow = TRUE),
  marginal_adhesion = matrix(c(1.347630, 5.585774, 0.9179766, 3.1966314), ncol = 2, byrow = TRUE),
  single_epithelial_cell_size = matrix(c(2.108352, 5.326360, 0.8780881, 2.4430866), ncol = 2, byrow = TRUE),
  bare_nuclei = matrix(c(1.347630, 7.627615, 1.179064, 3.116679), ncol = 2, byrow = TRUE),
  bland_chromatin = matrix(c(2.081264, 5.974895, 1.062604, 2.282422), ncol = 2, byrow = TRUE),
  normal_nucleoli = matrix(c(1.261851, 5.857741, 0.9556042, 3.3488761), ncol = 2, byrow = TRUE),
  mitoses = matrix(c(1.065463, 2.602510, 0.5103046, 2.5644946), ncol = 2, byrow = TRUE)
)

record <- c(1, 5, 4, 4, 5, 7, 10, 3, 2)

prob_class_2 <- prior_probabilities[1]
prob_class_4 <- prior_probabilities[2]

for (i in 1:length(record)) {
  prob_class_2 <- prob_class_2 * conditional_probabilities[[names(record)[i]]][record[i], 1]
  prob_class_4 <- prob_class_4 * conditional_probabilities[[names(record)[i]]][record[i], 2]
}

prob_class_2
prob_class_4


# =========== Prediction by using that model ===================================
# Create a sample record (replace with actual values)
sample_record <- data.frame(
  clump_thickness = 5,
  cell_size_uniformity = 3,
  cell_shape_uniformity = 4,
  marginal_adhesion = 2,
  single_epithelial_cell_size = 2,
  bare_nuclei = 3,
  bland_chromatin = 4,
  normal_nucleoli = 3,
  mitoses = 1
)

# Make predictions using the trained model
predictions <- predict(model, newdata = sample_record)

# Print the predicted class
print(predictions)

# ================ accuracy ====================================================
# Create a trainControl object for 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10)

# Perform cross-validation using Naive Bayes model
cv_results <- train(class ~ ., data = data_cleaned, method = "naive_bayes", trControl = ctrl)

# Print cross-validation results
print(cv_results)

# Generate confusion matrix
confusion_matrix <- confusionMatrix(cv_results)
conf_matrix <- confusionMatrix(predict(cv_results, data_cleaned), data_cleaned$class)
print(confusion_matrix)


# ========= 3-BINS =============================================================

# define the number of bins
num_bins <- 3

# Create a new data frame to store the discretized data
data_discretized <- data_cleaned

# Get the column names of continuous feature variables
continuous_columns <- colnames(data_cleaned)[colnames(data_cleaned) != "class"]

# Equal frequency binning for each continuous feature
for (col in continuous_columns) {
  data_discretized[[col]] <- cut(data_cleaned[[col]], 
                                 breaks = num_bins, 
                                 labels = FALSE,
                                 include.lowest = TRUE)  # 包含最小值在第一个箱中
}


# print a summary of the discretized data
summary(data_discretized)


# ========= build a new nb model ===============================================
# Convert class column to factor
data_discretized$class <- as.factor(data_discretized$class)

num_folds <- 5
nb_model <- naiveBayes(class ~ ., data = data_discretized)

cv_results <- trainControl(method = "cv", number = num_folds)
accuracy <- train(class ~ ., data = data_discretized, method = "naive_bayes", trControl = cv_results)$results$Accuracy
cat("Accuracy using 5-fold cross-validation:", accuracy, "\n")

# 预测分类结果
predicted <- predict(nb_model, data_discretized)

# 创建混淆矩阵
confusion_matrix <- confusionMatrix(predicted, data_discretized$class)
cat("Confusion Matrix:\n")
print(confusion_matrix)



# ========= calculation ==========================

# 提取记录的属性值
new_record <- c(clump_thickness = 1,
                cell_size_uniformity = 2,
                cell_shape_uniformity = 1,
                marginal_adhesion = 1,
                single_epithelial_cell_size = 2,
                bare_nuclei = 2,
                bland_chromatin = 3,
                normal_nucleoli = 1,
                mitoses = 1)

# 计算每个类别的后验概率
p_y2 <- 0.6495601
p_y4 <- 0.3504399

# 计算给定类别的条件概率
p_x_given_y2 <- prod(dnorm(new_record, mean = nb_model$tables$clump_thickness[1,1], sd = nb_model$tables$clump_thickness[1,2]),
                     dnorm(new_record, mean = nb_model$tables$cell_size_uniformity[1,1], sd = nb_model$tables$cell_size_uniformity[1,2]),
                     dnorm(new_record, mean = nb_model$tables$cell_shape_uniformity[1,1], sd = nb_model$tables$cell_shape_uniformity[1,2]),
                     dnorm(new_record, mean = nb_model$tables$marginal_adhesion[1,1], sd = nb_model$tables$marginal_adhesion[1,2]),
                     dnorm(new_record, mean = nb_model$tables$single_epithelial_cell_size[1,1], sd = nb_model$tables$single_epithelial_cell_size[1,2]),
                     dnorm(new_record, mean = nb_model$tables$bare_nuclei[1,1], sd = nb_model$tables$bare_nuclei[1,2]),
                     dnorm(new_record, mean = nb_model$tables$bland_chromatin[1,1], sd = nb_model$tables$bland_chromatin[1,2]),
                     dnorm(new_record, mean = nb_model$tables$normal_nucleoli[1,1], sd = nb_model$tables$normal_nucleoli[1,2]),
                     dnorm(new_record, mean = nb_model$tables$mitoses[1,1], sd = nb_model$tables$mitoses[1,2]))

p_x_given_y4 <- prod(dnorm(new_record, mean = nb_model$tables$clump_thickness[2,1], sd = nb_model$tables$clump_thickness[2,2]),
                     dnorm(new_record, mean = nb_model$tables$cell_size_uniformity[2,1], sd = nb_model$tables$cell_size_uniformity[2,2]),
                     dnorm(new_record, mean = nb_model$tables$cell_shape_uniformity[2,1], sd = nb_model$tables$cell_shape_uniformity[2,2]),
                     dnorm(new_record, mean = nb_model$tables$marginal_adhesion[2,1], sd = nb_model$tables$marginal_adhesion[2,2]),
                     dnorm(new_record, mean = nb_model$tables$single_epithelial_cell_size[2,1], sd = nb_model$tables$single_epithelial_cell_size[2,2]),
                     dnorm(new_record, mean = nb_model$tables$bare_nuclei[2,1], sd = nb_model$tables$bare_nuclei[2,2]),
                     dnorm(new_record, mean = nb_model$tables$bland_chromatin[2,1], sd = nb_model$tables$bland_chromatin[2,2]),
                     dnorm(new_record, mean = nb_model$tables$normal_nucleoli[2,1], sd = nb_model$tables$normal_nucleoli[2,2]),
                     dnorm(new_record, mean = nb_model$tables$mitoses[2,1], sd = nb_model$tables$mitoses[2,2]))

# 计算后验概率
posterior_y2 <- p_x_given_y2 * p_y2
posterior_y4 <- p_x_given_y4 * p_y4

# 进行分类决策
if (posterior_y2 > posterior_y4) {
  predicted_class <- "2"
} else {
  predicted_class <- "4"
}

# 输出分类结果
print(paste("Predicted class:", predicted_class))


# 要分类的记录
new_record <- data.frame(
  clump_thickness = 1,
  cell_size_uniformity = 2,
  cell_shape_uniformity = 1,
  marginal_adhesion = 1,
  single_epithelial_cell_size = 2,
  bare_nuclei = 2,
  bland_chromatin = 3,
  normal_nucleoli = 1,
  mitoses = 1
)

predicted_class <- predict(nb_model, new_record)
print(predicted_class)
