# helper function for paired t-test
paired_test_report <- function(df_wide, group1, group2) {
  
  diff <- df_wide[[group1]] - df_wide[[group2]]
  test <- t.test(df_wide[[group1]], df_wide[[group2]], paired = TRUE)
  shapiro_out <- shapiro.test(diff)
  # Q-Q Plot
  qq_plot <- ggplot(data.frame(diff = diff), aes(sample = diff)) +
    stat_qq() +
    stat_qq_line() +
    theme_minimal() +
    labs(title = paste("Q-Q Plot of Paired Differences:", group1, "vs", group2))
  print(qq_plot)
  print(shapiro_out)
  return(list(
    Mean_Difference = mean(diff),
    Sd_Difference = sd(diff),
    CI_Lower = test$conf.int[1],
    CI_Upper = test$conf.int[2],
    T_Statistic = as.numeric(test$statistic),
    Df = as.numeric(test$parameter),
    P_Value = test$p.value,
    Differences = diff,
    Shapiro = shapiro_out,
    Test_Object = test
  ))
}
# create pairs of the stores for analysis
make_pairs <- function(storeA, storeB) {
  data %>%
    filter(Store_Name %in% c(storeA, storeB)) %>%
    select(Product_Name, Store_Name, Price_Per_Oz) %>%
    pivot_wider(names_from = Store_Name, values_from = Price_Per_Oz)
}
# run paired t-test on store comparisons
result_walmart_walgreens <- paired_test_report(make_pairs("Walmart", "Walgreen's"), "Walmart", "Walgreen's")
result_walmart_pats      <- paired_test_report(make_pairs("Walmart", "Pat's"),       "Walmart", "Pat's")
result_walmart_tadychs   <- paired_test_report(make_pairs("Walmart", "Tadych's"),    "Walmart", "Tadych's")
result_walgreens_pats    <- paired_test_report(make_pairs("Walgreen's", "Pat's"),    "Walgreen's", "Pat's")
result_walgreens_tadychs <- paired_test_report(make_pairs("Walgreen's", "Tadych's"), "Walgreen's", "Tadych's")
result_pats_tadychs      <- paired_test_report(make_pairs("Pat's", "Tadych's"),      "Pat's", "Tadych's")
result_pats_tadychs

# combine all raw p-values into a single vector
raw_p <- c(
  result_walmart_walgreens$P_Value,
  result_walmart_pats$P_Value,
  result_walmart_tadychs$P_Value,
  result_walgreens_pats$P_Value,
  result_walgreens_tadychs$P_Value,
  result_pats_tadychs$P_Value
)
# combine all comparison pairs into a single vector
comparisons <- c(
  "Walmart vs Walgreens",
  "Walmart vs Pat's",
  "Walmart vs Tadych's",
  "Walgreens vs Pat's",
  "Walgreens vs Tadych's",
  "Pat's vs Tadych's"
)
# Bonferroni adjustment to account for Type I error inflation
p_bonf <- p.adjust(raw_p, method = "bonferroni")
bonf_summary <- data.frame(
  Comparison = comparisons,
  Raw_P = raw_p,
  Bonferroni_Adjusted_P = p_bonf
)
bonf_summary
