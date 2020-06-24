# Ontario-Covid-Tracker-Interactive-Map

## Update (June 24, 2020)

The github pages static covid tracker is now deprecated. It will no longer be updated after June 20/2020

The **updated application** is now hosted on shiny with auto-updating data and filter capabilities here: https://bzhang93.shinyapps.io/covid-tracker/
The code for the shiny app can be found in app.R in the master branch.

## Original Readme (June 20/20):

Created by: Bowen Zhang 

Dataset Downloaded: June 20/2020

Download Most updated data from Ontario Data Catalogue: [Ontario Data Catalogue](https://data.ontario.ca/dataset/confirmed-positive-cases-of-covid-19-in-ontario/resource/455fd63b-603d-4608-8216-7d8647f43350) 

## Overview: 
Interactive Map to track Ontario's COVID cases per the location of the hospital that reported each case. 

Files:
1. interactivemap.Rmd  - The R Markdown File containing the code chunks that created the final product
2. interactivemap.md - markdown version (use this when reading from github)
3. interactivemap.html - the html output 

Final Product: https://b-zhang93.github.io/Ontario-Covid-Tracker-Interactive-Map/


## Possible Updates
- make data updates dynamic 
- expand region / more detailed information regarding each case
- show overall resolved/fatal/not-resolved cases rather than having individual markers at max zoom. (saves loading time for hospitals with large data points)
