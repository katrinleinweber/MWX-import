## Import function for .MWX files created by "[Swift II](http://www.thomassci.com/Instruments/Spectrophotometers/_/3E7A29F1-7EBD-43BB-9FBF-192625BE4C61) Multi Wavelength Version 2.00" program ([Biochrom Ltd](http://www.biochrom.co.uk/))

This software can be used to control an "[Ultrospec 2100 pro UV/Visible  Spectrophotometer](http://www.thomassci.com/Instruments/Spectrophotometers/_/0A56FFDB-A8B9-473E-99CF-960599F301B7)" and uses a CSV-like export format. This script provides a function to import these MWX files into an R dataframe. Please see `#` comments in [the .R file](MWX-import.R) for usage instructions. Tested with the included example files on Win7 with "[RStudio Version 0.98.1103](http://www.rstudio.com/products/rstudio/download/)"

[![DOI](https://zenodo.org/badge/6673/katrinleinweber/MWX-import.svg)](http://dx.doi.org/10.5281/zenodo.18105)

#### Note

Ensure MWX export in Swift II by activating `Export Spreadsheet` under `Run > Medhod > Run Options`. Otherwise, it saves only some other format called MWD.

#### To do

- [ ] package
- [ ] split into several functions
