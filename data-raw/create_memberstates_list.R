library(xml2)
library(rvest)
library(countrycode)

memberstates_name <- list()

# OECD
dataurl <- 'http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.htm'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(xmldoc, css = 'td+ td a'), trim = T)
memberstates_name$oecd <- countrycode(members, 'country.name', 'country.name')

# Council of Europe
dataurl <- 'http://www.coe.int/en/web/about-us/our-member-states'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(xmldoc, ".portlet-column-content:contains('Member States') a:first-of-type"), trim = T)
memberstates_name$coe <- countrycode(members, 'country.name', 'country.name')

# NATO
dataurl <- 'http://www.nato.int/cps/en/natolive/nato_countries.htm'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(xmldoc, '#countries ul li:first-child'), trim = T)
memberstates_name$nato <- countrycode(members, 'country.name', 'country.name')

# European Union
dataurl <- 'https://europa.eu/european-union/about-eu/countries_en'
xmldoc <- read_html(dataurl)
members <- html_text(html_nodes(xmldoc, '#sub-section-1 a'), trim = T)
memberstates_name$eu <- countrycode(members, 'country.name', 'country.name')

# make memberstates list
codesToInclude <- c('country.name', 'iso3c', 'iso3n', 'iso2c', 'cowc', 'cown')
memberstates <-
  lapply(memberstates_name, function(x) {
    `names<-`(lapply(codesToInclude, function(y) assign(y, countrycode(x, 'country.name', y))), codesToInclude)
  })

# save list to data
save(memberstates, file = "data/memberstates.rda", compress = "bzip2")
