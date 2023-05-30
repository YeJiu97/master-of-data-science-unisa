library(tidyverse)

beer_df <- read.csv("wber9.csv")
length(unique(beer_df$UPC))  # 可以发现UPC有778个，通过UPC来替代Brand是不现实的

beer_df

# 将Week修改为factor
beer_df$WEEK <- factor(beer_df$WEEK)

# 对beer_df进行预处理
beer_df_NA <- beer_df %>%
  drop_na() %>%
  filter(PRICE != 0 | !SALE == "")

# 图一：Weekly Prices Distribution
ggplot(data = beer_df_NA) +
  geom_freqpoly(mapping = aes(x = PROFIT, color = SALE), binwidth = 10, size = 1) +
  labs(title = "Distribution of Weekly Prices")

# 图二：Price和Units Sold的散点图
beer_df_NA %>%
  ggplot(aes(x = PRICE, y = MOVE)) +
  geom_point() +
  labs(title = "Units Sold vs. Price", x = "Price", y = "Units Sold")

# 图三：
beer_df_NA %>%
  group_by(WEEK) %>%
  summarize(total_units_sold = sum(MOVE)) %>%
  ggplot(aes(x = WEEK, y = total_units_sold, color = SALE)) +
  geom_line() +
  labs(title = "Units Sold per Week, Grouped by Pack Size", x = "Week", y = "Total Units Sold", color = "Store Number")

# 图四：折线图，
beer_df_NA %>%
  group_by(WEEK) %>%
  summarize(average_price = mean(PRICE)) %>%
  ggplot(aes(x = WEEK, y = average_price)) +
  geom_line() +
  labs(title = "Average Price per Week", x = "Week", y = "Average Price")

# 图五：理论分布图
beer_df_NA %>%
  geom_histogram(mapping = aes(x = ))