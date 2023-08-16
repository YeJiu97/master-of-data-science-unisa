# ========= libraries ==========================================================
library(e1071)  # Load the e1071 package for naiveBayes
library(caret)
library(dplyr)

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
print(confusion_matrix)


# =============== accuracy =====================================================
# Create a trainControl object for 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10)

# Perform cross-validation using Naive Bayes model
cv_results <- train(class ~ ., data = data_cleaned, method = "naive_bayes", trControl = ctrl)

# Print cross-validation results
print(cv_results)

# Generate confusion matrix
confusion_matrix <- confusionMatrix(cv_results)
print(confusion_matrix)



# ========= 3-BINS =============================================================
# Define the number of bins
num_bins <- 3

# Function to perform equal-frequency binning with unique breaks
equal_freq_bins <- function(column, num_bins) {
  breaks <- quantile(column, probs = seq(0, 1, 1/num_bins))
  breaks <- unique(round(breaks, digits = 2))  # Round to ensure unique breaks
  bin_column <- cut(column, breaks, labels = FALSE, include.lowest = TRUE)
  return(bin_column)
}

# Apply equal-frequency binning to numeric columns
data_discretized <- data_cleaned %>%
  mutate_at(vars(-class), ~ equal_freq_bins(., num_bins))

# Show the first few rows of the discretized dataset
head(data_discretized)



# ========= build a new nb model ===============================================
# Convert class column to factor
data_discretized$class <- as.factor(data_discretized$class)

# Split the dataset into training and testing sets
set.seed(123)  # for reproducibility
train_index <- sample(1:nrow(data_discretized), 0.7 * nrow(data_discretized))
train_data <- data_discretized[train_index, ]
test_data <- data_discretized[-train_index, ]

# Build Naïve Bayes model
model_nb <- naiveBayes(class ~ ., data = train_data)

print(model_nb)

# Create a trainControl object for 5-fold cross-validation
cv_ctrl <- trainControl(method = "cv", number = 5)

# Perform cross-validation using Naive Bayes model with discretized data
cv_results_nb <- train(class ~ ., data = data_discretized, method = "naive_bayes", trControl = cv_ctrl)

# Print cross-validation results
print(cv_results_nb)

# Generate confusion matrix for Naive Bayes model
confusion_matrix_nb <- confusionMatrix(cv_results_nb)
print(confusion_matrix_nb)
