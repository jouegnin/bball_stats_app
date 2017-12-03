shinyUI(fluidPage(
  h1('Mercyhurst Basketball Statistics',align='center'),
  br(),
  br(),
  sidebarLayout(
    sidebarPanel(
      #-------------------------------------------------------------------------------------------
      h4('Select Season:'),
      selectInput('Season','',choices=Seasons,selected=1),
      #-------------------------------------------------------------------------------------------
      h4('Select Player:'),
      uiOutput('PlayerSelector'),
      #-------------------------------------------------------------------------------------------
      h4('Select the statistic you want to visualize:'),
      #uiOutput('StatisticSelector'),
      selectInput('Statistic','',choices=Statistic,selected=1)
      #textOutput('textStats')
          ), # end of sidebarPanel
    mainPanel(
      plotOutput('plot_stats',height =550,width ="85%")
    ) # end of mainPanel  
  ) # end of sibebarLayout      
))

  
