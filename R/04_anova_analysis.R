# store comparisons - repeated measures ANOVA
store_comparisons <- data %>%
  select(Product_Name, Store_Name, Price_Per_Oz) %>%
  drop_na() %>%
  filter(n_distinct(Store_Name) == 4)

anova_stores <- aov(Price_Per_Oz ~ Store_Name + Error(Product_Name/Store_Name), data = store_comparisons)
summary(anova_stores)

# chain versus local stores
chain_local_paired <- data %>%
  group_by(Product_Name, Store_Type) %>%
  summarise(Price_Per_Oz = mean(Price_Per_Oz), .groups = "drop") %>%
  select(Store_Type, Product_Name, Price_Per_Oz) %>%
  pivot_wider(names_from = Store_Type, values_from = Price_Per_Oz) %>%
  filter(!is.na(Chain) & !is.na(Local)) 
result_chain_local <- paired_test_report(chain_local_paired, "Chain", "Local")
result_chain_local

# specialty versus regular products
specialty_regular_paired <- data %>%
  group_by(Brand, Store_Name, Category) %>%
  summarise(Price_Per_Oz = mean(Price_Per_Oz), .groups = "drop") %>%
  select(Brand, Store_Name, Category, Price_Per_Oz) %>%
  pivot_wider(names_from = Category, values_from = Price_Per_Oz) %>%
  filter(!is.na(Special) & !is.na(Regular))

result_specialty_regular <- paired_test_report(specialty_regular_paired, "Special", "Regular")
result_specialty_regular
