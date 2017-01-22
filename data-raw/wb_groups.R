library(jsonlite)
library(dplyr)
library(countrycode)

url <- 'http://api.worldbank.org/en/countries/?format=json&per_page=2000'

df <-
  jsonlite::fromJSON(url, flatten = T)[[2]] %>%
  dplyr::filter(region.value != 'Aggregates') %>%  # remove aggregates
  dplyr::filter(name != 'Channel Islands') %>%  # Channel Islands not a recognized state in countrycode
  dplyr::mutate(name = dplyr::if_else(name == 'Virgin Islands (U.S.)', 'US Virgin Islands', name)) %>%
  dplyr::mutate(country.name = countrycode::countrycode(name, 'country.name', 'country.name'))

makeList <- function(df, varname, listname) {
  xlist <- list()
  xnames <- unique(df[[varname]])
  xnames <- xnames[xnames != '']
  for (xname in xnames) {
    xlist <- c(xlist, setNames(list(df[df[[varname]] == xname, 'name']), trimws(xname)))
  }
  setNames(list(xlist), listname)
}

wb <- list()
wb <- c(wb, makeList(df, "region.value", "region"))
wb <- c(wb, makeList(df, "adminregion.value", "adminregion"))
wb <- c(wb, makeList(df, "incomeLevel.value", "incomeLevel"))
wb <- c(wb, makeList(df, "lendingType.value", "lendingType"))

attr(wb, 'source') <- url
attr(wb, 'retrieved') <- Sys.time()
