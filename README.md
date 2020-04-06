# covid19_google_mobility_map
Percent change from Jan-Feb median in mobility 

[Link to github page website with maps that has hover-over data (state name and percentage)](https://mychan24.github.io/covid19_google_mobility_map/)

# Data
Data were scraped from [google.com/covid19/mobility/](https://www.google.com/covid19/mobility/), roughtly extracted from the PDFs of each state.
See `.Rmd` file for code that generated the maps.

# Maps
Plotting percentage change for each state. Separating the categories that only show reduction to show finer resolution of change in color-bar.

## General reduction in density: Retail/Grocery/Transit/Workplaces
![Reduction in mobility in these categoires](figs/reduced_map.png)

## General increase in density: Residential

* People are staying home more

![Mixed increase/decrease in mobility in these categoires](figs/increased_map.png)


## Mixed change in density: Parks

* Huge surges in people going to parks in certain states. 

![Mixed increase/decrease in mobility in these categoires](figs/mixed_map.png)


