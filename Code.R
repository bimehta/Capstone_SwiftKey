options(warn=-1)
suppressMessages(library(tm)) # Framework for text mining.
suppressMessages(library(SnowballC)) # Provides wordStem() for stemming.
suppressMessages(library(qdap)) # Quantitative discourse analysis of transcripts.
suppressMessages(library(qdapDictionaries))
suppressMessages(library(dplyr)) # Data preparation and pipes %>%.
suppressMessages(library(RColorBrewer)) # Generate palette of colours for plots.
suppressMessages(library(ggplot2)) # Plot word frequency
suppressMessages(library(scales)) #Include , in numbers
suppressMessages(library(stringr))#Count lines
suppressMessages(library(RWeka))
library(stringr)

filename <- file.path(".", "corpus", "txt")#Creating path where files are stored
docs<-Corpus(DirSource(filename))

#Sampling Data
docs[[1]]$content <- sample(docs[[1]]$content, 90000, replace = FALSE) #Blog Sample
docs[[2]]$content <- sample(docs[[2]]$content, 8000, replace = FALSE) # News Sample
docs[[3]]$content <- sample(docs[[3]]$content, 240000, replace = FALSE) # Twitter Sample

#Cleaning Data

docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, stripWhitespace)

#Removing Special Characters & additional spaces

docs[[1]]$content <- str_replace_all(docs[[1]]$content, "[^[a-z ]", "")
docs[[1]]$content <- gsub(" {2,}", " ", docs[[1]]$content)

docs[[2]]$content <- str_replace_all(docs[[2]]$content, "[^[a-z ]", "")
docs[[2]]$content <- gsub(" {2,}", " ", docs[[2]]$content)

docs[[3]]$content <- str_replace_all(docs[[3]]$content, "[^[a-z ]", "")
docs[[3]]$content <- gsub(" {2,}", " ", docs[[3]]$content)

#Generating Various n-gram TDM

GTokenizer5 <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))
GTokenizer2 <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
GTokenizer3 <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
GTokenizer4 <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

tdm5 <- TermDocumentMatrix(docs, control = list(tokenize = GTokenizer5))
tdm4 <- TermDocumentMatrix(docs, control = list(tokenize = GTokenizer4))
tdm3 <- TermDocumentMatrix(docs, control = list(tokenize = GTokenizer3))
tdm2 <- TermDocumentMatrix(docs, control = list(tokenize = GTokenizer2))

#Generating Frequency & sorting

freq2 <- rowSums(as.matrix(tdm2))
freq3 <- rowSums(as.matrix(tdm3))
freq4 <- rowSums(as.matrix(tdm4))
freq5 <- rowSums(as.matrix(tdm5))


df2<-data.frame(freq2)
df3<-data.frame(freq3)
df4<-data.frame(freq4)
df5<-data.frame(freq5)


#One Gram
oneGramMod<- data.frame(matrix(unlist(strsplit(rownames(df2), split=" ")), 
                              ncol=2, byrow=TRUE), stringsAsFactors=FALSE);
oneGramMod$freq<-df2$freq2
finaloneGramMod<-oneGramMod[order(-oneGramMod$freq),]

save(finaloneGramMod,file="oneGram.Rda")


#Two Gram
twoGramMod<- data.frame(matrix(unlist(strsplit(rownames(df3), split=" ")), 
                               ncol=3, byrow=TRUE), stringsAsFactors=FALSE);
twoGramMod$String <- paste(twoGramMod$X1, twoGramMod$X2, sep = " ")
twoGramMod$freq<-df3$freq3
finaltwoGramMod<-twoGramMod[order(-twoGramMod$freq),]

save(finaltwoGramMod,file="twoGram.Rda")

#Three Gram
threeGramMod<- data.frame(matrix(unlist(strsplit(rownames(df4), split=" ")), 
                               ncol=4, byrow=TRUE), stringsAsFactors=FALSE);
threeGramMod$String <- paste(threeGramMod$X1, threeGramMod$X2, threeGramMod$X3, sep = " ")
threeGramMod$freq<-df4$freq4
finalthreeGramMod<-threeGramMod[order(-threeGramMod$freq),]

save(finalthreeGramMod,file="threeGram.Rda")

#Four Gram
fourGramMod <- data.frame(matrix(unlist(strsplit(rownames(df5), split=" ")), 
                               ncol=5, byrow=TRUE), stringsAsFactors=FALSE);
fourGramMod$String <- paste(fourGramMod$X1, fourGramMod$X2, fourGramMod$X3, 
                            fourGramMod$X4, sep = " ")
fourGramMod$freq<-df5$freq5
finalfourGramMod<-fourGramMod[order(-fourGramMod$freq),]

save(finalfourGramMod,file="fourGram.Rda")


#Test
load("oneGram.Rda")
load("twoGram.Rda")
load("threeGram.Rda")
load("fourGram.Rda")


nextWords<- as.character(NULL)
appInput <- "COME over righ't"



appInput<-tolower(appInput)
appInput <- str_replace_all(appInput, "[^[a-z ]", "")
appInput <- gsub(" {2,}", " ", appInput)
appInput <- unlist(strsplit(appInput, split=" "))
#appInputLength <- length(appInput)
appInputLength <- 0

if (appInputLength >= 4)
{
        gram4 <- paste(appInput[(appInputLength-3):appInputLength], collapse=" ");
        gram3 <- paste(appInput[(appInputLength-2):appInputLength], collapse=" ");
        gram2 <- paste(appInput[(appInputLength-1):appInputLength], collapse=" ");
        gram1 <- appInput[(appInputLength)];
}        
        
if (appInputLength == 3)
{
        gram4 <- "Not Applicable";
        gram3 <- paste(appInput[(appInputLength-2):appInputLength], collapse=" ");
        gram2 <- paste(appInput[(appInputLength-1):appInputLength], collapse=" ");
        gram1 <- appInput[(appInputLength)];
}     

if (appInputLength == 2)
{
        gram4 <- "Not Applicable";
        gram3 <- "Not Applicable";
        gram2 <- paste(appInput[(appInputLength-1):appInputLength], collapse=" ");
        gram1 <- appInput[(appInputLength)];
}   

if (appInputLength == 1)
{
        gram4 <- "Not Applicable";
        gram3 <- "Not Applicable";
        gram2 <- "Not Applicable";
        gram1 <- appInput[(appInputLength)];
}   

if (gram4 != "Not Applicable")
{
        nextWords4 <- finalfourGramMod$X5[which(appInput == finalfourGramMod[, 6])];
        
        if (length(nextWords4)==0)  # match not found
        {
                nextWords4 <- "No Applicable Match";
                
        }
       
}

if (gram3 != "Not Applicable")
{
        nextWords3 <- finalthreeGramMod$X4[which(appInput == finalthreeGramMod[, 5])];
        
        if (length(nextWords3)==0)  # match not found
        {
                nextWords3 <- "No Applicable Match";
                
        }
        
}

if (gram2 != "Not Applicable")
{
        nextWords2 <- finaltwoGramMod$X3[which(appInput == finaltwoGramMod[, 4])];
        
        if (length(nextWords2)==0)  # match not found
        {
                nextWords2 <- "No Applicable Match";
                
        }
        
}

if (length(gram1) > 0)
{
        nextWords1 <- finaloneGramMod$X2[which(appInput == finaloneGramMod[, 1])];
        nextWords1 <- head(nextWords1, 10)
        
        if (length(nextWords1)==0)  # match not found
        {
                nextWords1 <- "No Applicable Match";
                
        }
        
}


