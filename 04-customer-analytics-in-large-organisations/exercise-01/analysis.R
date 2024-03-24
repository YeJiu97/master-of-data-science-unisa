# 导入 readxl 包
library(readxl)
library(dplyr)


# ================= FUll text export Xlsx =============
# 读取 Excel 文件
data <- read_excel("Full text export Clone of wangjun's project.xlsx")

# 选择数据集的前12列
selected_data <- data[, 1:12]

# 查看选择的数据集结构
str(selected_data)

# 去除包含NA的行
cleaned_data <- na.omit(selected_data)

# 查看去除NA后的数据集结构
str(cleaned_data)


# ===============  Numeric export Clone of wangjun's project ========
# 读取 Excel 文件
numeric_data <- read_excel("Numeric export Clone of wangjun's project.xlsx")

# 选择数据集的前12列
selected_numeric_data <- numeric_data[, 1:12]

# 去除包含NA的行
cleaned_numeric_data <- na.omit(selected_numeric_data)

# 查看去除NA后的数据集结构
str(cleaned_numeric_data)



# =================================

# library(dplyr)
# library(tidyr)
# 
# # 假设 selected_data 是包含描述性选择的数据框
# 
# # 转换描述性数据为适合分析的格式
# selected_data_processed <- selected_data %>%
#   # 使用mutate和str_extract从每个描述性选择中提取信息
#   mutate(
#     Cuisine_Type = case_when(
#       grepl("American Cuisine", `1. Please select your preferred choice from the options provided below:`) ~ "American",
#       grepl("Asian Cuisine", `1. Please select your preferred choice from the options provided below:`) ~ "Asian",
#       grepl("European Cuisine", `1. Please select your preferred choice from the options provided below:`) ~ "European",
#       TRUE ~ NA_character_
#     ),
#     Distance = case_when(
#       grepl("Long Drive Distance", `1. Please select your preferred choice from the options provided below:`) ~ "Long",
#       grepl("Short Drive Distance", `1. Please select your preferred choice from the options provided below:`) ~ "Short",
#       grepl("Walking Distance", `1. Please select your preferred choice from the options provided below:`) ~ "Walking",
#       TRUE ~ NA_character_
#     ),
#     Dining_Type = case_when(
#       grepl("delivery", `1. Please select your preferred choice from the options provided below:`) ~ "Delivery",
#       grepl("dining-in", `1. Please select your preferred choice from the options provided below:`) ~ "DiningIn",
#       grepl("take-away", `1. Please select your preferred choice from the options provided below:`) ~ "TakeAway",
#       TRUE ~ NA_character_
#     ),
#     Price = as.numeric(gsub(".*Price : \\$(\\d+).*", "\\1", `1. Please select your preferred choice from the options provided below:`))
#   ) %>%
#   # 删除原始的描述性列
#   select(-`1. Please select your preferred choice from the options provided below:`) %>%
#   # 转换为哑变量
#   mutate(across(c(Cuisine_Type, Distance, Dining_Type), as.factor)) %>%
#   dummy_cols(select_columns = c("Cuisine_Type", "Distance", "Dining_Type"))
# 
# # 检查处理后的数据
# str(selected_data_processed)
