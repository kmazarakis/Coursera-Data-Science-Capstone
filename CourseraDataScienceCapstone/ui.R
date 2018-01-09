#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# Define UI for application that draws a histogram
shinyUI(navbarPage("Data Science Capstone",
  tabPanel("Predict Next Word",
    img(src = "./header.png"),
    br(),
    br(),

#Sidebar with a text input 
  sidebarLayout(
      sidebarPanel(
        h2("Predict the next word"),
        br(),
        helpText("Enter the first part of a sentence in order to get a prediction for the next word"),
        #br(),
        textInput("Input",
                   "Type text here:",
                   value = "")
    ),
    
    # Main Panel
    mainPanel(
       h2("Predicted Next Word:"),
       verbatimTextOutput("predictedWord"),
       br(),
       h4("Cleaned Text used for prediction:"),
       helpText("This is the cleaned text input that was used for the next word prediction"),
       verbatimTextOutput("enteredWords"),
       br(),
       img(src = "./NLP.png")
    )
  )
)))
