# library(shiny)


# Define UI for dataset viewer application

# Define UI for dataset viewer application
u <- shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Reactivity"),
  
  # Sidebar with controls to provide a caption, select a dataset, and 
  # specify the number of observations to view. Note that changes made
  # to the caption in the textInput control are updated in the output
  # area immediately as you type
  sidebarPanel(
    textInput("caption", "Caption:", "Data Summary"),
    
    selectInput("dataset", "Choose a Date:", 
                choices = c("2020-03-29","2020-04-05"))
    
    # numericInput("obs", "Number of observations to view:", 10)
  ),
  
  
  # Show the caption, a summary of the dataset and an HTML table with
  # the requested number of observations
  mainPanel(
    h3(textOutput("caption")), 
    
    verbatimTextOutput("summary"), 
    
    plotOutput("plot")
  )
))



s <- shinyServer(function(input, output) 
{

  # dt <- reactive({
  #   switch(names(input)
  # })

  output$plot <- renderPlot({
    input$dataset
  })
})
shinyApp(u,s)

