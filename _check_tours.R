library(readr)
library(dplyr)
library(stringr)
library(tidytext)
library(stringi)
normalize_text <- function(x){x |> enc2utf8() |> stringi::stri_trans_general("Latin-ASCII") |> stringr::str_to_lower()}
path <- "c:/Users/matde/Documents/Cours/M2/S2/Donnees_en_entreprise/Data/finess_etablissements.csv"
et <- read_delim(path, delim=';', col_types=cols(.default=col_character()), show_col_types=FALSE)
corpus <- et |>
  transmute(nofinesset, dep = coalesce(na_if(str_to_upper(str_trim(departement)),""), str_sub(nofinesset,1,2)), commune, rs) |>
  filter(!is.na(rs), rs!="") |>
  distinct(nofinesset,.keep_all=TRUE)
commune_tokens <- corpus |>
  filter(!is.na(commune), commune!="") |>
  transmute(commune_clean = commune |> normalize_text() |> str_replace_all("['’-]"," ") |> str_replace_all("[^[:alnum:] ]"," ") |> str_squish()) |>
  unnest_tokens(output=word_norm, input=commune_clean, token='words') |>
  filter(str_detect(word_norm,'[a-z]'), str_length(word_norm)>2) |>
  distinct(word_norm)
cat('has_tours_commune_tokens=', 'tours' %in% commune_tokens$word_norm, '\n')

tokens <- corpus |>
  unnest_tokens(output=word,input=rs,token='words') |>
  mutate(word_norm=normalize_text(word)) |>
  filter(str_detect(word_norm,'[a-z]'),str_length(word_norm)>2)
cat('count_tours_before=', sum(tokens$word_norm=='tours'), '\n')
cat('count_tours_after_global=', sum((tokens |> anti_join(commune_tokens,by='word_norm'))$word_norm=='tours'), '\n')
