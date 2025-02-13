# Traffic Flow and Optimization in NYC

This repository contains code and datasets used for analyzing and optimizing traffic flow in New York City (NYC). The repository is divided into two subfolders, each focusing on different aspects of traffic modeling and analysis.

## Repository Structure

### 1. Traffic Flow Models in NYC
This subfolder contains MATLAB scripts and datasets for studying traffic flow models in NYC. It includes:

- **Datasets**: Adjacency matrix, curated time-series traffic data, and model calibration outputs.
- **Model Parameters**: Files containing calibrated parameters used in the traffic models.
- **Main Script**: The MATLAB script `Plot_Results_Main_NY.m` that processes data and generates visualizations.
- **Traffic Data Source**: Vehicle count data from NYCDOT's Automated Traffic Recorders (ATR). The dataset is available at: [NYC Automated Traffic Volume Counts](https://data.cityofnewyork.us/Transportation/Automated-Traffic-Volume-Counts/7ym2-wayt/about_data).

### 2. Python Code for Advection Dynamics in Traffic Networks
This subfolder contains Python scripts for modeling, analyzing, and optimizing traffic flow dynamics using a graph-based approach. It includes:

- **Illustrative Example**: Python scripts generating example results and figures.
- **Spatial Analysis & Optimization**: Scripts performing spatial analysis, running the model, and computing optimal intervention strategies for Upper West Manhattan.
- **Traffic Data Processing**: Integration of ATR data, network graph construction, congestion simulation, and intervention optimization.

## Dependencies
To run the Python scripts, install the following dependencies:
```sh
pip install -r requirements.txt
```
For the MATLAB scripts, ensure MATLAB is installed with the required toolboxes.

## Usage
To reproduce the results:
- Run `Plot_Results_Main_NY.m` in MATLAB for the NYC traffic flow models.
- Execute `illustrative_example.py`, `spatial_analysis.py`, and `optimal_intervention.py` in Python for the advection dynamics model.

## Contact
For any questions or issues, please contact:
- **David Angulo** at **dangulog@unal.edu.co**
- **Daniel Burbano** at **daniel.burbano@rutgers.edu**

