# Packages needed ---------------------------------------------------------
packages <- c("dplyr",
"magrittr",
"data.table",
"tidytext",
"topicmodels",
"colorspace",
"purrr",
"ldatuning",
"gmp",
"wordcloud",
"RColorBrewer",
"ggplot2",
"lubridate","reshape2","textmineR")

# if need to install packages
for (i in 2:length(packages))
{
  install.packages(packages[i])
}
lapply(packages, require, character.only = TRUE)


# Loading data --------------------------------------------------------
#https://www.kaggle.com/crowdflower/first-gop-debate-twitter-sentiment
data <- fread("~/Documents/Projects/TextAnalytics_LDA/Sentiment.csv")
#loonking at top 5000 rows
data <- data %>% select(text,id) %>% head(5000)

#text cleaning
data$text <- sub("RT.*:", "", data$text)
data$text <- sub("@.* ", "", data$text)
text_cleaning_tokens <- data %>% 
  tidytext::unnest_tokens(word, text)
text_cleaning_tokens$word <- gsub('[[:digit:]]+', '', text_cleaning_tokens$word)
text_cleaning_tokens$word <- gsub('[[:punct:]]+', '', text_cleaning_tokens$word)
text_cleaning_tokens <- text_cleaning_tokens %>% filter(!(nchar(word) == 1))%>% 
  anti_join(stop_words)
tokens <- text_cleaning_tokens %>% filter(!(word==""))
