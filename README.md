# Pedersen-2023-sep-and-plasma-treat
Data and analysis on wind tunnel measurements of ammonia (NH3) and non-methane volatile organic compound (NMVOC) emission from field-applied pig or digested slurry. The data and analysis is associated with research paper currently in progress. 

# In progress
This is a work in progress. 
The paper has not yet been published. 

# Maintainer
Johanna Pedersen 
Contact information here: <https://www.researchgate.net/profile/Johanna-Pedersen>.

# Published paper
The contents of this repo are presented in the following paper:

...

# Overview
This repo contains (nearly) all the data and data processing scripts needed to produce the results presented in the paper listed above. 
The scripts run in R (<https://www.r-project.org/>) and require several add-on packages.
These packages are listed in multiple `packages.R` in `script-*` directories.
All packages are available on CRAN. 

Scripts for calculation of emission data from raw wind tunnel measurements are included, but data files are too large and are not included. 
However all resulting emission measurements can be found in `data-NH3` and 'data-NMVOC.

# Directory structure

## 'data-ESA'
ESA results after imaging analysis (ESAdata.csv). 
Results of statistical analysis of ESA data (ESA_231218.xlsx). 

## `data-NH3` 
Measurement data, flux of measured NH3 from each individual dynamic flux chamber over time. 
Results of statistical analysis (231218-NEO-NH3.xlsx).

## 'data-NMVOC'
Measurement data, flux of each individual measured NMVOC from each individual dynamic flux chamber over time. 

## 'scripts-WT' 
R scripts for processing WT data to calculate measured NH3 and NMVOC emission. 
Data files are too large to include but scripts are still included here for partial reproducibility.
The script `main.R` calls all others.

## 'scripts-ESA'
MatLab script for processing ESA data, example provided. Raw data (images) not provided as they are too large. 
R scripts for producing ESA plot, where the script 'main.R' calls all others. 


# Links to published paper 
This section give the source of tables, figures, etc. in the paper. 
| Paper component 		|  Repo source                             |  Repo scripts             |
|-----------------		|-----------------                         |---------------            |
| Table MMM, NH3 data 		| output/dn22.csv   and data-NH3/231218-NEO-NH3   | data_NH3/summary.R  	|
| Figure LLL			| plots/flux01.pdf			| scripts-NH3/plot.R |
| Figure KKK			| plots/surface_pH.pdf 			|scripts-pH-and-weather/plot.R |
| Figure SAAB			| plots/abmient_temp.pdf		| scripts-pH-and-weather/plot.R |
| Table SNNN			| output/ (dv.dA, dv.dB, dv.pA, dv.pB)	| scripts-NMVOC/export.R |
| Table WWW			| data-ESA/ESA_231218			|  	 |














