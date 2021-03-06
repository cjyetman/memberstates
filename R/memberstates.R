#' Member states of various international organizations.
#'
#' Lists of the member states of various international organizations in various
#' country code formats. Suggest new organizations at
#' https://github.com/cjyetman/memberstates/issues
#'
#' @source http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.htm
#' @source http://www.coe.int/en/web/about-us/our-member-states
#' @source http://www.nato.int/cps/en/natolive/nato_countries.htm
#' @source https://europa.eu/european-union/about-eu/countries_en
#' @format Nested list
#' \describe{
#' \item{first level}{Code for international organization. one of: coe (Council
#' of Europe), eu (European Union), nato (North Atlantic Treaty Organization),
#' oecd (Organisation for Economic Co-operation and Development)}
#' \item{second level}{Country code type. One of: country.name, iso3c, ios2c,
#' iso3n, cowc, cown}
#' }
#' @examples
#'   memberstates$nato$iso3c
#'   memberstates$eu$country.name
#'
#'   # subestting a data frame (using base R)
#'   url <- 'https://raw.githubusercontent.com/datasets/gdp/master/data/gdp.csv'
#'   df <- read.csv(url)
#'   df <- df[df$Year == max(df$Year), ]
#'   df[df$Country.Code %in% memberstates$eu$iso3c, ]
#'
#'   \dontrun{
#'   # subestting a data frame (using dplyr)
#'   library(dplyr)
#'   url <- 'https://raw.githubusercontent.com/datasets/gdp/master/data/gdp.csv'
#'   read.csv(url) %>%
#'     filter(Year == max(Year)) %>%
#'     filter(Country.Code %in% memberstates$eu$iso3c)
#'   }
"memberstates"
