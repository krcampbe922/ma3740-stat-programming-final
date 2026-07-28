# assumption checking
# helper function for checking assumptions
check_assumptions <- function(differences, title) {
  # shapiro-wilk test
  shapiro_test <- shapiro.test(differences)
  # qq plot
  qqplot <- ggplot(data.frame(differences = differences), aes(sample = differences)) +
    stat_qq() +
    stat_qq_line(color = "red") +
    theme_minimal() +
    labs(title = paste("Q-Q Plot:", title),
         x = "Theoretical Quantiles",
         y = "Sample Quantiles")
  
  # boxplot
  boxplot <- ggplot(data.frame(differences = differences), aes(y = differences)) +
    geom_boxplot(fill = "lightblue") +
    theme_minimal() +
    labs(title = paste("Boxplot of Differences:", title),
         y = "Difference") +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank())
  print(qqplot)
  print(boxplot)
  return(list(shapiro_test = shapiro_test, 
              qqplot = qqplot,
              boxplot = boxplot))
}

# individual store comparisons:
# Walmart vs Walgreens
assumptions_walmart_walgreens <- check_assumptions(
  result_walmart_walgreens[[8]],
  "Walmart vs Walgreens"
)
# Walmart vs Pat's
assumptions_walmart_pats <- check_assumptions(
  result_walmart_pats[[8]], 
  "Walmart vs Pat's"
)
# Walmart vs Tadych's
assumptions_walmart_tadychs <- check_assumptions(
  result_walmart_tadychs[[8]], 
  "Walmart vs Tadych's"
)
# Walgreens vs Pat's
assumptions_walgreens_pats <- check_assumptions(
  result_walgreens_pats[[8]], 
  "Walgreens vs Pat's"
)
# Walgreens vs Tadych's
assumptions_walgreens_tadychs <- check_assumptions(
  result_walgreens_tadychs[[8]], 
  "Walgreens vs Tadych's"
)
# Pat's vs Tadych's
assumptions_pats_tadychs <- check_assumptions(
  result_pats_tadychs[[8]], 
  "Pat's vs Tadych's"
)

# qq plot arrangement for report:
(assumptions_walmart_walgreens$qqplot + 
    assumptions_walmart_pats$qqplot + 
    assumptions_walmart_tadychs$qqplot) / 
  (assumptions_walgreens_pats$qqplot + 
     assumptions_walgreens_tadychs$qqplot + 
     assumptions_pats_tadychs$qqplot) +
  plot_annotation(title = "Q-Q Plots: Paired T-tests for Price Differences Between Stores")


# boxplot arrangement for report:
(assumptions_walmart_walgreens$boxplot + 
    assumptions_walmart_pats$boxplot + 
    assumptions_walmart_tadychs$boxplot) / 
  (assumptions_walgreens_pats$boxplot + 
     assumptions_walgreens_tadychs$boxplot + 
     assumptions_pats_tadychs$boxplot) +
  plot_annotation(title = "Boxplots: Paired T-tests for Price Differences Between Stores")

# store comparisons (ANOVA):
residuals_anova <- residuals(anova_stores$"Product_Name:Store_Name")
assumptions_anova <- check_assumptions(
  residuals_anova,
  "Repeated Measures ANOVA - Stores"
)

qqnorm(residuals_anova)
qqline(residuals_anova)
shapiro.test(residuals_anova)

# sphericity
sphericity_test <- aov_ez(
  id = "Product_Name",
  dv = "Price_Per_Oz",
  within = "Store_Name",
  data = store_comparisons
)
summary(sphericity_test, sphericity = TRUE)

# chain versus local stores
assumptions_chain_local <- check_assumptions(
  result_chain_local[[8]], 
  "Chain vs Local Stores"
)

# speciality versus regular formulas
assumptions_specialty_regular <- check_assumptions(
  result_specialty_regular[[8]], 
  "Specialty vs Regular Formula"
)
