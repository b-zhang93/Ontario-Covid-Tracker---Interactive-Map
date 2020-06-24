# Ontario-Covid-Tracker-Interactive-Map

## Overview: 
Interactive Map to track Ontario's COVID cases per the location of the hospital that reported each case. 
This updated version primarily uses the Shiny and Leaflet package to run the application. Data is linked to an API and dynamic. The old version was a static page, 
and will no longer be updated. The old files are archived in the Static (deprecated) folder.

Application: [Ontario COVID Tracker](https://bzhang93.shinyapps.io/covid-tracker/)

Files:
1. app.R  <- UI and Server code for Shiny App 
2. style.css <- custom css for the application (refer to credits)
3. covidPres.md <- presentation overview of the functionalities and data of the application. 
4. Static (deprecated) Folder - old files from the static Rmd / HTML version of this project. No longer supported. 

Static (deprecated) Folder Files:
1. interactivemap.Rmd  - The R Markdown File containing the code chunks for the HTML output
2. interactivemap.md - markdown version
3. interactivemap.html - the html output 

## Credits
Data is from the Ontario Data Catalogue: [Ontario Data Catalogue](https://data.ontario.ca/dataset/confirmed-positive-cases-of-covid-19-in-ontario/resource/455fd63b-603d-4608-8216-7d8647f43350) 

**style.css** - the CSS code for the absolute panel styles were based on Rstudio's superzip example with leaflet. [Link to Github Source](https://github.com/rstudio/shiny-examples/tree/master/063-superzip-example)

