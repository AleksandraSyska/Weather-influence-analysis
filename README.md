# Public Safety and Mortality Analysis in Poland

## 📌 Project Overview
This project performs a comprehensive statistical analysis of public safety and demographic trends in Poland using **R**. It integrates data related to fire incidents, road traffic accidents, and mortality rates to visualize patterns and identify regional risks.

## 📡 Data Sourcing (API)
The project is designed to work with public datasets. It is configured to fetch and process data through **Public Open Data APIs**, allowing for automated analysis of the most recent statistics provided by government institutions.

## 🧮 Analytical Modules
The analysis is divided into three core scripts:

* **Fire Incidents (`rpozary.R`)**: Analyzes the frequency and location of fire outbreaks across Poland.
* **Road Accidents (`rwypadki.R`)**: Processes traffic safety data, highlighting major causes and incident rates.
* **Mortality Trends (`rzgony.R`)**: Investigates demographic changes and mortality statistics over time.

## 🚀 Key Features
* **API Integration**: Automated data handling for seamless updates of public safety statistics.
* **Data Preprocessing**: Scripts for cleaning and structured formatting of raw administrative data.
* **Statistical Visualization**: Detailed plots and charts created using R's visualization ecosystem (e.g., `ggplot2`).
* **Regional Benchmarking**: Comparison of safety metrics across different Polish voivodeships.

## 📂 File Structure
* `rpozary.R` – Analysis of fire hazard data.
* `rwypadki.R` – Analysis of traffic accident statistics.
* `rzgony.R` – Analysis of mortality and demographic trends.
* `data/` – Directory containing local cached versions of `.csv` and `.xlsx` datasets.

## 🛠 Setup and Usage
1.  **Requirements**: Install R and RStudio.
2.  **Dependencies**: Install the necessary packages for data processing and visualization:
    ```r
    install.packages(c("tidyverse", "ggplot2", "readxl", "httr", "jsonlite"))
    ```
3.  **Run Analysis**: Execute the scripts to pull data from the API and generate the statistical reports.

---
**Author:** Aleksandra Syska
