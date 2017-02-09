# memberstates

lists of the member states of various international organizations in various country code formats

suggest new organizations at: https://github.com/cjyetman/memberstates/issues

includes:
- Council of Europe (source: http://www.coe.int/en/web/about-us/our-member-states)
- European Union (source: https://europa.eu/european-union/about-eu/countries_en)
- North Atlantic Treaty Organization (source: http://www.nato.int/cps/en/natolive/nato_countries.htm)
- Organisation for Economic Co-operation and Development (source: http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.htm)

also includes regional groupings:
- UN Regional Groups: African Group, Asia-Pacific Group, Eastern European Group, Latin American and Caribbean Group (GRULAC), and Western European and Others Group (WEOG) (source: http://www.un.org/depts/DGACM/RegionalGroups.shtml)
- WB Region: Latin America & Caribbean, South Asia, Sub-Saharan Africa, Europe & Central Asia, Middle East & North Africa, East Asia & Pacific, and North America (source: http://api.worldbank.org/en/countries/?format=json&per_page=2000)
- WB Admin Region: South Asia, Sub-Saharan Africa (excluding high income), Europe & Central Asia (excluding high income), Latin America & Caribbean (excluding high income), East Asia & Pacific (excluding high income), and Middle East & North Africa (excluding high income) (source: http://api.worldbank.org/en/countries/?format=json&per_page=2000)
- WB Income Level: High income, Low income, Upper middle income, and Lower middle income (source: http://api.worldbank.org/en/countries/?format=json&per_page=2000)
- WB Lending Type: Not classified, IDA, IBRD, and Blend (source: http://api.worldbank.org/en/countries/?format=json&per_page=2000)

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
