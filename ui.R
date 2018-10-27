#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly) 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Salary discrimination based on Gender"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("PointsCount", "What is the number of points to generate?", min=100, max=500, value=250), 
       sliderInput("MaleSalaryRange", "What is the range of salaries of males?", min=1000, max=10000, value = c(3000,6000)), 
       sliderInput("FemaleSalaryRange", "What is the range of salaries of females?", min=1000, max=10000, value = c(3000,6000)),
       checkboxInput("showTitles", "Show/Hide Titles", value=TRUE )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       
      tabsetPanel(type = "tabs",
                  tabPanel("Home", br(), 
                           
                           h3("Histogram of Random Salaries, compares the salaries of males and females"),
                           plotlyOutput("distHist"),
                           h3("Box graph of Random Salaries, compares the salaries of males and females"),
                           plotlyOutput("distBox"), 
                           h3("Conclusion"),
                           h4("The histogram and box graphs can show the discrimination in salaries based on gender")
                           
                           ),
                  tabPanel("Help", br(),
                           h3("The purpose:"),
                           p("This application generates random salaries for males and females and check if there is descrimination in salary based of gender"),
                           h3("How to use the application:"),
                           tags$ol(
                             tags$li("Use the first slider to choose the number of random salaries to be generated"), 
                             tags$li("Use the second slider to choose the range of salaries for males to be generated"), 
                             tags$li("Use the third slider to choose the range of salaries for females to be generated"),
                             tags$li("Use the checkbox to choose if you want to display the titles or not")
                           )
                 )
                
      
      )
                  
          )
  )
))
