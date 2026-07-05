#CS5803 Data Visualization Coursework 
##Student - 2550926
## Amazon sales data set - Data preprocessing and Sampling 
## This script performs data Cleaning , stratified sampling
## and feature engineering to prepare the dataset for Tableau.

# Load required Libraries for cleaning and wrangling
library(tidyverse)  
library(dplyr)
# lubridate for handling dates 
library(lubridate)

# read CSV file into R 
superstore <- read.csv("Superstore.csv", stringsAsFactors = FALSE,encoding = "latin1")
# check number of rows and columns 
nrow(superstore)
ncol(superstore)
print(head(superstore))

# Check data quality / cleaning 
superstore <- distinct(superstore)
cat("\nData types:\n")
print(str(superstore))

cat("\nCategory unique values:", unique(superstore$Category), "\n")
cat("Region unique values:", unique(superstore$Region), "\n")
cat("Segment unique values:", unique(superstore$Segment), "\n")
cat("Sub-Category count:", length(unique(superstore$Sub.Category)), "\n")
# checking for missing values 
print(colSums(is.na(superstore)))
## No duplicate rows and no missing values 

# View structure and summary of dataset 
str(superstore)
summary(superstore)

# Fix date columns 
superstore$Order.Date <- as.Date(superstore$Order.Date, format = "%m/%d/%Y")
superstore$Ship.Date  <- as.Date(superstore$Ship.Date,  format = "%m/%d/%Y")

cat("Order Date range:", as.character(min(superstore$Order.Date)),
    "to", as.character(max(superstore$Order.Date)), "\n")
cat("Date class:", class(superstore$Order.Date), "\n")

# Remove the columns not needed 
superstore <- superstore %>%
  select(-Row.ID,-Ship.Date,
         -Customer.ID, -Customer.Name,
         -Country, -City, -Postal.Code,
         -Product.ID, -Product.Name)

cat("Columns after removing unused ones:", ncol(superstore), "\n")
print(names(superstore))

# Feature Engineering
# Derived 1: profit_margin (%)
# For SQ1 — shows profitability % alongside sales ranking
superstore$profit_margin <- round((superstore$Profit / superstore$Sales) * 100, 2)

# Derived 2: profit_status
# For CQ heatmap — clean Loss/Profit label per transaction
superstore$profit_status <- ifelse(superstore$Profit > 0, "Profit", "Loss")

# Derived 3: discount_band
# For SQ2 : Scatter Plot 
# Discount is stored as decimal: 0.0 = 0%, 0.2 = 20%, 0.8 = 80%
superstore$discount_band <- cut(superstore$Discount,
                        breaks = c(-0.001, 0, 0.1, 0.2, 0.3, 0.8),
                        labels = c("No Discount (0%)",
                                   "Low (1-10%)",
                                   "Medium (11-20%)",
                                   "High (21-30%)",
                                   "Very High (31%+)"),
                        include.lowest = TRUE,
                        right = TRUE)
superstore$discount_band <- as.character(superstore$discount_band)

# Derived 4: order_year
# For SQ3 time axis
superstore$order_year <- as.integer(format(superstore$Order.Date, "%Y"))

# Derived 5: order_quarter
# For SQ3 time axis granularity
superstore$order_quarter <- paste0("Q", quarter(superstore$Order.Date))

# Verify all derived variables
cat("=== DERIVED VARIABLES CHECK ===\n")
cat("\nprofit_margin summary:\n")
print(summary(superstore$profit_margin))
cat("\nprofit_status distribution:\n")
print(table(superstore$profit_status))
cat("\ndiscount_band distribution:\n")
print(table(superstore$discount_band))
cat("\norder_year distribution:\n")
print(table(superstore$order_year))
cat("\norder_quarter distribution:\n")
print(table(superstore$order_quarter))


# Final Verification
cat("Rows:", nrow(superstore), "\n")
cat("Columns:", ncol(superstore), "\n\n")
cat("All column names:\n")
print(names(superstore))

# save cleaned file 
write.csv(superstore,"superstore_clean.csv",row.names = FALSE)
# Final check 
file.exists("superstore_cleaned.csv")




