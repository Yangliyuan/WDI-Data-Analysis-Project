library(shiny)
source("global.R")
dashboardPage(
  skin="purple",
  title="World Population Condition and Relationship with Greenhouse Gas Emission",
  header=dashboardHeader(title="Assignment 2"),
  ## Sidebar content
  sidebar=dashboardSidebar(
    sidebarMenu(
      menuItem("Home",        tabName="home_tab",   icon=icon(name="home",       lib="glyphicon")),
      menuItem("Team Introduction", tabName="TeamNo_5", icon=icon(name="menu-right", lib="glyphicon")),
      menuItem("Age Group Comparision", tabName="AG", icon=icon(name="menu-right", lib="glyphicon")),
      menuItem("Urban & Rural Population ", tabName="UR", icon=icon(name="menu-right", lib="glyphicon")),
      menuItem("World CO2 Emission", tabName="CO2", icon=icon(name="menu-right", lib="glyphicon")),
      menuItem("Annual Population Total", tabName="Annual_Population_Total",  icon=icon(name="menu-right", lib="glyphicon"))
    )
  ),
  ## Body content
  body=dashboardBody(
    tabItems(
      # Tab content for "home_tab"
      tabItem(tabName="home_tab",
              fluidRow(
                box(width=10, background="navy", title="Introduction",p("The World Bank Organization was established in 1945, following ratification from the United Nations Monetary and Financial Conference.The organization is comprised of one hundred and eighty nine member countries, 
                                                                        who work together to achieve common goals. These goals include ending poverty by decreasing the percentage of individuals 
                                                                        who live on $1.90 a day to under 3%. Additionally, the World Bank works to promote income growth in the lowest 40% of each country.
                                                                        Typically, developing countries are targeted and provided with assistance and loans in order to improve the infrastructure of the nation. 
                                                                        In order to keep track of their progress and understand the overall health of individual countries, the World Bank collects data from each 
                                                                        country on a variety of subjects. These indicators include, human development, through education and health, agricultural development, 
                                                                        environmental protection, poverty, and governance. The indicators are compiled from numerous international organizations and sources, and 
                                                                        collected into a single database. This data can then be collected and analyzed to draw educated conclusions."))
              ),
              fluidRow( 
                box(width=10, background="navy", title="Objectives"  ,p("The objective is to analyze the relationship between the population levels of a country and their corresponding greenhouse gas emissions. 
We argue that there exists a relationship between these two 
variables, and that they can be affected by the percentage of the population that lives in urban and rural areas, 
the percentage of the population that lies within a particular age group, as well as country classification as 
developed or developing. We hypothesize that there exists a positive linear relationship between 
greenhouse gas emissions and the percentage of the population that lives in urban areas. 
So as the urban population increases, so do the greenhouse gas emissions. 
 Additionally, higher greenhouse gas emissions are expected when the percentage of the population between 15 and 64 is higher. 
Lastly, it is hypothesized that greenhouse gas emissions will be higher in developing countries than in comparison to developed countries."))
      ),
              
              fluidRow(
                box(width=10, background="navy", title="Topics"      ,p("In order to evaluate the hypotheses, four visualizations were created. 
To begin with, a stacked bar plot is used to illustrate differences in the percentage of individuals within age groups. 
Doing so provides insight into how these percentages change over time. 
Additionally, a scatterplot was chosen to track urban and rural population growth, 
and percentage increases in greenhouse gas emissions from the year 1990. 
Two scatterplots are given, one that analyzes high income countries, and another that analyzes low income countries. 
The scatterplots were selected to either prove or disprove that an increase in urban population is correlated to an increase
 in greenhouse gas emissions, as stated in the hypothesis. A global map was also chosen to display the level of C02 emissions across the globe. 
This shows how levels vary among nations as well as time periods. Finally, a graph was created that displays the total population of 
individuals countries. The graph displays how population totals change over a time period selected by the user. 
This can be used to draw a connection between population levels and greenhouse gas levels. 
Each of these four visualizations will offer methods and ways to view the data given and make conclusions in regards to the hypothesis."))
              )),
      
      tabItem(tabName="TeamNo_5",
              fluidRow(
                box(width = 12, background="navy",title="Heather Pyra",p(" I am originally from Tampa, Florida. 
                                                                            I am currently a sophomore at Bentley University majoring in 
                                                                            Actuarial Science and minoring in Business Studies and Finance. 
                                                                            I love listening to country music and going to the beach."))
          ),

fluidRow( column(2),img(src="Heather.png", height = 360, width = 540)),
fluidRow(box(width=12,background="navy",title="Irene(Liyuan) Yang",p("I am from Shanghai, China. I am a graduate student at Bentley University enroll
                                                                      in Business Analytics program. I love data analysis and hope to be a
                                                                      data scientist after graduation.I also interested in travelling and have been to
                                                                     over 10 countries in my life."))),
fluidRow( column(2),img(src="Irene.png", height = 640, width = 480))
           ),
      
      # To do: arrange the input and output items so that make a good 
      # presentation

      #POP
      # Tab content for "first_tab"
      tabItem(tabName="Annual_Population_Total",
              fluidRow(
                box(width=12, background="navy", title="Annual_Population_Total",p("The graph displayed below will allow users to select a 
                                                                                   particular country and a time range. A summary is then shown 
                                                                                   in regards to the total population for the country and time 
                                                                                   range chosen. The data will change if the range is adjusted
                                                                                   or if a different nation is selected. Looking at changes 
                                                                                   in total population can be useful in terms of comparing 
                                                                                   them to changes in total greenhouse gas emissions. 
                                                                                   Not only will this data be able to identify whether
                                                                                   a particular country is increasing in size or decreasing but 
                                                                                   also compare it to changes in greenhouse gas emissions. 
                                                                                   Connections can be investigated as to whether an increase in population
                                                                                   size is correlated with a rise in greenhouse gas emissions, or if it is correlated to a decline in emissions.")),
                column(4,
                selectInput("select", label = h3("Select A Country"), 
                            choices = countries), 
                            selected = "AFG"),
                column(4,
                sliderInput("range", label = h3("Year Range"), min = 1960, 
                            max = 2015, value = c(1960,2015))
                            )),
                fluidRow(
                box(width=12, plotlyOutput("plotly1"))
                ),
                fluidRow(
                tableOutput("summary")
                )
              ),
      #CO2
      tabItem(tabName="CO2",
              fluidRow(
                box(width=12, background="navy", title="World CO2 Emission",p("In order to gain a better understanding of 
  how greenhouse gas emissions vary by country, a world map was created below. The map lists the level of C02 emissions for a 
  particular country during a particular year. The map is able to visually show how C02 levels have changed over time on a global scale. 
 Additionally, on an individual level, countries can be compared with their neighbors or other countries with similar development. 
 If the user has a general understanding of which nations are considered developed or developing then these countries could be analyzed in 
those terms as well. This will help to determine if there exists a relationship between country classification and greenhouse levels, 
                                                                              as stated in the hypothesis, it is argued that developing 
                                                                              nations would tend to have higher levels of greenhouse gas 
                                                                              emissions than their developed counterparts. 
                                                                              This global map will be used to determine
                                                                              the validity of that statement."))
              ),
              fluidRow(
                box(width=12,plotlyOutput("geo"))
              ),
             
              fluidRow(
                column(4,
                sliderInput("year", label=h3("Year"),min=1960,max=2011,value=1960)),
                column(4,tableOutput("summary1"))
              )
              
      ),
      #URBAN VS RURUAL
      tabItem(tabName="UR",
              fluidRow(
                box(width=12, background="navy", title="Rural Urban Comparasion",p("Two scatterplots are 
                                                                                    given side by side to allow for comparisons between 
                                                                                   countries with high levels of income and those with low 
                                                                                   levels of income. Each scatterplot gives the percentage 
                                                                                   increase in the urban population as well as the rural 
                                                                                   population for a given time period and country. 
                                                                                   This is supplemented with the percent change in greenhouse 
                                                                                   gas emissions for that country. However, it is important to
                                                                                   keep in mind that data can only be provided from the year 1990 and onward. 
                                                                                   This is because the year 1990 is considered the base year to calculate the percent 
                                                                                   change in emissions, data was only collected starting from then. These three aspects, 
                                                                                   rural growth, urban growth, and greenhouse gas growth are all given in order to test the
                                                                                   hypothesis that nations with a greater increase in urban growth will also see a greater
                                                                                   increase in greenhouse gas emissions than a country with a slower, or negative growth rate.
                                                                                   Furthermore, by comparing high income and low income nations next to each other, 
                                                                                   users will be able to see if there are different trends are patterns between them. 
                                                                                   Whether one classification experiences higher urban growth rates or if one experiences
                                                                                   higher increases in greenhouse gas emissions."))
              ),
              fluidRow(
                column(6,
                selectInput("selectHi", label = h3("Select A High Income Country"), 
                            choices = highIncome_Country, 
                selected = "ABW")),
              column(6,
                selectInput("selectLo", label = h3("Select A Low Income Country"), 
                          choices = lowIncome_Country, 
                selected = "AFG"))
              ),
              fluidRow(
                box(width=6,plotlyOutput("plotlyRU_high")),
                box(width=6,plotlyOutput("plotlyRU_low"))),
              fluidRow(
                h4("Summary for High-income country"),
                tableOutput("summary3")
              ),
              fluidRow(
                h4("Summary for Low-income country"),
                tableOutput("summary4")
              )
      ),
              
              
    
      #AGE GROUP
      tabItem(tabName="AG",
              fluidRow(
                box(width=12, background="navy", title="Age Group Comparasion",p("A stacked bar graph was created to visually show differences in the makeup 
                                                                                 of age groups for a given country. The graph displays the percentage of 
                                                                                 the population that falls within three possible age groups, 0 to 14 years old, 
                                                                                 15 to 64 years old, and 65 and older. These percentages are shown for a time frame
                                                                                 and country selected by the user. They highlight how overtime these percentages 
                                                                                 adjust for a particular country, and whether or not the percentage of adolescents 
                                                                                 is increasing or decreasing. This data can be correlated to overall population
                                                                                 growth within a country. If there is a noticeable increase in the population of adolescents, 
                                                                                 it is often correlated with higher rates of total population growth. Additionally, 
                                                                                 this information can be compared to levels of greenhouse gas emissions. 
                                                                                 It is argued that if a nation has a higher percentage of individuals of working age than 
                                                                                 they will exhibit higher levels of greenhouse gas emissions. Given the bar graph,
                                                                                 it will be easier to analyze the accuracy of that statement. "))
              ),
              fluidRow(
                column(8,
                       selectInput("selectAGE", label = h3("Select A Country"), 
                                   choices = highIncome_Country, 
                                   selected = "AFG"))
              ),
              fluidRow(
                box(width=12,plotlyOutput("plotlyAGE"))
                ),
              #yly
              fluidRow(
                h4("Summary for Age Group"),
                tableOutput("summaryage")
              )
      )
)     
      ))
    
    
      
  
            

  

  
