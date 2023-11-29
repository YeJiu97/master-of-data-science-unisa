original_df <- read.csv("a2-housing.csv")
str(original_df)


# 创建新的数据框
new_data <- data.frame(
  AGE = c(89.91372549019603, 59.4011299435028, 92.62142857142858, 90.1257142857143),
  B = c(371.80303921568645, 387.66542372881304, 212.38642857142855, 55.669714285714285),
  CRIM = c(10.910511274509803, 0.33039867231638403, 1.894067857142857, 16.34608571428571),
  DIS = c(2.077163725490196, 4.5281302259887, 2.2739928571428574, 1.9883342857142858),
  INDUS = c(18.572549019607816, 8.100621468926542, 17.323571428571423, 18.10000000000001),
  LSTAT = c(17.874019607843135, 10.19926553672316, 16.427857142857142, 21.007428571428573),
  MEDV = c(17.42941176470588, 25.107042253521158, 17.52857142857143, 12.9),
  NOX = c(0.671225490196078, 0.5042723943661983, 0.704714285714286, 0.6668285714285714),
  PTRATIO = c(20.195098039215715, 17.859718309859144, 16.50714285714285, 20.200000000000006),
  RAD = c(23.019607843137255, 4.443502824858757, 4.785714285714286, 24.0),
  RM = c(5.98226470588235, 6.401214084507043, 5.957142857142856, 6.076),
  TAX = c(668.2058823529412, 309.16338028169014, 390.35714285714283, 666.0),
  ZN = c(0.0, 16.12676056338028, 0.0, 0.0)
)

# 将新的数据添加到原始数据集
updated_df <- rbind(original_df, new_data)

# 打印更新后的数据集结构
str(updated_df)

# 对数据集进行标准化
scaled_df <- as.data.frame(scale(updated_df))

# 打印标准化后的数据集结构
str(scaled_df)



# 提取最后的四行作为聚类中心
centroids <- scaled_df[(nrow(scaled_df) - 3):nrow(scaled_df), ]

# 提取除最后的四行之外的所有行作为数据点
data_points <- scaled_df[1:(nrow(scaled_df) - 4), ]




# Calculate distance between each row of df_a and df_b
distances <- matrix(NA, nrow(data_points), nrow(centroids))

for (i in 1:nrow(data_points)) {
  for (j in 1:nrow(centroids)) {
    distances[i, j] <- sqrt(sum((data_points[i, ] - centroids[j, ])^2))
  }
}

# Create a new dataframe with distances
dist_df <- as.data.frame(distances)
colnames(dist_df) <- paste0("Distance_to_row_", 1:nrow(centroids))
rownames(dist_df) <- paste0("Row_", 1:nrow(data_points))

# Print the resulting dataframe
print(dist_df)

min_values <- apply(dist_df, 1, min)
min_values

standard_deviation <- sd(min_values, na.rm = TRUE)
standard_deviation

anomaly_score <- min_values / standard_deviation
anomaly_score

anomaly_df <- anomaly_score[anomaly_score > 3]


cleaned_anomaly_df <- na.omit(anomaly_df)
print(cleaned_anomaly_df)

summary(cleaned_anomaly_df)
hist(cleaned_anomaly_df, main = "Anomaly Scores Distribution", xlab = "Anomaly Score", ylab = "Frequency")
boxplot(cleaned_anomaly_df, main = "Boxplot of Anomaly Scores")

special_anomaly_data <- anomaly_score[anomaly_score > 8]
special_anomaly_data


# 计算每列的平均值，去除NA值
column_means <- colMeans(original_df, na.rm = TRUE)

# 打印每列的平均值
print(column_means)
