#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

##Load the required libraries
suppressWarnings(library(stringi))
suppressWarnings(library(tm))
suppressWarnings(library(RWeka))
suppressWarnings(library(shiny))

##Read the training data from Quadgram, trigram and bigram files
bigrams <- readRDS("bigrams.RData")
trigrams <- readRDS("trigrams.RData")
quadgrams <- readRDS("quadgrams.RData")

##Clean user input the same way as cleaning the training data files
datacleaner <- function(Input){
    cleantext <- removeNumbers(Input)
    cleantext <- stripWhitespace(cleantext)
    cleantext <- tolower(cleantext)
    cleantext <- removePunctuation(cleantext)
    
    cleantext
}

cleaninput <- function(Input){
    clean <- datacleaner(Input)
    clean <- strsplit(clean, " ")[[1]]
    clean
}

##Define next word prediction
nextwordprediction <- function(clean){
    if (length(clean) >=3){
        clean <- tail(clean, 3)
    }
    
    else if (length(clean) ==2){
        clean <-c(NA,clean)
    }
    
    else {
        clean <- c(NA,NA,clean)
    }
    
    
    wordPrediction <- as.character(quadgrams[quadgrams$X1==clean[1] & 
                                                       quadgrams$X2==clean[2] & 
                                                       quadgrams$X3==clean[3],][1,]$X4)
    
    if(is.na(wordPrediction)) {
        wordPrediction <- as.character(trigrams[trigrams$X1==clean[2] & 
                                                       trigrams$X2==clean[3],][1,]$X3)
        
        if(is.na(wordPrediction)) {
            wordPrediction <- as.character(bigrams[bigrams$X1==clean[3],][1,]$X2)
        }
    }
    
    
    print(wordPrediction)
    
    
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    wordPrediction <- reactive({
        text <- input$Input
        clean <- cleaninput(text)
        wordPrediction <- nextwordprediction(clean)
    })

    output$predictedWord <- renderPrint(wordPrediction())
    output$enteredWords <- renderText(cleaninput(input$Input), quoted = F)
})
