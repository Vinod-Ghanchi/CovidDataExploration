# COVID-19 Data Analysis Project

## Overview

This repository contains scripts and queries for analyzing COVID-19 data, specifically focusing on deaths and vaccinations. The project uses SQL queries to extract and manipulate data from the PortfolioProject database, covering aspects such as total cases, total deaths, infection rates, vaccination rates, and more.

## Project Structure

- **SQLScripts folder**: Contains the SQL queries used for data analysis.
  - `CovidDataExploration.sql`: Queries related to COVID-19 deaths and Vaccinations.


## How to Use

1. **Database Setup**:
   - Make sure you have access to the PortfolioProject database.
   - Execute the SQL scripts in the `SQLScripts` folder to create the necessary tables or views.

2. **Running Queries**:
   - Open and execute the desired SQL scripts in your preferred SQL environment.
   - Adjust filters or conditions in the queries as needed.

3. **Visualization**:
   - The project includes examples of visualizations using temporary tables, common table expressions (CTEs), and views.
   - Refer to the `Visualization` section in each SQL script or query for more details.

## Visualizations

### PercentPopulationVaccinated View

The `PercentPopulationVaccinated` view provides insights into the vaccination percentages based on the COVID-19 deaths data.

```sql
SELECT * FROM PercentPopulationVaccinated
