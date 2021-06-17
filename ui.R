library(shiny)
library(ggplot2)
library(dplyr)
library(shinythemes)

GHG <- read.csv("GHG TOTAL.csv", TRUE, ";")
SOURCES <- read.csv("GHG SOURCES.csv", TRUE, ";")

shinyUI(fluidPage(
    navbarPage("Aemission: ASEAN-Emissions",
                tabPanel("Highlight a country", fluidPage(theme = shinytheme("flatly")),
                  headerPanel(h3('Where do GHG emissions in ASEAN countries come from?')),
                  sidebarPanel(
                        selectizeInput("countrya", 
                                       "Select a country to highlight:",
                                       choices = unique(SOURCES$Country),  
                                       selected="Malaysia", 
                                       multiple =FALSE
                                      ),
                        checkboxGroupInput("source", 
                                           "Select emission sources to show:",
                                           choices = c("Agriculture",
                                                        "Energy",
                                                       "Industrial Processes and Product Use",
                                                       "Waste",
                                                       "Other"),
                                           selected = "Agriculture"),
                        sliderInput("yeara", 
                                    "Select year span:", 
                                    min=1850, max=2018, 
                                    value=c(1850, 2018),
                                    sep="")
                                ),
                    mainPanel(
                        plotOutput("countryplot", height=450))
                 
                             
                ),
        
        tabPanel("Compare between countries",
                 headerPanel(h3('Who has the highest GHG emissions between ASEAN countries?')),
                 sidebarPanel(
                     checkboxGroupInput("countryb", "Select countries to compare:",
                                        choices = c("Brunei",
                                                    "Cambodia",
                                                    "Indonesia", 
                                                    "Laos",
                                                    "Malaysia", 
                                                    "Myanmar", 
                                                    "Philippines",
                                                    "Singapore", 
                                                    "Thailand", 
                                                    "Vietnam"),
                                        selected = "Malaysia"),
                     
                     sliderInput("yearb", "Select the year range:", min=1850, max=2018, 
                                 value=c(1850, 2018), sep="")
    
                            ),
                 mainPanel(plotOutput("compareplot",height=450))
                ),
        
        tabPanel("About",
                 headerPanel(h2('About the App')),
                 sidebarPanel(
                   h3('Aemission'),
                   p('Aemission or ASEAN-Emission is an informative application that displays the Greenhouse Gas Emissions of ASEAN countries and its sources from 1850 until 2018.'),
                   br(),
                   h3('Data Source'),
                   p('The data is sourced from the Potsdam Institute of Climate Impact Research. It combines several other published datasets to create a comprehensive set of greenhouse gas emission pathways for every country.'),
                   p('The data could be accessed', a('here',href= 'https://doi.org/10.5281/zenodo.4479172'))
                 ),
                 mainPanel(
                    h3('Frequently Asked Questions'),
                    h4('1. Why is this information important?'),
                    p('This information is important because the world is currently experiencing a climate crisis. To make climate action, we must first be aware and measure our current climate impact. Although the application remains far from the individual, looking at the big picture can help with policy-making and innovation research.'),
                    br(),
                    h4('2. Why focus on the ASEAN region?'),
                    p('The ASEAN region is one of the fastest growing economic region in the world. With such development, there must be an increase in GHG emissions due to an increase in economic activity. So the ASEAN region presents an interesting case study.'),
                    br(),
                    h4('3. What emission sources are covered in the dataset?'),
                    p('The emission sources covered by the dataset (and shown in the application) are agriculture, energy, industrial processes and product use, waste, and others. The dataset excludes emissions from land use, land use changes, and forestry since it can be very fluctuative.'),
                    br(),
                    h4('4. What is included as Greenhouse Gas (GHG) emissions?'),
                    p('The Greenhouse gases that are included in this dataset are based on the ones measured in the Kyoto Protocol, which includes: carbon dioxide (CO2), methane (CH4), nitrous oxide (N2O), hydrofluorocarbons (HFCs), perfluorocarbons (PFCs) and sulphurhexafluoride (SF6). But they are all equated into CO2, that is why the unit displayed is in CO2 equivalent'),
                    br(),
                    h4('5. Why does the data start from 1850?'),
                    p('The change of global temperature is measured/compared to the temperature of the earth before the industrial period. 1850 marks the start of the industrial era and therefore the start of our rapid emissions.'),
                    br(),
                    h4('6. How do we use the application?'),
                    p('The application has two tabs: highlight and compare. In highlight, the tab displays information about the emissions of a specific country and its sources. In compare, you can compare the total emissions of two countries or more. You can pick the emission sources, the country, and year span of the observation.')
                    
                 )
                 
                 )
                 
        )))
