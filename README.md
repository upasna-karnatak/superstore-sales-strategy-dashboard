# superstore-sales-strategy-dashboard


An interactive Tableau dashboard analysing 9,994 US retail transactions (2014–2017) 
to answer four business questions for a Regional Sales Director persona, uncovering 
a hidden loss-making product line masked by strong overall revenue.

## Business Context

**Persona:** Jordan Blake, Regional Sales Director, responsible for commercial 
performance across four US regions and three product categories.

**Questions addressed:**
1. Which categories generate the highest sales, and how does profitability compare?
2. Does discounting help or hurt profit — and at what point does it destroy value?
3. How has regional revenue evolved over time, and which regions are growing fastest?
4. Which specific sub-categories are quietly losing money beneath strong headline sales?

## Key Finding

**Tables (a Furniture sub-category) generate a total loss of $17,725** — the single 
worst-performing sub-category in the dataset, losing money in every region except 
the West. This was only discoverable through an interactive brushing action linking 
the category-level bar chart to a sub-category heatmap — the loss is completely 
invisible at the category level, where Furniture's overall sales look healthy.

## Dashboard

![Full dashboard](screenshots/dashboard-full.png)

### SQ1 — Sales Ranking vs. Profitability
![SQ1](screenshots/sq1-sales-vs-margin.png)

Technology leads both average sales ($542/order) and profit margin (15.61%). 
Furniture ranks second in sales ($421/order) but its margin (3.88%) is barely 
a quarter of Technology's — a warning sign hidden by strong top-line sales.

### SQ2 — Impact of Discounting on Profit
![SQ2](screenshots/sq2-discount-impact.png)

Average profit turns negative once discounts exceed 20%, and losses deepen to 
–$107 per order at discounts above 31%. The break-even reference line makes the 
threshold immediately visible.

### SQ3 — Regional Revenue Trends
![SQ3](screenshots/sq3-regional-trends.png)

West shows the steepest growth trajectory across the four-year period, while 
South remains consistently flat. All four regions show a structural Q4 seasonal 
spike, with East peaking at $98K in Q4 2017.

### Complex Question — Sub-Category Losses by Region
![CQ heatmap](screenshots/cq-subcategory-heatmap.png)

Clicking the Furniture bar in the SQ1 chart filters this heatmap via a brushing 
interaction, revealing that Tables lose money in Central, East, and South — a 
structural pricing issue rather than a regional anomaly.

## Methodology

- **Data cleaning:** performed in R — type verification, duplicate/missing value 
  checks, column pruning, and date conversion using `as.Date()`
- **Feature engineering:** four derived variables created — profit margin %, 
  profit status, discount band, and temporal (year/quarter) fields
- **Design process:** dashboard layout was paper-prototyped before implementation; 
  one design assumption (a scatter plot for the discount-profit relationship) was 
  revised to a binned bar chart after testing showed the raw discount field only 
  contained 12 discrete values, making a scatter plot unreadable
- **Interactivity:** category-level brushing filters a linked sub-category heatmap; 
  Segment and Year filter widgets scoped to the heatmap view

## Tools

Tableau Desktop · R (data cleaning & feature engineering) · Dataset: 
[Superstore Sales Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final) (Kaggle)

## Files in this repository

- `Superstore.R` — data cleaning and feature engineering script
- `superstore_cleaned.csv` — cleaned dataset (9,994 rows, 17 columns)
- `2550926_CS5803.dashboard.twbx` — full Tableau packaged workbook
- `screenshots/` — dashboard and story-point exports

## Notes

This was completed as part of the MSc Data Science & Analytics programme at 
Brunel University London (CS5803 Data Visualisation). 
