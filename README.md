Capstone_SwiftKey

Please wait at least 60 seconds for the app to load if loading for first time
=================

This app basically takes a sentence from the user and predicts the next word.
To create this app I have used 10% sample data from the files shared in the Coursera assignment
For these files I read them into a Corpus and did some basic cleaning.
The details are available here:
http://rpubs.com/bimehta/capstone1
After that I created TDM using different ngrams.
Uisng those ngrams I seperated the last word from the ngram.
Whatever text the user enters, based on the size of the text it is compared to the respective ngram and the word(s) that occur most frequently are shown in the output in decreasing order of their popularity.
The app shows output for all n-grams from one to four and also shows the most popular word among the different outputs.
The code is available in the repository

Thanks for reviewing.

