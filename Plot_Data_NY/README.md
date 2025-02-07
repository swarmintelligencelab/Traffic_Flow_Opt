# Traffic Flow Models in NYC

This repository contains all code and datasets used for plotting the results of traffic flow models applied to New York City (NYC).



## Repository Contents

### Datasets:
- **`Adjacency_Matrix.csv`**: Contains the estimated adjacency matrix representing the connectivity of the road network.
- **`Curated_Data.csv`**: A dataset containing time series of vehicle counts obtained from the West Side road network in Manhattan. Red circles in the dataset indicate the location of traffic sensors.
- **`Data_Calibration_model.mat`**: The raw output from model calibration without adjustments.

### Model Parameters:
- **`Parameters_a.csv`**: Contains the curated values of parameter `a`, calibrated within the model.
- **`Parameters_b.csv`**: Contains the curated and calibrated values corresponding to parameter `b` in the model.

### Main Script:
- **`Plot_Results_Main_NY.m`**: The primary script that executes all computations and generates the plots for the NYC case study as presented in the article.

## Data Source
The vehicle count data was obtained from the **New York City Department of Transportation (NYCDOT)** through **Automated Traffic Recorders (ATR)**. The original dataset can be accessed at:
[NYC Automated Traffic Volume Counts](https://data.cityofnewyork.us/Transportation/Automated-Traffic-Volume-Counts/7ym2-wayt/about_data).

## Usage
To reproduce the results:
1. Ensure all dataset files are placed in the correct folder structure.
2. Run **`Plot_Results_Main_NY.m`** in MATLAB.
3. The script will process the data and generate visualizations corresponding to the NYC case study.

For any issues or inquiries, please refer to the article associated with this study.

