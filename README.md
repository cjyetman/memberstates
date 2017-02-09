memberstates
Member states of various international organizations.

Code for international organization. one of:
- coe (Council of Europe)
- eu (European Union)
- nato (North Atlantic Treaty Organization)
- oecd (Organisation for Economic Co-operation and Development)

Country code type. One of:
- country.name
- iso3c
- ios2c
- iso3n
- cowc
- cown

source
- http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.htm
- http://www.coe.int/en/web/about-us/our-member-states
- http://www.nato.int/cps/en/natolive/nato_countries.htm
- https://europa.eu/european-union/about-eu/countries_en

usage
description
Lists of the member states of various international organizations in various
country code formats. Suggest new organizations at
https://github.com/cjyetman/memberstates/issues

examples
```r
memberstates$nato$iso3c
```
```r
memberstates$eu$country.name
```

subestting a data frame (using base R)
```r
url <- 'https://raw.githubusercontent.com/datasets/gdp/master/data/gdp.csv'
df <- read.csv(url)
df <- df[df$Year == max(df$Year), ]
df[df$Country.Code \%in\% memberstates$eu$iso3c, ]
```

subestting a data frame (using dplyr)
```r
library(dplyr)
url <- 'https://raw.githubusercontent.com/datasets/gdp/master/data/gdp.csv'
read.csv(url) \%>\%
  filter(Year == max(Year)) \%>\%
  filter(Country.Code \%in\% memberstates$eu$iso3c)
