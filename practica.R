library(tm)

# Texto de prueba
texto = "Text mining identifies facts, relationships and assertions that would otherwise remain buried in the mass of textual big data. Once extracted, this information is converted into a structured form that can be further analyzed, or presented directly using clustered HTML tables, mind maps, charts, etc. Text mining employs a variety of methodologies to process the text, one of the most important of these being Natural Language Processing (NLP). Text Mining is amazing!"

#Limpieza
### Convertir todo a minuscula
nov_text <- tolower(texto)
### Remover palabras vacias en ingles
nov_text <- removeWords(nov_text, words = stopwords("english"))
### Remover palabras determinadas
nov_text <- removeWords(nov_text, words = c("etc", "one"))
### Eliminar puntuación
nov_text <- removePunctuation(nov_text)
### Remover numeros
nov_text <- removeNumbers(nov_text)
### Eliminar vacios excesivos
nov_text <- stripWhitespace(nov_text)

library(dplyr)
library(tm)
# Texto de prueba
texto = "Text mining identifies facts, relationships and assertions that would otherwise remain buried in the mass of textual big data. Once extracted, this information is converted into a structured form that can be further analyzed, or presented directly using clustered HTML tables, mind maps, charts, etc. Text mining employs a variety of methodologies to process the text, one of the most important of these being Natural Language Processing (NLP). Text Mining is amazing!"
txt_nuevo = texto %>% tolower() %>%
  removeWords(words = stopwords("english")) %>%
  removeWords(words = c("etc", "one")) %>%
  removePunctuation() %>%
  removeNumbers() %>%
  stripWhitespace()

