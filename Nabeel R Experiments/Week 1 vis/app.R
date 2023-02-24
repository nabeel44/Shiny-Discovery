# Load packages ----
library(shiny)
library(maps)
library(mapproj)

# Load data ----
data <- read_dta("/Users/nabeelqureshi/Downloads/broadband_county_year.dta")
counties <- readRDS("/Users/nabeelqureshi/App-1/census-app/counties.rds")
head(data)
x <- load("/Users/nabeelqureshi/Documents/Discovery/Shiny-Discovery/Data/Trips/c_trips_2008.RData")
xx <- load("/Users/nabeelqureshi/Documents/Discovery/Shiny-Discovery/Data/Trips/c_trips_2009.RData")

# Source helper functions -----
source("/Users/nabeelqureshi/Documents/Discovery/Shiny-Discovery/Nabeel R Experiments/Week 1 vis/helpers.R")

# User interface ----
ui <- fluidPage(
  titlePanel("Broadband Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Visualize broadband by county"),
      
      selectInput("var",
                  label = "choose a year to display",
                  choices = c("2006", "2007", "2008", "2009", "2010", "2011",
                              "2012", "2013", "2014", "2015", "2016", "2017",
                              "2018"),
                  selected = "2006"),
      
      

      # sliderInput("var",
      #             label = "year:",
      #             min = 2006, max = 2018, value = 2006),

      sliderInput("range", 
                  label = "Range of intrest:",
                  min = 0, max = 100, value = c(0,100))
                  ),
      
    mainPanel(
      plotOutput("map")
    )
  )
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var, 
                   "2006" = data[data$year %in% c("2006"),]$broadband,
                   "2007" = data[data$year %in% c("2007"),]$broadband,
                   "2008" = data[data$year %in% c("2008"),]$broadband,
                   "2009" = data[data$year %in% c("2009"),]$broadband,
                   "2010" = data[data$year %in% c("2010"),]$broadband,
                   "2011" = data[data$year %in% c("2011"),]$broadband,
                   "2012" = data[data$year %in% c("2012"),]$broadband,
                   "2013" = data[data$year %in% c("2013"),]$broadband,
                   "2014" = data[data$year %in% c("2014"),]$broadband,
                   "2015" = data[data$year %in% c("2015"),]$broadband,
                   "2016" = data[data$year %in% c("2016"),]$broadband,
                   "2017" = data[data$year %in% c("2017"),]$broadband,
                   "2018" = data[data$year %in% c("2018"),]$broadband)
                   
    
    color <- switch(input$var, 
                    "2006" = "red",
                    "2007" = "orange",
                    "2008" = "darkorange",
                    "2009" = "yellow",
                    "2010" = "lightgreen",
                    "2011" = "green",
                    "2012" = "darkgreen",
                    "2013" = "lightblue",
                    "2014" = "blue",
                    "2015" = "darkblue",
                    "2016" = "purple",
                    "2017" = "darkviolet",
                    "2018" = "pink",
                    )
    
    legend <- switch(input$var, 
                     "% of county with broadband")
    
    percent_map(data, color, legend, input$range[1], input$range[2])
  })
}

# Run app ----
shinyApp(ui, server)
