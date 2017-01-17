library(shinydashboard)
library(plotly)
wdi<-read.csv("data/wdi.asst2.csv")
dev<-read.csv("data/High Income country code.csv")
wdi.df<-read.csv("data/wdi.df.csv")
#group 2 types of countries
countries<-unique(wdi.df$country.code)
highIncome_Country<-unique(dev$Country.Code)
lowIncome_Country<-countries[!countries%in% highIncome_Country]
library(tidyr)
library(plotly)
wdi<-subset(wdi,select=-X)#remove rowNum
wdi<-wdi[!(is.na(wdi$value)),]#remove missing value

#wdi %>%                       #spread indicate code into column
#  spread(., indicator.code, value) %>%
#  select(., -indicator.name) %>%
#  {.} -> wdi.df
# write.csv(wdi.df,"data/wdi.df.csv",row.names = FALSE)

l <- list(color = toRGB("white"), width = 0.5)

# specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)



  




