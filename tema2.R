library(gutenbergr)

books <- gutenberg_download(c(1342 , 2701),meta_fields = "author", mirror = "http://mirrors.xmission.com/gutenberg/")


library(tidytext)
library(dplyr)
words <- books %>% unnest_tokens(word,text) %>% count(author,word,sort=TRUE)

rated_words <- words %>% bind_tf_idf(word,author,n) %>% arrange(desc(tf_idf))

top_words <- rated_words %>% group_by(author) %>% top_n(15,tf_idf) %>% 
  ungroup() %>% arrange(author,desc(tf_idf))

# Generación de gráfico
library(ggplot2)
g1 = top_words %>% mutate(word=reorder(word,tf_idf)) %>% 
  ggplot(aes(word,tf_idf,fill="author")) + 
  geom_col(show.legend = FALSE) +  
  facet_wrap(~author, ncol=2, scales="free") + 
  coord_flip()


