library(ggplot2)
library(dplyr)
library(tidyr)

# Load the beer dataset
beer <- read.csv("wber9.csv")

# Define color palettes for the graphics
palette1 <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
palette2 <- c("#F8766D", "#00BFC4")

# Define elementary, intermediate, and overall reading levels
elementary <- theme(axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"))
intermediate <- theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))
overall <- theme(axis.text=element_text(size=10), axis.title=element_text(size=12,face="bold"))

# Design principle for all graphics: use appropriate axis labels and titles

# Graphic 1: Total sales by week
g1 <- beer %>%
  group_by(WEEK) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=WEEK, y=Total_Sales)) +
  geom_line(color=palette1[1]) +
  labs(title="Total Sales by Week", x="Week", y="Total Sales") # +
  # elementary

g1

# Questions answered by Graphic 1:
# - What was the overall trend of sales over time?
# - Were there any spikes or dips in sales during certain weeks?

# Graphic 2: Sales by store
g2 <- beer %>%
  group_by(STORE) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=reorder(STORE,Total_Sales), y=Total_Sales, fill=STORE)) +
  geom_bar(stat="identity") +
  labs(title="Total Sales by Store", x="Store", y="Total Sales") +
  # intermediate +
  theme(axis.text.x=element_text(angle=90, vjust=0.5))

g2

# Questions answered by Graphic 2:
# - Which stores had the highest and lowest sales?
# - Were there any outliers in terms of sales by store?

# Graphic 3: Sales by price range
g3 <- beer %>%
  mutate(Price_Range=cut(PRICE, breaks=c(0,5,10,15,20,25))) %>%
  group_by(Price_Range) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=Price_Range, y=Total_Sales, fill=Price_Range)) +
  geom_bar(stat="identity") +
  labs(title="Total Sales by Price Range", x="Price Range", y="Total Sales") # +
  # intermediate

g3

# Questions answered by Graphic 3:
# - Which price range had the highest sales?
# - Was there a clear relationship between price and sales?

# Graphic 4: Sales by store and week
g4 <- beer %>%
  group_by(STORE,WEEK) %>%
  summarise(Total_Sales=sum(MOVE)) %>%
  ggplot(aes(x=WEEK, y=Total_Sales, fill=STORE)) +
  geom_col(position="dodge") +
  labs(title="Sales by Store and Week", x="Week", y="Total Sales", fill="Store") +
  intermediate

g4

  