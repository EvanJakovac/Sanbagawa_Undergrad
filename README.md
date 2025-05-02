# MATLAB SCRIPTS: Sanbagawa_Undergrad
Jakovac - EBSD Investigation of the Sanbagawa Schist - Undergraduate Thesis 

Last Edited 05.2025

Contact edj5098@psu.edu for questions


This repository includes a number of scripts for data processing. 
Below is a table of contents of the included scripts, as well as their function, inputs, and outputs

NOTE: THE MTEX TOOLBOX MUST BE INSTALLED IN MATLAB FOR USE OF MOST OF THIS CODE 

### EBSD_Processing.m 

Original Author: Leah Youngquist 

Input: EBSD Data (ctf); quartz .cif

Output: Pole Figures; Microstructure maps

### CrossRelict.m

Cross, A. J., Prior, D. J., Stipp, M., & Kidder, S. (2017). The recrystallized grain size piezometer for quartz: An EBSD‐based calibration. Geophysical Research Letters, 44(13), 6667–6674. https://doi.org/10.1002/2017GL073836

Input: EBSD Data (ctf); crystal symmetry identifier 

Output: Relict vs. Recrystallized grain info/maps ; differential stress

### SG Piezometer Scripts (Goddard et al., 2020)

Goddard, R. M., Hansen, L. N., Wallis, D., Stipp, M., Holyoke, C. W., Kumamoto, K. M., & Kohlstedt, D. L. (2020). A Subgrain‐Size Piezometer Calibrated for EBSD. Geophysical Research Letters, 47(23), e2020GL090056. https://doi.org/10.1029/2020GL090056

There is a word document in the supplementary info with instructions for script use. 

Input: EBSD Data (ctf)

Output: Differential stress 

###
