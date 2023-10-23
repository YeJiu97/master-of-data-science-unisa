# 导入必备的库
library(rpart)
library(rpart.plot)
library(caret)
library(randomForest)
library(e1071)

# ================ import data set
# 导入数据集
melb_house_data <- read.csv("df_selected.csv", header = TRUE)

# Get the column name of the non-numeric column
non_numeric_cols <- sapply(melb_house_data, is.character)

# Convert non-numeric columns to factors
melb_house_data[non_numeric_cols] <- lapply(melb_house_data[non_numeric_cols], as.factor)

# Use str() function to verify the result
str(melb_house_data)

# ================= RANDOM FOREST TREE
# 设置随机数种子以确保结果可重现
set.seed(123)

# 找出数据集中的分类变量
categorical_cols <- sapply(melb_house_data, is.factor)

# 将分类变量独立出来
categorical_data <- melb_house_data[, categorical_cols]

# 使用model.matrix对分类变量进行独热编码
encoded_categorical_data <- model.matrix(~ ., data = categorical_data)

# 合并编码后的分类变量和原始数据集，但不包括目标变量
encoded_melb_house_data <- cbind(melb_house_data[, !categorical_cols], encoded_categorical_data)

# 选择特征和目标变量
features_encoded <- encoded_melb_house_data[, -which(names(encoded_melb_house_data) == "PRICE_INTERVAL")]
target_encoded <- encoded_melb_house_data$PRICE_INTERVAL


# 创建随机森林模型
model1 <- randomForest(target ~ ., data = encoded_melb_house_data , ntree = 100, mtry = 3)
model2 <- randomForest(target ~ ., data = encoded_melb_house_data , ntree = 200, mtry = 4)
model3 <- randomForest(target ~ ., data = encoded_melb_house_data , ntree = 300, mtry = 5)

# 导入混淆矩阵函数
library(caret)

# 定义评估函数
evaluate_model <- function(model, data) {
  predictions <- predict(model, data)
  confusion_matrix <- confusionMatrix(predictions, data$PRICE_INTERVAL)
  return(confusion_matrix)
}

# 评估不同参数组合的模型性能
evaluation1 <- evaluate_model(model1, encoded_melb_house_data )
evaluation2 <- evaluate_model(model2, encoded_melb_house_data )
evaluation3 <- evaluate_model(model3, encoded_melb_house_data )

# 查看模型1的性能
evaluation1
# 查看模型2的性能
evaluation2
# 查看模型3的性能
evaluation3
