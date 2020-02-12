library(xml2)
library(rvest)
library(countrycode)

memberstates_name <- list()

# OECD
dataurl <- 'http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.htm'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(html_nodes(xmldoc, css = 'div.country-list__box')[1], css = '.country-list__country'), trim = T)[-1]
oecd <- countrycode(members, 'country.name', 'country.name')
attr(oecd, 'source') <- dataurl
attr(oecd, 'retrieved') <- Sys.time()
memberstates_name <- c(memberstates_name, oecd = list(oecd))

# Council of Europe
dataurl <- 'http://www.coe.int/en/web/about-us/our-member-states'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(xmldoc, ".portlet-column-content:contains('Member States') a:first-of-type"), trim = T)
coe <- countrycode(members, 'country.name', 'country.name')
attr(coe, 'source') <- dataurl
attr(coe, 'retrieved') <- Sys.time()
memberstates_name <- c(memberstates_name, coe = list(coe))

# NATO
dataurl <- 'http://www.nato.int/cps/en/natolive/nato_countries.htm'
xmldoc <- read_html(dataurl)
nodes <- html_nodes(xmldoc, '#countries ul li:first-child')
xml_find_all(nodes, ".//br") %>% xml_add_sibling("p", "\n")
xml_find_all(nodes, ".//br") %>% xml_remove()
members <- sub('\\n.*$', '', html_text(nodes))
nato <- countrycode(members, 'country.name', 'country.name')
attr(nato, 'source') <- dataurl
attr(nato, 'retrieved') <- Sys.time()
memberstates_name <- c(memberstates_name, nato = list(nato))

# European Union
dataurl <- 'https://europa.eu/european-union/about-eu/countries_en'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(xmldoc, '#year-entry2 a'), trim = T)
eu <- countrycode(members, 'country.name', 'country.name')
attr(eu, 'source') <- dataurl
attr(eu, 'retrieved') <- Sys.time()
memberstates_name <- c(memberstates_name, eu = list(eu))

source('data-raw/wb_groups.R')
memberstates_name <- c(memberstates_name, wb = list(wb))

source('data-raw/un_groups.R')
memberstates_name <- c(memberstates_name, un = list(un))

# make memberstates list
codesToInclude <- c('country.name', 'iso3c', 'iso3n', 'iso2c', 'cowc', 'cown')

addcodelists <- function(cntryvect) {
  if (class(cntryvect) == 'list') {
    newlist <- lapply(cntryvect, addcodelists)
    attr(newlist, 'source') <- attr(cntryvect, 'source')
    attr(newlist, 'retrieved') <- attr(cntryvect, 'retrieved')
    return(newlist)
  }
  else {
    newlist <- setNames(lapply(codesToInclude, function(dest) assign(dest, countrycode(cntryvect, 'country.name', dest))), codesToInclude)
    newlist <- lapply(newlist, function(l) { l <- na.omit(l); attributes(l)$na.action <- NULL; l })
    attr(newlist, 'source') <- attr(cntryvect, 'source')
    attr(newlist, 'retrieved') <- attr(cntryvect, 'retrieved')
    return(newlist)
  }
}

memberstates <- lapply(memberstates_name, addcodelists)

# save list to data
save(memberstates, file = "data/memberstates.rda", compress = "bzip2")
