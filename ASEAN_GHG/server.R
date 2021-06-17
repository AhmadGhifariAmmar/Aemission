library(shiny)
library(ggplot2)
library(dplyr)
library(shinythemes)

GHG <- read.csv("GHG TOTAL.csv", TRUE, ";")
SOURCES <- read.csv("GHG SOURCES.csv", TRUE, ";")

shinyServer(function(input, output) {
    
    output$countryplot <- renderPlot({
        
        SOURCES <- filter(SOURCES, 
                            Country == input$countrya,
                            Source == input$source,
                          Year >= input$yeara[1],
                          Year <= input$yeara[2]
                          )

        ggplot(SOURCES, aes(x= Year, y = Emission, group= Source, fill= Source, color= Source)) +
            geom_area(alpha=0.4 , size=1) + 
            theme_classic() + 
            xlab("Year") +
            ylab("Emissions in mtCO2e") +
            theme(legend.position="bottom") +
            theme(legend.title = element_text(size=15, face="bold")) + 
            theme(legend.text = element_text(size=15)) +
            theme(axis.text=element_text(size=15),
                  axis.title.x = element_text(size=18, face="bold",margin = margin(t = 20, r = 0, b = 0, l = 0)),
                  axis.title.y = element_text(size=18, face="bold",margin = margin(t = 0, r = 20, b = 0, l = 0)))
        
    })
    
    output$compareplot <- renderPlot({
        
        GHG <- filter(GHG, 
                            Country == input$countryb, 
                            Year >= input$yearb[1],
                            Year <= input$yearb[2])
        
        ggplot(GHG, aes(x=Year, y = Emission, group = Country, color= Country)) +
            geom_line(size=1.2) + 
            theme_classic() + 
            xlab("Year") +
            ylab("Emissions in mtCO2e") +
            theme(legend.title = element_text(size=15, face="bold")) + 
            theme(legend.text = element_text(size=15)) +
            theme(axis.text=element_text(size=15),
                  axis.title.x = element_text(size=18, face="bold",margin = margin(t = 20, r = 0, b = 0, l = 0)),
                  axis.title.y = element_text(size=18, face="bold",margin = margin(t = 0, r = 20, b = 0, l = 0)))
        
    })

})
