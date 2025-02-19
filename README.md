# Pedersen-2023-sep-and-plasma-treat
Data and analysis on wind tunnel measurements of ammonia (NH3) and volatile organic compound (VOC) emission from field-applied pig or digested slurry.

# Maintainer
Johanna Pedersen. 

Contact information here: <https://www.researchgate.net/profile/Johanna-Pedersen>.

# Published paper
The contents of this repo are associated with the following paper:

Pedersen, J., Labouriau, R., Feilberg, A. Effect of slurry separation and air-plasma treatment on NH3 and VOC emissions from field applied biogas digestate and pig slurry to grassland. Biosystems Engineering 247, 257-266. 2024. https://doi.org/10.1016/j.biosystemseng.2024.09.014

# Overview
This repo contains (nearly) all the data and data processing scripts needed to produce the results presented in the paper listed above. 
The scripts run in R (<https://www.r-project.org/>) and require several add-on packages.
These packages are listed in multiple `packages.R` in `script-*` directories.
All packages are available on CRAN. 

Scripts for calculation of emission data from raw wind tunnel measurements are included, but data files are too large and are not included. 
However all resulting emission measurements can be found in `data-NH3` and `data-VOC`.

# Directory structure

## `data`
Data files with slurry properties (slurry.summ.txt), slurry surface pH after application (surface_pH.xlsx), and ambient air temperature during experiments (w**H.csv).

## `data-ESA`
ESA results after imaging analysis (ESAdata.csv). 
Results of statistical analysis of ESA data (ESA_231218.xlsx). 


## `data-NH3`
Results of statistical analysis (231218-NEO-NH3.xlsx) and flux of measured NH3. 

## `data-VOC`
Measurement data, flux of each individual measured VOC from each individual dynamic flux chamber over time. 

## `functions` 
Functions used by various scripts.

## `output`
Cumulative NH3 emission from each individual WT (dn11.csv) and average of each treatment within a trial (dn22.csv). Cumulative VOC emission of each individual compound from each treatment in each trial (dv.**.csv).

## `plots`
Plots of data including plots used in manuscript. 

## `scripts-ESA`
MatLab script for processing ESA data, example provided. Raw data (images) not provided as they are too large. 
R scripts for producing ESA plot, where the script `main.R` calls all others. 

## `scipts-NH3`
R scripts for processing NH3 data.
The script `main.R` calls all others.

## `scripts-pH-and-temp`
R scripts for processing slurry surface pH and ambient temperature data. 
The script `main.R` calls all others. 

## `scipts-VOC`
R scripts for processing VOC data.
The script `main.R` calls all others.

## `scripts-WT` 
R scripts for processing WT data to calculate measured NH3 and NMVOC emission. 
Data files are too large to include but scripts are still included here for partial reproducibility.
The script `main.R` calls all others.

# Links to published paper 
This section give the source of tables, figures, etc. in the paper. 
| Paper component 		|  Repo source                          	   |  Repo scripts             	|
|-----------------		|-----------------                         	   |---------------            	|
| Table 1			| data/w*** (weather data)			| 				|
| Table 2			| data/slurry.summ				| 				|
| Table 3			| data-ESA/ESA_231218				| 	 			|
| Table 4			| output/dn22.csv   and data-NH3/231218-NEO-NH3   | data_NH3/summary.R  	|
| Table S2			| data/slurry.summ				| 				|
| Figure 1			| slurry/ESA01.pdf				| scipts-ESA/plot.R		|
| Figure 2			| plots/surface_pH.pdf 				|scripts-pH-and-weather/plot.R 	|
| Figure 3			| plots/flux02.pdf				| scripts-NH3/plot.R 		|
| Figure S1			| plots/abmient_temp.pdf			| scripts-pH-and-weather/plot.R |
| Figure S3			| plots/flux01.pdf				| scripts-NH3/plot.R		|
	














