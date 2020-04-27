# Show plotly map based on dates being selected

library(shiny)

# UI
ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  
  sidebarLayout(
    sidebarPanel("Choose a Date (default=newest):",
                 selectInput(inputId = "date", 
                             choices = c("2020-03-29", "2020-04-05"), 
                             selected = "2020-04-05",
                             label = NULL)
    ),
    mainPanel(
      plotlyOutput("coolplot"),
      br(), br(),
      tableOutput("results")
    )
    
  ))

# Server
server <- function(input, output) {
  
  output$coolplot <- renderPlotly({
    maplist[[input$date]] 
  })
}

# run the app
shinyApp(ui = ui, server = server)
