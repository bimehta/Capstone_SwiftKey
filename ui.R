shinyUI(fluidPage(
        #create title panel
        titlePanel("Next Word Prediction"),
        h4('This webapp enables the user to eneter a string and predict next word that will follow the last word of the string'),
        h4('The prediction is based sample data from the Coursera files. Please allow 45 seconds for the app to load.'),
        h4('The app shows various predictions based on different n-gram models used'),
        helpText(HTML("<a href = \"https://github.com/bimehta/Capstone_SwiftKey/blob/master/README.md\">Detailed Documentation</a>")),
        
        textInput("text", label = h3("Text input"), value = "Enter the string and click the below button..."),
        submitButton('Predict next Word'),
        hr(),
        
        fluidRow(
                column(3, 
                        h4("The cleaned text for which prediction was made"),
                        verbatimTextOutput("value")
                       ),
                column(4, offset = 1,
                       h4("Best Next Single Word Predicted"),
                       verbatimTextOutput("best")
                       )
        ),
        
        
        
        
        h3("Results of Prediction"),
        h4("Based on the data enetered, 1 gram predicted the next word(s) as:"),
        verbatimTextOutput("onegram"),
        h4("Based on the data enetered, 2 gram predicted the next word(s) as:"),
        verbatimTextOutput("twogram"),
        h4("Based on the data enetered, 3 gram predicted the next word(s) as:"),
        verbatimTextOutput("threegram"),
        h4("Based on the data enetered, 4 gram predicted the next word(s) as:"),
        verbatimTextOutput("fourgram")


      
        
        
  
)
)