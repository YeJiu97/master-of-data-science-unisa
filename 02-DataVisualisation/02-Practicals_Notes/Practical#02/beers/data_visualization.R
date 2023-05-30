library(tidyverse)

beer <- read.csv("wber9.csv")


ggplot(data = beer) +
  geom_freqpoly(mapping = aes(x = PROFIT, color = SALE), binwidth = 10, size = 1) +
  labs(title = "Distribution of Profit for Each Sale")


beer %>%
  group_by(WEEK) %>%
  summarise(Total_Sales = sum(MOVE)) %>%
  ggplot(aes(x = WEEK, y = Total_Sales)) +
  geom_line() +
  labs(title="Total Sales by Week", x="Week", y="Total Sales")


beer %>%
  mutate(Price_Range=cut(PRICE, breaks=c(0,5,10,15,20,25))) %>%
  group_by(Price_Range) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=Price_Range, y=Total_Sales, fill=Price_Range)) +
  geom_bar(stat="identity") +
  labs(title="Total Sales by Price Range", x="Price Range", y="Total Sales")


beer %>%
  mutate(Profit_Range=cut(PROFIT, breaks=c(-100,-75,-50,-25,0,25,50,75,100))) %>%
  group_by(Profit_Range) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=Profit_Range, y=Total_Sales, fill=Profit_Range)) +
  geom_bar(stat="identity") +
  labs(title="Total Sales by Profit Range", x="Profit Range", y="Total Sales")


beer %>%
  mutate(Store_Range=cut(STORE, breaks=c(0,30,60,90,120,150))) %>%
  group_by(Store_Range,WEEK) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=WEEK, y=Total_Sales, fill=Store_Range, color = Store_Range)) +
  geom_line(position="dodge", size = 0.8, alpha = 0.6) +
  labs(title="Sales by Store and Week", x="Week", y="Total Sales", fill="Store")

beer %>%
  group_by(WEEK) %>%
  summarize(Average_Price = mean(PRICE)) %>%
  ggplot(aes(x = WEEK, y = Average_Price)) +
  geom_line() +
  labs(title = "Average Price Per Week")

beer %>%
  group_by(WEEK) %>%
  summarize(Average_Profit = mean(PROFIT)) %>%
  ggplot(aes(x = WEEK, y = Average_Profit)) +
  geom_line() +
  labs(title = "Average Profit Per Week")
