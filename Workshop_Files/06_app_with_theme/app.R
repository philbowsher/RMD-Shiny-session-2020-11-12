#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(qualtRics)
library(ggplot2)
library(shinythemes)

mysurvey <- read_survey("2020 Vista Post-Course Survey.csv") 
numeric_answers<-mysurvey %>% select(!c("Q15", "Q31_1", "Q11", 'Q31_7_TEXT')) %>%
    pivot_longer(names_to = 'Question', values_to = 'Answer', starts_with("Q"))



# Define UI for application that draws a histogram
ui <- fluidPage(theme= shinytheme("superhero"),

    # Application title
    titlePanel("Survey Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("select", label = h3("Select Question"), 
                        choices = unique(numeric_answers$Question), 
                        selected = 1),
            selectInput("instructor", label = h3("Select Instructor"), 
                        choices = unique(numeric_answers$instructor1), 
                        selected = 1),
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Plot <- renderPlot({
        
        numeric_answers %>% 
            filter(Question == input$select, instructor1 == input$instructor) %>% 
            ggplot()+
            geom_bar(aes(x=Answer))+
            ylab('Response Count')+
            xlim(0,5)+
            theme_classic()
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
