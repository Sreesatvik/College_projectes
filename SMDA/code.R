# Load required packages     
library(MASS)       # for fitdistr
library(ggplot2)    # for advanced plots


data <- read.csv("C:/Users/Sreesatvik/Documents/college files/final_payroll_analysis_with_best_distributions.csv")

# View column names
names(data)

# Function to fit Weibull and plot
plot_weibull_fit <- function(column_data, var_name) {
  # Remove missing values
  column_data <- na.omit(column_data)
  
  # Fit Weibull distribution
  fit <- fitdistr(column_data, "weibull")
  shape_hat <- fit$estimate["shape"]
  scale_hat <- fit$estimate["scale"]
  
  # Histogram + weibull curve
  x_vals <- seq(min(column_data), max(column_data), length.out = 100)
  y_vals <- dweibull(x_vals, shape = shape_hat, scale = scale_hat)
  
  # Plot
  hist(column_data, breaks = 30, probability = TRUE, col = "lightgray",
       main = paste("Weibull Fit for", var_name),
       xlab = var_name)
  lines(x_vals, y_vals, col = "blue", lwd = 2)
  legend("topright", legend = c("Fitted Weibull"), col = "blue", lwd = 2)
}

# Apply the function to each variable


plot_weibull_fit(data$Base_Salary, "Base_Salary")
plot_weibull_fit(data$Bonus, "Bonus")
plot_weibull_fit(data$Payroll_Tax, "Payroll_Tax")
