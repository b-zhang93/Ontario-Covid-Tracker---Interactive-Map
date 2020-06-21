---
title: "Ontario COVID Tracker - By Hospital Locations"
author: "Bowen Zhang"
output: html_document
---

**Accurate as of 6/20/2020**

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```

```{r load data, cache=TRUE}
# load our dataset from Ontario Data Catalogue. Downloaded June 20/2020

url <- "https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/455fd63b-603d-4608-8216-7d8647f43350/download/conposcovidloc.csv"

download.file(url, destfile = "covid.csv")
covdata <- read.csv("covid.csv")
```

```{r map, out.width="100%", fig.height=8, message=FALSE}
library(leaflet)

subdata <- covdata[,c(9,3,16,17)]
names(subdata) <- c("outcome", "date", "lat", "lng")

subdata <- mutate(subdata, color = factor(subdata$outcome,
                                          levels = c("Resolved", "Fatal", "Not Resolved"),
                                          labels = c("blue", "black", "red")))

icons <- awesomeIcons(icon = "cases",
                      iconColor = "black",
                      library = "ion",
                      markerColor = subdata$color)

subdata %>%
        leaflet() %>%
        addTiles() %>%
        addAwesomeMarkers(icon = icons, clusterOptions = markerClusterOptions(), 
                          popup = paste("Status:", subdata$outcome, "| Reported:", subdata$date)) %>% 
        addLegend(labels = c("Resolved", "Fatal", "Not Resolved"), colors = c("blue", "black", "red"))

```

Data from Ontario Data Catalogue. Downloaded 6/20/2020. [Link Here](https://data.ontario.ca/dataset/confirmed-positive-cases-of-covid-19-in-ontario/resource/455fd63b-603d-4608-8216-7d8647f43350).

Project Github: [Github](https://github.com/b-zhang93/Ontario-Covid-Tracker-Interactive-Mairmed-positive-casep)



