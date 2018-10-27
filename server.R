#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly) 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  f <- list(
    family = "Courier New, monospace",
    size = 16,
    color = "#7f7f7f"
  )
  
  
  modelData <- reactive({
   
    eachGenderSamplesNumber <- input$PointsCount / 2
    maleData <- data.frame(x = 1:eachGenderSamplesNumber,
                       salary=runif(eachGenderSamplesNumber, min = input$MaleSalaryRange[[1]], max=input$MaleSalaryRange[[2]]),  
                       gender="male")
    
    femaleData <- data.frame(x = 1:eachGenderSamplesNumber,
                           salary=runif(eachGenderSamplesNumber, min = input$FemaleSalaryRange[[1]], max=input$FemaleSalaryRange[[2]]),  
                           gender="female")
    
     rbind(maleData, femaleData)
    
  })
  
  output$distHist <- renderPlotly({
    
    data <- modelData()
    
    x <- list(
      title = "Salary",
      titlefont = f
    )
    y <- list(
      title = "Frequency",
      titlefont = f
    )
    
  
    plot <- plot_ly(x = data$salary, type = "histogram", color = data$gender) 
    
    if(input$showTitles){
      
      plot %>%
        layout(xaxis = x, yaxis = y)
      
    }else{
      
      plot
    }
    
    
  })
  
   
  output$distBox <- renderPlotly({
    
    x <- list(
      title = "Gender",
      titlefont = f
    )
    y <- list(
      title = "Salary",
      titlefont = f
    )
    
    data <- modelData()
   
    plot <- plot_ly(data, y = ~salary, color = ~gender, type = "box")  
    
    if(input$showTitles){
      
      plot %>%
        layout(xaxis = x, yaxis = y)
      
    }else{
      
      plot
    }
    
  })
  
})
