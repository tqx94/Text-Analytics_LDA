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
"lubridate","reshape2")

# if need to install packages
for (i in 2:length(packages))
{
  install.packages(packages[i])
}
lapply(packages, require, character.only = TRUE)


# Loading data --------------------------------------------------------
report_reason <- "load your data here"

# Cleaning all the tokens for future mapping --------------------------------------------------
# Dictionary for cleaning words
text_cleaning <- report_reason %>% filter(New_tag != "OOS" ) %>% 
  filter(is.na(New_tag) == 0) %>% select(Reasons)
text_cleaning_tokens <- text_cleaning %>% 
  tidytext::unnest_tokens(word, Reasons) 
text_cleaning_tokens$word <- gsub('[[:digit:]]+', '', text_cleaning_tokens$word)
text_cleaning_tokens$word <- gsub('[[:punct:]]+', '', text_cleaning_tokens$word)
text_cleaning_tokens <- text_cleaning_tokens %>% filter(!(nchar(word) == 1))%>% 
  anti_join(stop_words)
text_cleaning_tokens <- text_cleaning_tokens %>% filter(!(word==""))
#count the dirty tokens
text_cleaning_tokens_count <- text_cleaning_tokens %>% count(word)


#map the cleaned ones in
final_dic <- fread("~/text_cleaning_tokens_countV3.csv",header = T)
final_dic <- final_dic %>% group_by(word) %>% distinct(replacement)
cleaned_tokens <- left_join(text_cleaning_tokens, final_dic)
cleaned_tokens <- cleaned_tokens %>% 
  mutate(replacement = ifelse(is.na(replacement)==1, word, replacement))
#count the cleaned tokens
cleaned_tokens_count <- cleaned_tokens %>% count(replacement)
cleaned_tokens <- cleaned_tokens %>% group_by(word) %>% distinct(replacement) %>% ungroup()
#mapped!! :)
saveRDS(cleaned_tokens, "cleaned_tokens.rds")
cleaned_tokens <- readRDS("~/topicmodelling/cleaned_tokens.rds")

