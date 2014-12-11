##Loading the libraries
library(shiny)
library(stringr)

#Loading the data
load("oneGram.Rda")
load("twoGram.Rda")
load("threeGram.Rda")
load("fourGram.Rda")


#Cleaning the sentence
cleanWord<-function(appInput)
        {

        appInput <- tolower(appInput)
        appInput <- str_replace_all(appInput, "[^[a-z ]", "")
        appInput <- gsub(" {2,}", " ", appInput)
        return(appInput)

}

bestWord<-function(appInput)
{
        appInput <- tolower(appInput)
        appInput <- str_replace_all(appInput, "[^[a-z ]", "")
        appInput <- gsub(" {2,}", " ", appInput)
        appInput <- unlist(strsplit(appInput, split=" "))
        appInputLength <- length(appInput)
    
        gram1 <- appInput[(appInputLength)]
        nextWords1 <- finaloneGramMod$X2[which(gram1 == finaloneGramMod[, 1])];
        nextWords1 <- head(nextWords1, 1)
        
        if (length(nextWords1 > 0)){
                return(nextWords1)    
        } else { return ("No Match")}
       
}

oneGram<-function(appInput)
{
        appInput <- tolower(appInput)
        appInput <- str_replace_all(appInput, "[^[a-z ]", "")
        appInput <- gsub(" {2,}", " ", appInput)
        appInput <- unlist(strsplit(appInput, split=" "))
        appInputLength <- length(appInput)
        
        gram1 <- appInput[(appInputLength)]
        nextWords1 <- finaloneGramMod$X2[which(gram1 == finaloneGramMod[, 1])];
        nextWords1 <- head(nextWords1, 10)
        
        if (length(nextWords1 > 0)){
                return(nextWords1)    
        } else { return ("No Match")}
        
}


twoGram<-function(appInput)
{
        appInput <- tolower(appInput)
        appInput <- str_replace_all(appInput, "[^[a-z ]", "")
        appInput <- gsub(" {2,}", " ", appInput)
        appInput <- unlist(strsplit(appInput, split=" "))
        appInputLength <- length(appInput)
        
        gram2 <- paste(appInput[(appInputLength-1):appInputLength], collapse=" ");
        nextWords2 <- finaltwoGramMod$X3[which(gram2 == finaltwoGramMod[, 4])];;
        nextWords2 <- head(nextWords2, 10)
        
        if (length(nextWords2 > 0)){
                return(nextWords2)    
        } else { return ("No Match")}
        
}

threeGram<-function(appInput)
{
        appInput <- tolower(appInput)
        appInput <- str_replace_all(appInput, "[^[a-z ]", "")
        appInput <- gsub(" {2,}", " ", appInput)
        appInput <- unlist(strsplit(appInput, split=" "))
        appInputLength <- length(appInput)
        gram3<-"XXX"
        if (appInputLength >= 3){
        gram3 <- paste(appInput[(appInputLength-2):appInputLength], collapse=" ")}
        nextWords3 <- finalthreeGramMod$X4[which(gram3 == finalthreeGramMod[, 5])]
        nextWords3 <- head(nextWords3, 10)
        
        if (length(nextWords3 > 0)){
                return(nextWords3)    
        } else { return ("No Match")}
        
}

fourGram<-function(appInput)
{
        appInput <- tolower(appInput)
        appInput <- str_replace_all(appInput, "[^[a-z ]", "")
        appInput <- gsub(" {2,}", " ", appInput)
        appInput <- unlist(strsplit(appInput, split=" "))
        appInputLength <- length(appInput)
        gram4<-"XXX"
        if (appInputLength >= 4){
        gram4 <- paste(appInput[(appInputLength-3):appInputLength], collapse=" ")}
        nextWords4 <- finalfourGramMod$X5[which(gram4 == finalfourGramMod[, 6])];
        nextWords4 <- head(nextWords4, 10)
        
        if (length(nextWords4 > 0)){
                return(nextWords4)    
        } else { return ("No Match")}
        
}

shinyServer(function(input,output){

        
#         output$value <- renderText({ input$text })

       
        output$value <- renderPrint({cleanWord(input$text)})
        output$best<-renderPrint({bestWord(input$text)})
        output$onegram <- renderPrint({oneGram(input$text)})
        output$twogram <- renderPrint({twoGram(input$text)})
        output$threegram <- renderPrint({threeGram(input$text)})
        output$fourgram <- renderPrint({fourGram(input$text)})
    

}
)