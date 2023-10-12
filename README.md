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

## `data-NH3` and 'data-NMVOC'
Measurement data in `data` subdirectory.


## 'scripts-WT' 
R scripts for processing WT data to calculate measured NH3 and NMVOC emission. 
Data files are too large to include but scripts are still included here for partial reproducibility.
The script `main.R` calls all others.

