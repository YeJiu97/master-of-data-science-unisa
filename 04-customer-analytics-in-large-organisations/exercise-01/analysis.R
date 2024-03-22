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


# ============== Doing analysis =====================================
## ============= 转换为二进制 =================
# 将自变量转换为二进制的0和1值
binary_data <- cleaned_numeric_data %>%
  mutate(
    age_under_40 = ifelse(`12. Your age:` == 1, 1, 0),
    age_40_to_59 = ifelse(`12. Your age:` == 2, 1, 0),
    age_60_or_older = ifelse(`12. Your age:` == 3, 1, 0)
  ) %>%
  select(-`12. Your age:`)

# 查看转换后的数据集结构
str(binary_data)



