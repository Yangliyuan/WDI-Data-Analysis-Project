library(shiny)
library(plotly)
#wdi.df<-read.csv("data/wdi.df.csv")
#library(reshape)
source("global.R")
shinyServer(function(input, output) {
#pop total vs co2 total
  output$plotly1 <- renderPlotly({
    wdi.df %>%
    filter(country.code==input$select)%>%
    filter(year %in% c(min(input$range):max(input$range)))%>%
    {.} -> wdi.df1
    plot_ly(wdi.df1) %>%
      add_trace(x = ~year, y = ~SP.POP.TOTL, type = 'bar', name = 'Population',
                marker = list(color = '#C9EFF9'),
                hoverinfo = "text",
                text = ~paste(SP.POP.TOTL, '')) %>%
      add_trace(x = ~year, y = ~EN.ATM.CO2E.KT, type = 'scatter', mode = 'lines', name = 'CO2', yaxis = 'y2',
                line = list(color = '#45171D'),
                hoverinfo = "text",
                text = ~paste(EN.ATM.CO2E.KT, 'KT')) %>%
      layout(title = 'Population,Year,CO2',
             xaxis = list(title = ""),
             yaxis = list(side = 'left', title = 'Population', showgrid = FALSE, zeroline = FALSE),
             yaxis2 = list(side = 'right', overlaying = "y", title = 'CO2', showgrid = FALSE, zeroline = FALSE))
  })
  
  output$summary <- renderTable({
    wdi.df%>%
      filter(country.code==input$select)%>%
      filter(year %in% c(min(input$range):max(input$range)))%>%
      {.}->wdi.df4
      summary1<-summarise(group_by(wdi.df4,country.code),min=min(SP.POP.TOTL,na.rm=TRUE),max=max(SP.POP.TOTL,na.rm=TRUE)
                      ,mean=mean(SP.POP.TOTL,na.rm=TRUE))
      summary1
  })
  #world co2 emission
  output$geo <- renderPlotly({
    wdi.df %>%
      filter(year==input$year)%>%
      {.}->wdi.df2
    plot_geo(wdi.df2) %>%
      add_trace(
        z = ~EN.ATM.CO2E.KT, color = ~EN.ATM.CO2E.KT,colors='YlOrRd',
        text = ~country.name, locations = ~country.code, marker = list(line = l)
      ) %>%
      colorbar(title = 'World CO2 Emission', ticksuffix = ' KT') %>%
      layout(
        title = 'World CO2 Emission',
        geo = g
      )
    
  })
  
  output$summary1 <- renderTable({
    wdi.df%>%
      filter(year==input$year)%>%
      {.}->wdi.df5
    summary2<-summarise(group_by(wdi.df5),min=min(EN.ATM.CO2E.KT,na.rm=TRUE),max=max(EN.ATM.CO2E.KT,na.rm=TRUE)
                        ,mean=mean(EN.ATM.CO2E.KT,na.rm=TRUE))
    summary2
  })

  
  #urban vs rural
 
  output$plotlyRU_high <- renderPlotly ({
    wdi.df %>%
      filter(country.code==input$selectHi)%>%
      {.} -> wdi.dfhi
    plot_ly(wdi.dfhi) %>%
      add_trace(x=~year,y = ~SP.URB.TOTL.IN.ZS, name = 'Urban',type='scatter',mode='line',
                marker = list(color = '#C9EFF9'),
                hoverinfo = "text",
                text = ~paste(SP.URB.TOTL.IN.ZS, '%')) %>%
      add_trace(x=~year,y = ~SP.RUR.TOTL.ZS, name = 'Rural',type='scatter',mode='line',
                line = list(color = '#45171D'),
                hoverinfo = "text",
                text = ~paste(SP.RUR.TOTL.ZS, '%')) %>%
      add_trace(x=~year,y = ~EN.ATM.GHGT.ZG, name = 'CO2%',type='scatter',
                marker = list(color = '#1f421d'),
                hoverinfo = "text",
                text = ~paste(EN.ATM.GHGT.ZG, '%')) %>%
      layout(title = 'Urban&Rural Population Growth(High Income)',
             xaxis = list(title = "Year"),
             yaxis = list(side = 'left', title = 'Percentage', showgrid = FALSE, zeroline = FALSE))
    
    
    
      
  })
  output$plotlyRU_low <- renderPlotly ({
    wdi.df %>%
      filter(country.code==input$selectLo)%>%
      {.} -> wdi.dflo
    plot_ly(wdi.dflo) %>%
      add_trace(x=~year,y = ~SP.URB.TOTL.IN.ZS, name = 'Urban',type='scatter',mode='line',
                marker = list(color = '#C9EFF9'),
                hoverinfo = "text",
                text = ~paste(SP.URB.TOTL.IN.ZS, '%')) %>%
      add_trace(x=~year,y = ~SP.RUR.TOTL.ZS, name = 'Rural',type='scatter',mode='line',
                line = list(color = '#45171D'),
                hoverinfo = "text",
                text = ~paste(SP.RUR.TOTL.ZS, '%')) %>%
      add_trace(x=~year,y = ~EN.ATM.GHGT.ZG, name = 'CO2%',type='scatter',
                marker = list(color = '#1f421d'),
                hoverinfo = "text",
                text = ~paste(EN.ATM.GHGT.ZG, '%')) %>%
      layout(title = 'Urban&Rural Population Growth(Low Income)',
             xaxis = list(title = "Year"),
             yaxis = list(side = 'left', title = 'Percentage', showgrid = FALSE, zeroline = FALSE))
    
    
    
  })
  
  output$summary3 <- renderTable({
    wdi.df%>%
      filter(country.code==input$selectHi)%>%
      {.}->wdi.df6
    summary3<-summarise(wdi.df6,Urban_Min=min(SP.URB.TOTL.IN.ZS,na.rm=TRUE),Urban_Max=max(SP.URB.TOTL.IN.ZS,na.rm=TRUE)
                        ,Urban_Mean=mean(SP.URB.TOTL.IN.ZS,na.rm=TRUE),Rural_Min=min(SP.RUR.TOTL.ZS,na.rm=TRUE),
                        Rural_Max=max(SP.RUR.TOTL.ZS,na.rm=TRUE),Rural_Mean=mean(SP.RUR.TOTL.ZS,na.rm=TRUE),
                        CO2_Min=min(EN.ATM.GHGT.ZG,na.rm=TRUE),CO2_Max=max(EN.ATM.GHGT.ZG,na.rm=TRUE),
                        CO2_Mean=mean(EN.ATM.GHGT.ZG,na.rm=TRUE))
                        summary3
  })
  
  output$summary4 <- renderTable({
    wdi.df%>%
      filter(country.code==input$selectLo)%>%
      {.}->wdi.df7
    summary4<-summarise(wdi.df7,Urban_Min=min(SP.URB.TOTL.IN.ZS,na.rm=TRUE),Urban_Max=max(SP.URB.TOTL.IN.ZS,na.rm=TRUE)
                        ,Urban_Mean=mean(SP.URB.TOTL.IN.ZS,na.rm=TRUE),Rural_Min=min(SP.RUR.TOTL.ZS,na.rm=TRUE),
                        Rural_Max=max(SP.RUR.TOTL.ZS,na.rm=TRUE),Rural_Mean=mean(SP.RUR.TOTL.ZS,na.rm=TRUE),
                        CO2_Min=min(EN.ATM.GHGT.ZG,na.rm=TRUE),CO2_Max=max(EN.ATM.GHGT.ZG,na.rm=TRUE),
                        CO2_Mean=mean(EN.ATM.GHGT.ZG,na.rm=TRUE))
    summary4
  })
  #agegroup
  output$plotlyAGE<-renderPlotly({
    wdi.df %>%
      filter(country.code==input$selectAGE)%>%
      {.}->wdi.dfage
    
    plot_ly(wdi.dfage, x = ~year, y = ~SP.POP.0014.TO.ZS, type = 'bar', name = 'age.0014') %>%
      add_trace(y = ~SP.POP.1564.TO.ZS, name = 'age.1564') %>%
      add_trace(y = ~SP.POP.65UP.TO.ZS, name = 'age.65UP') %>%
      layout(yaxis = list(title = 'Count'), barmode = 'stack')
  })
  #yly+
  output$summaryage<-renderTable({
    wdi.df%>%
      filter(country.code==input$selectAGE)%>%
      {.}->wdi.df8
    summaryage<-summarise(wdi.df8,age0014_Min=min(SP.POP.0014.TO.ZS,na.rm=TRUE),age0014_Max=max(SP.POP.0014.TO.ZS,na.rm=TRUE)
                          ,age0014_Mean=mean(SP.POP.0014.TO.ZS,na.rm=TRUE),age1564_Min=min(SP.POP.1564.TO.ZS,na.rm=TRUE),
                          age1564_Max=max(SP.POP.1564.TO.ZS,na.rm=TRUE),age1564_Mean=mean(SP.POP.1564.TO.ZS,na.rm=TRUE),
                          age65UP_Min=min(SP.POP.65UP.TO.ZS,na.rm=TRUE),age65UP_Max=max(SP.POP.65UP.TO.ZS,na.rm=TRUE),
                          age65UP_Mean=mean(SP.POP.65UP.TO.ZS,na.rm=TRUE))
    summaryage
  })
})

