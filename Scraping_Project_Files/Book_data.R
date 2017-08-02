#All relevant libraries 
library(dplyr)
library(tidyr)
library(ggplot2)
install.packages('tm')
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
install.packages('stringr')
library(stringr)
install.packages('ctv')
library(ctv)
install.views('NaturalLanguageProcessing')
library(xlsx)

#All necessary files
NY_books = read.csv('NYC_booking.csv', sep = ';')
BOS_books = read.csv('BOS_books.csv', sep = ';')
CHI_books = read.csv('CHI_books.csv', sep = ';')
all_books = read.csv('All_books.csv', sep = ';')
Top_books_NYC = NY_books %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,12)
View(Top_books_NYC)

write.xlsx(Top_books_NYC, "mydata.xlsx")
newBOS = BOS_books %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,count = n()) %>% arrange(.,desc(count)) %>% head(.,12)

write.xlsx(newBOS, "Top_books_Boston.xlsx")
newCHI = CHI_books %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,count = n()) %>% arrange(.,desc(count)) %>% head(.,12)
write.xlsx(newCHI, "Top_books_Chicago.xlsx")
Top_titles = books %>% group_by(.,Title) %>% summarise(.,count = n()) %>% arrange(.,desc(count))
Top_authors = books %>% group_by(.,Author) %>% summarise(.,count = n()) %>% arrange(.,desc(count))
Top_authors
###How to make a wordcloud
C = paste(R_train$Description, collapse = ' ')

write.table(C, file = "R_train.txt")
C <- readLines("R_train.txt")
docs = Corpus(VectorSource(C))
inspect(docs)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("jsq",'path',"blonde", "brown","black", "G train", "train", "blond", "hair")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1206)
titles = wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
#####
#Male female  descriptions
Women = all_books %>% filter(str_detect(Description, 'F,'))
dim(Women)
Women_top = Women %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,20)
Men = all_books %>% filter(str_detect(Description, 'M,'))
Men_top = Men %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% filter(.,Author != 'NA') %>% head(.,20)
Men_top
write.xlsx(Women_top, "Women_top_books.xlsx")
write.xlsx(Men_top, "Men_top_books.xlsx")
