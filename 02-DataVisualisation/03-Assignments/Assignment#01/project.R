# Load required libraries
library(tidyverse)

# Import the "country_vaccinations.csv" dataset
country_vaccinations <- read.csv("country_vaccinations.csv")

# Import the "country_vaccinations_by_manufacturer.csv" dataset
country_vaccinations_by_manufacturer <- read.csv("country_vaccinations_by_manufacturer.csv")

# summary
summary(country_vaccinations)

# drop
country_vaccinations_clean <- na.omit(country_vaccinations)



############### Graphic #01

library(ggplot2)

top_20_total_vaccinations <- country_vaccinations_clean %>%
  group_by(country) %>%
  summarize(total_vaccinations = max(total_vaccinations)) %>%
  arrange(desc(total_vaccinations)) %>%
  head(20)

ggplot(top_20_total_vaccinations, aes(x = reorder(country, total_vaccinations), y = total_vaccinations, fill = country)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "Top 20 Countries with Highest Total Vaccinations", x = "Country", y = "Total Vaccinations") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1, size = 10),
        legend.position = "none") +
  scale_fill_viridis_d()



#############  Graphic #02
library(ggplot2)

ggplot(country_vaccinations_clean, aes(x = total_vaccinations, y = daily_vaccinations)) +
  geom_point(alpha = 0.6, color = "#008080") +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Total Vaccinations", y = "Daily Vaccinations", title = "Total vs. Daily Vaccinations by Country") +
  theme_minimal()


#############  Graphic #03
library(ggplot2)
library(dplyr)
library(tidyr)
library(viridis)

# Separate vaccines column into multiple rows
vaccines_df <- country_vaccinations_clean %>%
  separate_rows(vaccines, sep = ",\\s*")

# Count the frequency of each vaccine
vaccines_count <- vaccines_df %>%
  group_by(vaccines) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Select the top 10 most common vaccines and group the rest as "Other"
vaccines_top10 <- vaccines_count %>%
  slice_max(n = 10, order_by = count) %>%
  mutate(vaccines = if_else(row_number() == 10, "Other", vaccines))

# Plot the bar chart
vaccines_plot <- ggplot(vaccines_top10, aes(x = vaccines, y = count, fill = vaccines)) +
  geom_bar(stat = "identity") +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  labs(title = "Top 10 COVID-19 Vaccines Used", x = "Vaccine", y = "Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

vaccines_plot



vaccines_top10 <- vaccines_count %>%
  slice_max(n = 10, order_by = count) %>%
  mutate(vaccines = if_else(row_number() == 10, "Other", vaccines)) %>%
  mutate(vaccines = fct_reorder(vaccines, count))

vaccines_plot <- ggplot(vaccines_top10, aes(x = vaccines, y = count, fill = vaccines)) +
  geom_bar(stat = "identity") +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  labs(title = "Top 10 COVID-19 Vaccines Used", x = "Vaccine", y = "Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

vaccines_plot




########### Graphic 4
library(ggplot2)

# Subset data to include only relevant variables and convert date column to Date type
vaccinations <- country_vaccinations_clean %>%
  select(country, date, daily_vaccinations, vaccines) %>%
  mutate(date = as.Date(date))

# Select countries with large population
selected_countries <- c("China", "United States", "India", "Brazil", "Indonesia")
vaccinations_selected <- vaccinations %>% filter(country %in% selected_countries)

# Group data by country and date to calculate the mean daily vaccinations
vaccinations_by_country <- vaccinations_selected %>%
  group_by(country, date) %>%
  summarise(mean_daily_vaccinations = mean(daily_vaccinations, na.rm = TRUE)) %>%
  ungroup()

# Plot mean daily vaccinations by country and date
ggplot(vaccinations_by_country, aes(x = date, y = mean_daily_vaccinations, color = country)) +
  geom_line() +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  labs(x = "Date", y = "Mean Daily Vaccinations", title = "COVID-19 Vaccinations by Country") +
  theme_minimal()



library(ggplot2)

vaccinations_by_country$date <- lubridate::ymd(vaccinations_by_country$date)

# Subset data to include only relevant variables and selected countries
vaccinations <- country_vaccinations_clean %>%
  filter(country %in% c("United States", "India", "Brazil", "Russia", "China")) %>%
  select(country, date, daily_vaccinations, vaccines)

# Group data by country and date to calculate the mean daily vaccinations
vaccinations_by_country <- vaccinations %>%
  group_by(country, date) %>%
  summarise(mean_daily_vaccinations = mean(daily_vaccinations, na.rm = TRUE)) %>%
  ungroup()

# Plot mean daily vaccinations by country and date
ggplot(vaccinations_by_country, aes(x = date, y = mean_daily_vaccinations, color = country)) +
  geom_line() +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  labs(x = "Date", y = "Mean Daily Vaccinations", title = "COVID-19 Vaccinations by Country") +
  theme_minimal()


library(ggplot2)

library(lubridate)
country_vaccinations_clean$date <- ymd(country_vaccinations_clean$date)

# Subset data to include only relevant variables
vaccinations <- country_vaccinations_clean %>%
  filter(country %in% c("United States", "China", "India", "Brazil", "Russia")) %>%
  select(country, date, daily_vaccinations, vaccines)

# Group data by country and date to calculate the mean daily vaccinations
vaccinations_by_country <- vaccinations %>%
  group_by(country, date) %>%
  summarise(mean_daily_vaccinations = mean(daily_vaccinations, na.rm = TRUE)) %>%
  ungroup()

# Plot mean daily vaccinations by country and date
ggplot(vaccinations_by_country, aes(x = date, y = mean_daily_vaccinations, color = country)) +
  geom_line() +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  labs(x = "Date", y = "Mean Daily Vaccinations", title = "COVID-19 Vaccinations by Country") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
