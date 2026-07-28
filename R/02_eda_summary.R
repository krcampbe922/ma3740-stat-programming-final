# summary counts
count_by_store <- data %>% count(Store_Name)
count_by_storetype <- data %>% count(Store_Type)
count_by_category <- data %>% count(Category)

# histogram distribution of price per ounce
ggplot(data, aes(x = Price_Per_Oz)) +
  geom_histogram(aes(y = after_stat(density)), bins = 20, alpha = 0.6) +
  theme_minimal() +
  labs(title = "Distribution of Price per Ounce",
       x = "Price per Ounce",
       y = "Density")
# density curve of price per ounce by store type
ggplot(data, aes(x = Price_Per_Oz, fill = Store_Type)) +
  geom_density(alpha = 0.4) +
  theme_minimal() +
  labs(title = "Density of Price per Ounce by Store Type",
       x = "Price per Ounce",
       y = "Density")

# summary statistic tables
# across all stores
stats_store <- data %>%
  group_by(Store_Name) %>%
  summarise(
    n = n(),
    Mean_Price = mean(Price_Per_Oz),
    Sd_Price = sd(Price_Per_Oz)
  )
stats_store
# chain versus local
stats_storetype <- data %>%
  group_by(Store_Type) %>%
  summarise(
    n = n(),
    Mean_Price = mean(Price_Per_Oz),
    Sd_Price = sd(Price_Per_Oz)
  )
stats_storetype
# formula type
stats_category <- data %>%
  group_by(Category) %>%
  summarise(
    n = n(),
    Mean_Price = mean(Price_Per_Oz),
    Sd_Price = sd(Price_Per_Oz)
  )
stats_category

# visualizations
# boxplot of price per ounce by store
p_store <- ggplot(data, aes(x = Store_Name, y = Price_Per_Oz)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = 0.6) +
  theme_minimal() +
  labs(title = "Price per Ounce by Store",
       x = "Store",
       y = "Price per Ounce (USD/oz)")
# boxplot of price per ounce for chain and local
p_chainlocal <- ggplot(data, aes(x = Store_Type, y = Price_Per_Oz)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Price per Ounce: Chain vs Local Stores",
       x = "Store Type",
       y = "Price per Ounce (USD/oz)")
# boxplot of price per ounce by formula category
p_category <- ggplot(data, aes(x = Category, y = Price_Per_Oz)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Price per Ounce by Formula Category",
       x = "Formula Type",
       y = "Price per Ounce (USD/oz)")
# put all boxplots onto one panel
combined_panel <- p_store | p_chainlocal | p_category
combined_panel
