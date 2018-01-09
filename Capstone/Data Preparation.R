#Load required libraries
library(stringi)
library(tm)
library(RWeka)

#Read data files
twitter <- readLines("en_US.twitter.txt")
news <- readLines("en_US.news.txt")
blogs <- readLines("en_US.blogs.txt")

#Create Sample dataset and Corpus file
twitter_sample <- sample(twitter, length(twitter)*0.005)
news_sample <- sample(news, length(news)*0.005)
blogs_sample <- sample(blogs, length(blogs)*0.005)

alldata_sample <- c(twitter_sample, news_sample, blogs_sample)
corpus_sample <- VCorpus(VectorSource(alldata_sample))

#Clean the sampled data
#Placeholder for potentially removing stopwods at later stage
##corpus_sample <- tm_map(corpus_sample, removeWords, stopwords("en"))
corpus_sample <- tm_map(corpus_sample, removeNumbers)
corpus_sample <- tm_map(corpus_sample, stripWhitespace)
corpus_sample <- tm_map(corpus_sample, content_transformer(tolower))
corpus_sample <- tm_map(corpus_sample, removePunctuation)
text_corpus <- data.frame(text = unlist(sapply(corpus_sample, `[`, "content")), stringsAsFactors = F)

#Create NGrams
unigrams <- NGramTokenizer(text_corpus, Weka_control(min=1, max=1))
bigrams <- NGramTokenizer(text_corpus, Weka_control(min=2, max=2))
trigrams <- NGramTokenizer(text_corpus, Weka_control(min=3, max=3))
quadgrams <- NGramTokenizer(text_corpus, Weka_control(min=4, max=4))

unigrams_table <- data.frame(table(unigrams))
bigrams_table <- data.frame(table(bigrams))
trigrams_table <- data.frame(table(trigrams))
quadgrams_table <- data.frame(table(quadgrams))

#Sort the NGrams
unigrams_table_sorted <- unigrams_table[order(unigrams_table$Freq, decreasing = T),]
bigrams_table_sorted <- bigrams_table[order(bigrams_table$Freq, decreasing = T),]
trigrams_table_sorted <- trigrams_table[order(trigrams_table$Freq, decreasing = T),]
quadgrams_table_sorted <- quadgrams_table[order(quadgrams_table$Freq, decreasing = T),]

#Save the sorted NGrams into files
quadgrams_table_sorted_split <- strsplit(as.character(quadgrams_table_sorted$quadgrams), split = " ")
quadgrams_final <- data.frame(do.call(rbind, quadgrams_table_sorted_split), quadgrams_table_sorted$Freq, stringsAsFactors = F)
colnames(quadgrams_final) <- c("X1", "X2", "X3", "X4", "Freq")
head(quadgrams_final)
saveRDS(quadgrams_final,"./Capstone/CourseraDataScienceCapstone/quadgrams.RData")

trigrams_table_sorted_split <- strsplit(as.character(trigrams_table_sorted$trigrams), split = " ")
trigrams_final <- data.frame(do.call(rbind, trigrams_table_sorted_split), trigrams_table_sorted$Freq, stringsAsFactors = F)
colnames(trigrams_final) <- c("X1", "X2", "X3", "Freq")
head(trigrams_final)
saveRDS(trigrams_final,"./Capstone/CourseraDataScienceCapstone/trigrams.RData")

bigrams_table_sorted_split <- strsplit(as.character(bigrams_table_sorted$bigrams), split = " ")
bigrams_final <- data.frame(do.call(rbind, bigrams_table_sorted_split), bigrams_table_sorted$Freq, stringsAsFactors = F)
colnames(bigrams_final) <- c("X1", "X2", "Freq")
head(bigrams_final)
saveRDS(bigrams_final,"./Capstone/CourseraDataScienceCapstone/bigrams.RData")
