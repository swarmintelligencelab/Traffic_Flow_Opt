# Python Code for Advection Dynamics in Traffic Networks: Modeling, Analysis, and Optimization

This repository contains the Python scripts necessary to reproduce the results presented in the article. 

The scripts generate figures and perform analyses as described below.

## Contents

### Illustrative Example
- **`illustrative_example.py`**: This script generates the results corresponding to the Illustrative Example presented in the article, producing Figures 3 and 4.

### Spatial Analysis and Optimal Intervention
- **`spatial_analysis.py`**: This script performs the spatial analysis and runs the model using calibrated parameters.
- **`optimal_intervention.py`**: This script computes the optimal intervention strategies for Upper West Manhattan and generates Figure 7.

## Traffic Data
The vehicle count data was obtained from the New York City Department of Transportation (NYCDOT) through Automated Traffic Recorders (ATR). The original dataset can be accessed at: NYC Automated Traffic Volume Counts.

## Road Network and Traffic Analysis
This script constructs a road network graph for Upper West Manhattan, incorporating real-world traffic data from NYCDOT. It processes the graph by assigning attributes like speed limits, lane count, and vehicle capacity. The script then generates a dual graph representation, aligns its nodes spatially, and associates weights with its edges. It further integrates Automated Traffic Recorder (ATR) data, filters relevant segments, and maps traffic observations onto the graph. Finally, it simulates congestion dynamics and performs optimization to determine intervention strategies for improving traffic flow.


## Contact
For any questions or issues, please contact **David Angulo** at **dangulog@unal.edu.co** or **Daniel Burbano** at **daniel.burbano@rutgers.edu**.

