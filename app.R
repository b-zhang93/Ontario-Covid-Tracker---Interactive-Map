library(shiny)
library(leaflet)
library(jsonlite)
library(dplyr)
library(curl)

# Get the json api data and convert to a data frame
req_parsed <- fromJSON(
    "https://data.ontario.ca/api/3/action/datastore_search?resource_id=455fd63b-603d-4608-8216-7d8647f43350&limit=100000&fields=Outcome1%2CCase_Reported_Date%2CReporting_PHU_Latitude%2CReporting_PHU_Longitude%2CReporting_PHU"
)
covdata <- data.frame(req_parsed$result$records)
names(covdata) <- c("outcome", "date", "lat", "lng", "health_unit")
# convert from character to date
covdata$date <- as.Date(covdata$date)


# application ui
ui <- fluidPage(
        navbarPage("Ontario Covid Tracker",
               tabPanel("Interactive map",
                        div(class = "outer",
                            
                            tags$head(
                                # custom css
                                includeCSS("style.css")),
                            
                            leafletOutput("covidmap", width = "100%", height = "100%"),
                            
                            absolutePanel(
                                id = "controls",
                                class = "panel panel-default",
                                fixed = TRUE,
                                draggable = TRUE,
                                top = 80,
                                left = "auto",
                                right = 20,
                                bottom = "auto",
                                width = 330,
                                height = "auto",
                                
                                h2("Filter Options"),
                                checkboxInput("show_res", "Show Resolved Cases", value = TRUE),
                                checkboxInput("show_fat", "Show Fatal Cases", value = TRUE),
                                checkboxInput("show_ong", "Show Ongoing Cases", value = TRUE),
                                 dateRangeInput("date_slider", "Date Range", 
                                            "2020-01-23",
                                            Sys.Date()),
                                selectInput("phu", "Select Public Health Unit", 
                                            choices = c("All", unique(covdata$health_unit))))
                            ),
                            
                            tags$div(id="cite",
                                     'Live Data from the Ontario Data Catalogue', 
                                     tags$a(href="https://data.ontario.ca/dataset/confirmed-positive-cases-of-covid-19-in-ontario/resource/455fd63b-603d-4608-8216-7d8647f43350", "Link Here")
                            )
                        ),
               tabPanel("Documentation",
                        tags$h3("Functionality"),
                        tags$div(
                                "- Use the floating panel to filter the data. Clusters show number of cases", tags$br(),
                                "- Filter by status: Resolved, Fatal, Not Resolved",tags$br(),
                                "- Filter by date the cases were reported",tags$br(),
                                "- Filter by individual Public Health Unit",tags$br(),
                                "- Dive into each cluster to view Markers for individual cases (zoom in and click on cluster)",tags$br(),
                                "- Dive into each individual case to see status and date for the patient (click on the marker)"
                        ),
                        tags$br(),tags$br(),
                        tags$div("NOTE: For clusters with large data points (>2000) there may be loading times depending on your computer. 
                                Try hiding all Resolved cases or limit date range for faster loading. "),
                        tags$div(id="cite", 'Github Repo', tags$a(href="http://github.com/b-zhang93/Ontario-Covid-Tracker-Interactive-Map", "Link Here"))
                )

        )
)


# backend functions
server <- (function(input, output) {
    
    # add a color column based on the outcome
    covdata <- mutate(covdata, color = factor(covdata$outcome,
                                              levels = c("Resolved", "Fatal", "Not Resolved"),
                                              labels = c("blue", "black", "red")))
    output$covidmap <- renderLeaflet({
        
        # assigning inputs to variables
        minD <- input$date_slider[1]
        maxD <- input$date_slider[2]
        # conditional inputs
        if (input$show_res == FALSE) {
            res <- "Resolved"
        } else{
            res <- ""
        }
        
        if (input$show_fat == FALSE) {
            fat <- "Fatal"
        } else{
            fat <- ""
        }
        
        if (input$show_ong == FALSE) {
            ong <- "Not Resolved"
        } else{
            ong <- ""
        }

        #subset the data based on inputs
        subdata <- filter(covdata,!(outcome %in% c(res, fat, ong)))
        subdata <- filter(subdata, date >= minD & date <= maxD)
        if (input$phu != "All"){
            subdata <- filter(subdata, health_unit == input$phu)
        }
        
        
        # create custom icons
        icons <- awesomeIcons(
            icon = "cases",
            iconColor = "black",
            library = "ion",
            markerColor = subdata$color
        )
        
        # create our leaflet plot
        subdata %>%
            leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(icon = icons, clusterOptions = markerClusterOptions(),
                              popup = paste("<b>", subdata$health_unit, "</b>", "<br>",
                                            "Status:", subdata$outcome, "| Reported:", subdata$date)) %>%
            addLegend(
                labels = c("Resolved", "Fatal", "Not Resolved"),
                colors = c("blue", "black", "red"),
                position = "bottomright"
            )
        
    })
    
})

shinyApp(ui,server)
