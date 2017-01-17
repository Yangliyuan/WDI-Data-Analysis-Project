library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(magrittr)

setwd("~/Desktop/graduate/ma799/project1/WDI_csv-1")
wdi.df = read_csv("WDI_Data.csv")
#First trail (Due to insufficient data so we will have second trail)
wdi.df %>%
  rename(country.code   = `Country Code`,
         country.name   = `Country Name`,
         indicator.name = `Indicator Name`,
         indicator.code = `Indicator Code`) %>%
         {.} -> wdi.df

wdi.df$indicator.code = factor(wdi.df$indicator.code)
wdi.df$indicator.name = factor(wdi.df$indicator.name)

labor <-c("SL.TLF.ACTI.1524.FE.ZS","SL.TLF.ACTI.1524.MA.ZS",
          "SL.TLF.ACTI.1524.ZS","SL.TLF.ACTI.FE.ZS",
          "SL.TLF.ACTI.MA.ZS","SL.TLF.ACTI.ZS","SL.TLF.0714.FE.ZS","SL.TLF.0714.MA.ZS",
          "SL.TLF.0714.ZS","SL.TLF.TOTL.FE.ZS","SL.TLF.TOTL.IN")

le<-c("SL.TLF.PRIM.ZS","SL.TLF.PRIM.FE.ZS","SL.TLF.PRIM.MA.ZS",
      "SL.TLF.SECO.ZS","SL.TLF.SECO.FE.ZS","SL.TLF.SECO.MA.ZS",
      "SL.TLF.TERT.ZS","SL.TLF.TERT.FE.ZS",
      "SL.TLF.TERT.MA.ZS")

um<-c("SL.UEM.LTRM.ZS","SL.UEM.LTRM.FE.ZS",
      "SL.UEM.LTRM.MA.ZS","SL.UEM.PRIM.ZS",
      "SL.UEM.PRIM.FE.ZS","SL.UEM.PRIM.MA.ZS","SL.UEM.SECO.ZS","SL.UEM.SECO.FE.ZS",
      "SL.UEM.SECO.MA.ZS","SL.UEM.TERT.ZS","SL.UEM.TERT.FE.ZS","SL.UEM.TERT.MA.ZS")

wdi.df %>%
  group_by(indicator.code) %>%
  filter(indicator.code %in% labor) %>%
  summarize(count = n(),
            cnt.missing = sum(is.na(value)),
            pct.missing = 100*cnt.missing/count) %>%
  arrange(pct.missing) %>%
  select(indicator.code, pct.missing) %>%
  top_n(10)

wdi.df %>%
  group_by(indicator.code) %>%
  filter(indicator.code %in% le) %>%
  summarize(count = n(),
            cnt.missing = sum(is.na(value)),
            pct.missing = 100*cnt.missing/count) %>%
  arrange(pct.missing) %>%
  select(indicator.code, pct.missing) %>%
  top_n(10)

wdi.df %>%
  group_by(indicator.code) %>%
  filter(indicator.code %in% um) %>%
  summarize(count = n(),
            cnt.missing = sum(is.na(value)),
            pct.missing = 100*cnt.missing/count) %>%
  arrange(pct.missing) %>%
  select(indicator.code, pct.missing) %>%
  top_n(10)
## Selecting by pct.missing

#Second Trial--Data Set Preparation
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(magrittr)
#The variables are then renamed.
wdi.df %>%
  rename(country.code   = `Country Code`,
         country.name   = `Country Name`,
         indicator.name = `Indicator Name`,
         indicator.code = `Indicator Code`) %>%
         {.} -> wdi.df
#The variables indicator code and indicator name are then created into factors.
wdi.df$indicator.code = factor(wdi.df$indicator.code)
wdi.df$indicator.name = factor(wdi.df$indicator.name)
#The gather function is then used to select the variables year and value.This is because these two need to 
#then be converted into factors. The variables country name, country code, 
#indicator name, and indicator code are excluded from this selection.
wdi.df %>%
  gather(., 
         year, value, 
         -country.name, -country.code, -indicator.name, -indicator.code) %>%
         {.} -> wdi.df
wdi.df$year = factor(wdi.df$year, ordered=TRUE)


#Then the indicator codes were evaluated to find the percentage of missing values for each.

wdi.df %>%
  group_by(indicator.code) %>%
  summarize(count = n(),
            cnt.missing = sum(is.na(value)),
            pct.missing = 100*cnt.missing/count) %>%
  arrange(pct.missing) %>%
  select(indicator.code,indicator.code, pct.missing) %>%
  print(10)

#The pop variable is a vector that contains all the indicators related to population that will be 
#evaluated for the hypothesis.
pop<-c("SP.POP.0014.TO.ZS","SP.POP.1564.TO.ZS",
       "SP.POP.65UP.TO.ZS","SP.POP.GROW",
       "SP.POP.TOTL.FE.ZS","SP.POP.TOTL",
       "SP.RUR.TOTL.ZS","SP.RUR.TOTL.ZG",
       "SP.URB.TOTL","SP.URB.TOTL.IN.ZS",
       "SP.URB.GROW")

#These indicators were then evaluated to determine the percentage of missing values.
wdi.df %>%
  group_by(indicator.code) %>%
  filter(indicator.code==pop) %>%
  summarize(count = n(),
            cnt.missing = sum(is.na(value)),
            pct.missing = 100*cnt.missing/count) %>%
  arrange(pct.missing) %>%
  select(indicator.code, pct.missing) %>%
  print(n=11)

#The indicators for Greenhouse gas emissions were chosen next.
gas<-c("EN.ATM.GHGT.ZG","EN.ATM.GHGT.KT.CE","EN.ATM.CO2E.KT"
       
#These indicators are then evaluated to find the percentage of missing values.
wdi.df %>%
         group_by(indicator.code) %>%
         filter(indicator.code==gas) %>%
         summarize(count = n(),
                   cnt.missing = sum(is.na(value)),
                   pct.missing = 100*cnt.missing/count) %>%
         arrange(pct.missing) %>%
         select(indicator.code, pct.missing) %>%
         print(n=10)
       
#Then the countries to be evaluated are selected.
wdi.df %>%
  group_by(country.code) %>%
  summarize(count          = n(),
            cnt.missing    = sum(is.na(value)),
            pct.missing    = 100*cnt.missing/count) %>%
  arrange(pct.missing) %>%
  select(country.code, pct.missing) %>%
  print(n=10)

#The year range is then determined.
wdi.df %>%
  group_by(year) %>%
  summarize(count          = n(),
            cnt.missing    = sum(is.na(value)),
            pct.missing    = 100*cnt.missing/count) %>%
  arrange(year) %>%
  select(year, pct.missing) %>%
  print(n=10)

#From this we are then able to gather the indicator codes from the CSV file.
wdi.df %>%
  filter(indicator.code %in% c("SP.POP.0014.TO.ZS","SP.POP.1564.TO.ZS",
                               "SP.POP.65UP.TO.ZS","SP.POP.GROW",
                               "SP.POP.TOTL.FE.ZS","SP.POP.TOTL",
                               "SP.RUR.TOTL.ZS","SP.RUR.TOTL.ZG",
                               "SP.URB.TOTL","SP.URB.TOTL.IN.ZS",
                               "SP.URB.GROW","EN.ATM.GHGT.ZG","EN.ATM.GHGT.KT.CE",
                               "EN.ATM.CO2E.KT") ) %>%
                               {.} -> wdi.df
#then filter the data frame to select the four countries being evaluated.
wdi.df%>%
  filter(country.code %in% c("RUS","CHN","JPN","USA")) %>%
  {.} -> wdi.df

#The desired time period, from 1970 t0 2012 is then filtered.
wdi.df%>%
  filter(year >1969) %>%
  filter (year <2013) %>%
  {.} -> wdi.df
summary(wdi.df$year) 

#This data frame is then mutated so that factors are created from the indicator code and year variables.
wdi.df %>%
  mutate(indicator.code=factor(indicator.code),
         year          =factor(year)) %>%
         {.} -> wdi.df

#Summaries of these two variables are provided below.
summary(wdi.df$indicator.code)

summary(wdi.df$year)

str(wdi.df)


#Variable Summaries
wdi.df %>%
  select(-indicator.name) %>%
  spread(indicator.code,value) %>%
  {.} -> wdi.df

#The summary for the indicator population ages 0-14 was found first.
wdi.df%>%
  summarize(min=min(SP.POP.0014.TO.ZS,na.rm = TRUE),
            max=max(SP.POP.0014.TO.ZS,na.rm = TRUE),
            mean=mean(SP.POP.0014.TO.ZS,na.rm = TRUE),
            median=median(SP.POP.0014.TO.ZS,na.rm = TRUE))

#Next summaries were conducted for the population ages 15 to 64.
wdi.df%>%
  summarize(min=min(SP.POP.1564.TO.ZS,na.rm = TRUE),
            max=max(SP.POP.1564.TO.ZS,na.rm = TRUE),
            mean=mean(SP.POP.1564.TO.ZS,na.rm = TRUE),
            median=median(SP.POP.1564.TO.ZS,na.rm = TRUE))

#The population over the age of 64 was summarized next.
wdi.df%>%
  summarize(min=min(SP.POP.65UP.TO.ZS,na.rm = TRUE),
            max=max(SP.POP.65UP.TO.ZS,na.rm = TRUE),
            mean=mean(SP.POP.65UP.TO.ZS,na.rm = TRUE),
            median=median(SP.POP.65UP.TO.ZS,na.rm = TRUE))

#The indicator for population growth is summarized below.
wdi.df%>%
  summarize(min=min(SP.POP.GROW,na.rm = TRUE),
            max=max(SP.POP.GROW,na.rm = TRUE),
            mean=mean(SP.POP.GROW,na.rm = TRUE),
            median=median(SP.POP.GROW,na.rm = TRUE))

#Female population growth is summarized next.
wdi.df%>%
  summarize(min=min(SP.POP.TOTL.FE.ZS,na.rm = TRUE),
            max=max(SP.POP.TOTL.FE.ZS,na.rm = TRUE),
            mean=mean(SP.POP.TOTL.FE.ZS,na.rm = TRUE),
            median=median(SP.POP.TOTL.FE.ZS,na.rm = TRUE))

#The total population was determined next.
wdi.df%>%
  summarize(min=min(SP.POP.TOTL,na.rm = TRUE),
            max=max(SP.POP.TOTL,na.rm = TRUE),
            mean=mean(SP.POP.TOTL,na.rm = TRUE),
            median=median(SP.POP.TOTL,na.rm = TRUE))

#The percentage of the population residing in rural areas is summarized.
wdi.df%>%
  summarize(min=min(SP.RUR.TOTL.ZS,na.rm = TRUE),
            max=max(SP.RUR.TOTL.ZS,na.rm = TRUE),
            mean=mean(SP.RUR.TOTL.ZS,na.rm = TRUE),
            median=median(SP.RUR.TOTL.ZS,na.rm = TRUE))

#Then the rural population growth rate is analyzed.
wdi.df%>%
  summarize(min=min(SP.RUR.TOTL.ZG,na.rm = TRUE),
            max=max(SP.RUR.TOTL.ZG,na.rm = TRUE),
            mean=mean(SP.RUR.TOTL.ZG,na.rm = TRUE),
            median=median(SP.RUR.TOTL.ZG,na.rm = TRUE))

#The total urban population is now summarized.
wdi.df%>%
  summarize(min=min(SP.URB.TOTL,na.rm = TRUE),
            max=max(SP.URB.TOTL,na.rm = TRUE),
            mean=mean(SP.URB.TOTL,na.rm = TRUE),
            median=median(SP.URB.TOTL,na.rm = TRUE))

#The percentage of the population that lives in rural areas in calculated next to draw comparisons the the rural population.
wdi.df%>%
  summarize(min=min(SP.URB.TOTL.IN.ZS,na.rm = TRUE),
            max=max(SP.URB.TOTL.IN.ZS,na.rm = TRUE),
            mean=mean(SP.URB.TOTL.IN.ZS,na.rm = TRUE),
            median=median(SP.URB.TOTL.IN.ZS,na.rm = TRUE))

#The urban population growth is also summarized to compare it to the rural population growth.
wdi.df%>%
  summarize(min=min(SP.URB.GROW,na.rm = TRUE),
            max=max(SP.URB.GROW,na.rm = TRUE),
            mean=mean(SP.URB.GROW,na.rm = TRUE),
            median=median(SP.URB.GROW,na.rm = TRUE))

#A summary for the percentage change in total greenhouse gas emissions is provided.
wdi.df%>%
  summarize(min=min(EN.ATM.GHGT.ZG,na.rm = TRUE),
            max=max(EN.ATM.GHGT.ZG,na.rm = TRUE),
            mean=mean(EN.ATM.GHGT.ZG,na.rm = TRUE),
            median=median(EN.ATM.GHGT.ZG,na.rm = TRUE))

#Total greenhouse gas emissions is summarized next.
wdi.df%>%
  summarize(min=min(EN.ATM.GHGT.KT.CE,na.rm = TRUE),
            max=max(EN.ATM.GHGT.KT.CE,na.rm = TRUE),
            mean=mean(EN.ATM.GHGT.KT.CE,na.rm = TRUE),
            median=median(EN.ATM.GHGT.KT.CE,na.rm = TRUE))
#Finally, the total CO2 emissions is evaluated.
wdi.df%>%
  summarize(min=min(EN.ATM.CO2E.KT,na.rm = TRUE),
            max=max(EN.ATM.CO2E.KT,na.rm = TRUE),
            mean=mean(EN.ATM.CO2E.KT,na.rm = TRUE),
            median=median(EN.ATM.CO2E.KT,na.rm = TRUE))

#Summaries for China are listed below.

wdi.df2<-wdi.df
wdi.df%>%
  filter(country.code %in% c("CHN")) %>%
  {.} -> wdi.df2

wdi.df2%>%
  summarize(min=min(SP.POP.GROW,na.rm = TRUE),
            max=max(SP.POP.GROW,na.rm = TRUE),
            mean=mean(SP.POP.GROW,na.rm = TRUE),
            median=median(SP.POP.GROW,na.rm = TRUE))

#The urban growth rate is determined next.
wdi.df2%>%
  summarize(min=min(SP.URB.GROW,na.rm = TRUE),
            max=max(SP.URB.GROW,na.rm = TRUE),
            mean=mean(SP.URB.GROW,na.rm = TRUE),
            median=median(SP.URB.GROW,na.rm = TRUE))

#Finally the percent change in greenhouse gas emissions is determined.
wdi.df2%>%
  summarize(min=min(EN.ATM.GHGT.ZG,na.rm = TRUE),
            max=max(EN.ATM.GHGT.ZG,na.rm = TRUE),
            mean=mean(EN.ATM.GHGT.ZG,na.rm = TRUE),
            median=median(EN.ATM.GHGT.ZG,na.rm = TRUE))

#Russia is then evaluated next, starting with population growth.
wdi.df3<-wdi.df
wdi.df%>%
  filter(country.code %in% c("RUS")) %>%
  {.} -> wdi.df3

wdi.df3%>%
  summarize(min=min(SP.POP.GROW,na.rm = TRUE),
            max=max(SP.POP.GROW,na.rm = TRUE),
            mean=mean(SP.POP.GROW,na.rm = TRUE),
            median=median(SP.POP.GROW,na.rm = TRUE))

#The urban growth rate for Russia is summarized next.
wdi.df3%>%
  summarize(min=min(SP.URB.GROW,na.rm = TRUE),
            max=max(SP.URB.GROW,na.rm = TRUE),
            mean=mean(SP.URB.GROW,na.rm = TRUE),
            median=median(SP.URB.GROW,na.rm = TRUE))

#Lastly, the change in greenhouse gas emissions is determined.
wdi.df3%>%
  summarize(min=min(EN.ATM.GHGT.ZG,na.rm = TRUE),
            max=max(EN.ATM.GHGT.ZG,na.rm = TRUE),
            mean=mean(EN.ATM.GHGT.ZG,na.rm = TRUE),
            median=median(EN.ATM.GHGT.ZG,na.rm = TRUE))

#Summaries for the United States are determined next, beginning with the population growth.
wdi.df4<-wdi.df
wdi.df%>%
  filter(country.code %in% c("USA")) %>%
  {.} -> wdi.df4

wdi.df4%>%
  summarize(min=min(SP.POP.GROW,na.rm = TRUE),
            max=max(SP.POP.GROW,na.rm = TRUE),
            mean=mean(SP.POP.GROW,na.rm = TRUE),
            median=median(SP.POP.GROW,na.rm = TRUE))

#The urban population growth rates is now calculated.
wdi.df4%>%
  summarize(min=min(SP.URB.GROW,na.rm = TRUE),
            max=max(SP.URB.GROW,na.rm = TRUE),
            mean=mean(SP.URB.GROW,na.rm = TRUE),
            median=median(SP.URB.GROW,na.rm = TRUE))

#Urban growth is determined next.
wdi.df5%>%
  summarize(min=min(SP.URB.GROW,na.rm = TRUE),
            max=max(SP.URB.GROW,na.rm = TRUE),
            mean=mean(SP.URB.GROW,na.rm = TRUE),
            median=median(SP.URB.GROW,na.rm = TRUE))

#Lastly, the percentage change is greenhouse gas emissions is summarized.
wdi.df5%>%
  summarize(min=min(EN.ATM.GHGT.ZG,na.rm = TRUE),
            max=max(EN.ATM.GHGT.ZG,na.rm = TRUE),
            mean=mean(EN.ATM.GHGT.ZG,na.rm = TRUE),
            median=median(EN.ATM.GHGT.ZG,na.rm = TRUE))

#Indicator Summaries
#Using the make.ntiles and mutate function, we are able to make quantiles for each of the indicators being 
#evaluated

make.ntiles = function (inputvar, n) { 
  inputvar %>%
    quantile(., 
             (1/n) * 1:(n-1),
             na.rm=TRUE
    ) %>%
    c(-Inf, ., Inf) %>%
    cut(inputvar, 
        breaks=., 
        paste("Q", 1:n, sep="")
    ) 
}

pop.age<-wdi.df
pop.age %>%
  mutate(SP.POP.0014.TO.ZS.factor = make.ntiles(SP.POP.0014.TO.ZS, 4 ),
         SP.POP.1564.TO.ZS.factor = make.ntiles(SP.POP.1564.TO.ZS, 4 ),
         SP.POP.65UP.TO.ZS.factor = make.ntiles(SP.POP.65UP.TO.ZS, 4 ),
         SP.POP.GROW.factor = make.ntiles(SP.POP.GROW, 4))

summary(pop.age)

pop.ge<-wdi.df
pop.ge %>%
  select(SP.POP.TOTL.FE.ZS,SP.POP.TOTL)%>%
  mutate(SP.POP.TOTL.FE.ZS.factor = make.ntiles(SP.POP.TOTL.FE.ZS, 4 ),
         SP.POP.TOTL.factor = make.ntiles(SP.POP.TOTL, 4 ))%>%
         {.} -> pop.ge
summary(pop.ge)
#The indicators to compare the rural and urban populations are mutated and made into quantiles next.
pop.ru<-wdi.df
pop.ru %>%
  select(SP.RUR.TOTL.ZS,SP.RUR.TOTL.ZG,SP.URB.TOTL,SP.URB.TOTL.IN.ZS,SP.URB.GROW)%>%
  mutate(SP.RUR.TOTL.ZS.factor = make.ntiles(SP.RUR.TOTL.ZS, 4 ),
         SP.RUR.TOTL.ZG.factor = make.ntiles(SP.RUR.TOTL.ZG, 4 ),
         SP.URB.TOTL.factor = make.ntiles(SP.URB.TOTL, 4 ),
         SP.URB.TOTL.IN.ZS.factor = make.ntiles(SP.URB.TOTL.IN.ZS, 4 ),
         SP.URB.GROW.factor = make.ntiles(SP.URB.GROW, 4 ))%>%
         {.} -> pop.ru
summary(pop.ru)

#Finally, the quantiles to compare the greenhouse gasses are created.
gas<-wdi.df
gas %>%
  select(EN.ATM.GHGT.ZG,EN.ATM.GHGT.KT.CE,EN.ATM.CO2E.KT)%>%
  mutate( EN.ATM.GHGT.ZG.factor = make.ntiles(EN.ATM.GHGT.ZG, 4 ),
          EN.ATM.GHGT.KT.CE.factor = make.ntiles(EN.ATM.GHGT.KT.CE, 4 ),
          EN.ATM.CO2E.KT.factor = make.ntiles(EN.ATM.CO2E.KT, 4 )) %>%
          {.} -> gas
summary(gas)

#First, the percentage of the population between the ages of 0 and 14 is looked at.
summarise(group_by(wdi.df, country.code),
          min=min(SP.POP.0014.TO.ZS,na.rm = TRUE),
          max=max(SP.POP.0014.TO.ZS,na.rm = TRUE),
          mean=mean(SP.POP.0014.TO.ZS,na.rm = TRUE),
          median=median(SP.POP.0014.TO.ZS,na.rm = TRUE))

#The population growth rate was evaluated next.
summarise(group_by(wdi.df, country.code),
          min=min(SP.POP.GROW,na.rm = TRUE),
          max=max(SP.POP.GROW,na.rm = TRUE),
          mean=mean(SP.POP.GROW,na.rm = TRUE),
          median=median(SP.POP.GROW,na.rm = TRUE))

#The urban growth rate is summarized next for these four countries.
summarise(group_by(wdi.df, country.code),
          min=min(SP.URB.GROW,na.rm = TRUE),
          max=max(SP.URB.GROW,na.rm = TRUE),
          mean=mean(SP.URB.GROW,na.rm = TRUE),
          median=median(SP.URB.GROW,na.rm = TRUE))

#Lastly, the percentage change in greenhouse gas emissions is found.
summarise(group_by(wdi.df, country.code),
          min=min(EN.ATM.GHGT.ZG,na.rm = TRUE),
          max=max(EN.ATM.GHGT.ZG,na.rm = TRUE),
          mean=mean(EN.ATM.GHGT.ZG,na.rm = TRUE),
          median=median(EN.ATM.GHGT.ZG,na.rm = TRUE))