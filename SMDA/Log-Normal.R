# Load required packages
library(MASS)       # For fitdistr
library(ggplot2)    # Optional, for custom plotting (not used below)

# Load your Excel data (adjust the filename if needed)
data <- read.csv("C:/Users/Sreesatvik/Documents/college files/final_payroll_analysis_with_best_distributions.csv")

# View column names to confirm
names(data)

# Function to fit and plot Log-Normal distribution
plot_lognormal_fit <- function(column_data, var_name) {
  # Remove NA values
  column_data <- na.omit(column_data)
  
  # Fit Log-Normal distribution
  # Note: log-normal means log(data) ~ Normal
  log_data <- log(column_data)
  fit <- fitdistr(log_data, "normal")  # fit meanlog and sdlog
  meanlog_hat <- fit$estimate["mean"]
  sdlog_hat <- fit$estimate["sd"]
  
  # Generate x and y for the PDF
  x_vals <- seq(min(column_data), max(column_data), length.out = 100)
  y_vals <- dlnorm(x_vals, meanlog = meanlog_hat, sdlog = sdlog_hat)
  
  # Plot histogram and fitted PDF
  hist(column_data, breaks = 30, probability = TRUE, col = "lightgray",
       main = paste("Log-Normal Fit for", var_name),
       xlab = var_name)
  lines(x_vals, y_vals, col = "darkgreen", lwd = 2)
  legend("topright", legend = c("Fitted Log-Normal"), col = "darkgreen", lwd = 2)
}

# Apply the function to each of your columns
plot_lognormal_fit(data$Base_Salary, "Base_Salary")
plot_lognormal_fit(data$Bonus, "Bonus")
plot_lognormal_fit(data$Payroll_Tax, "Payroll_Tax")

