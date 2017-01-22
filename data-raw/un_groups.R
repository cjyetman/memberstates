library(xml2)
library(rvest)
library(dplyr)
library(countrycode)

url <- 'http://www.un.org/depts/DGACM/RegionalGroups.shtml'

html <- xml2::read_html(url)

un <- list()

text <-
  html %>%
  rvest::html_nodes('table:nth-of-type(1) li') %>%
  rvest::html_text()
text <- gsub(pattern = '[[:space:]]+', replacement = ' ', text)
text <- countrycode::countrycode(text, 'country.name', 'country.name')
un <- c(un, setNames(list(text), 'African Group'))

text <-
  html %>%
  rvest::html_nodes('table:nth-of-type(2) li') %>%
  rvest::html_text()
text <- gsub(pattern = '[[:space:]]+', replacement = ' ', text)
text <- countrycode::countrycode(text, 'country.name', 'country.name')
un <- c(un, setNames(list(text), 'Asia-Pacific Group'))

text <-
  html %>%
  rvest::html_nodes('table:nth-of-type(3) li') %>%
  rvest::html_text()
text <- gsub(pattern = '[[:space:]]+', replacement = ' ', text)
text <- countrycode::countrycode(text, 'country.name', 'country.name')
un <- c(un, setNames(list(text), 'Eastern European Group'))

text <-
  html %>%
  rvest::html_nodes('table:nth-of-type(4) li') %>%
  rvest::html_text()
text <- gsub(pattern = '[[:space:]]+', replacement = ' ', text)
text <- countrycode::countrycode(text, 'country.name', 'country.name')
un <- c(un, setNames(list(text), 'Latin American and Caribbean Group (GRULAC)'))

text <-
  html %>%
  rvest::html_nodes('table:nth-of-type(5) li') %>%
  rvest::html_text()
text <- gsub(pattern = '[[:space:]]+', replacement = ' ', text)
text <- countrycode::countrycode(text, 'country.name', 'country.name')
un <- c(un, setNames(list(text), 'Western European and Others Group (WEOG)'))

attr(un, 'source') <- url
attr(un, 'retrieved') <- Sys.time()
