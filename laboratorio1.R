library(gutenbergr)
library(tm)
library(tidytext)
library(dplyr)

books <- gutenberg_download(c(345 , 120 , 16 , 1661),meta_fields = "title", mirror = "http://mirrors.xmission.com/gutenberg/")

words <- books %>% unnest_tokens(word,text) %>% count(title,word,sort=TRUE)

rated_words_cara <- words %>% bind_tf_idf(word,title,n) %>% arrange(desc(tf_idf))
rated_words_frec <- books %>% unnest_tokens(word,text) %>% anti_join(stop_words) %>% count(title,word,sort=TRUE)

top_words_cara <- rated_words_cara %>% group_by(title) %>% top_n(15,tf_idf) %>% ungroup() %>% arrange(title,desc(tf_idf))
top_words_frec <- rated_words_frec %>% group_by(title) %>% top_n(15) %>% ungroup() %>% arrange(title,desc(n))

top_words_frec_1 <- subset(top_words_frec, title == "Peter Pan")
top_words_frec_2 <- subset(top_words_frec, title == "Treasure Island")
top_words_frec_3 <- subset(top_words_frec, title == "The Adventures of Sherlock Holmes")
top_words_frec_4 <- subset(top_words_frec, title == "Dracula")


# nube de palabras
library(wordcloud)

wordcloud_custom <- function(w) 
{
  wordcloud(words = w$word,
            freq = w$n,
            colors =  brewer.pal(8, "Dark2"),
            random.order = F,
            random.color = F,
            scale = c(5 ,0.1),
            rot.per = 0.3)
}

wordcloud_custom(top_words_frec_1)
wordcloud_custom(top_words_frec_2)
wordcloud_custom(top_words_frec_3)
wordcloud_custom(top_words_frec_4)


# Generación de gráfico barras
library(ggplot2)
g1 = top_words_cara %>% mutate(word=reorder(word,tf_idf)) %>% 
  ggplot(aes(word,tf_idf,fill="title")) + 
  geom_col(show.legend = FALSE) +  
  facet_wrap(~title, ncol=2, scales="free") + 
  coord_flip()

