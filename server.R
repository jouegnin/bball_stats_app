shinyServer(function(input,output){
  
  players<-eventReactive(input$Season,{
    
    Season_chosen<-input$Season
    
    if(Season_chosen=='2010-2011')
    {
      selectInput('PlayerDropdown','',choices=S1,selected=1)
    }
    else if(Season_chosen=='2011-2012')
    {
      selectInput('PlayerDropdown','',choices=S2,selected=1) 
    }
    else if(Season_chosen=='2012-2013')
    {
      selectInput('PlayerDropdown','',choices=S3,selected=1)   
    }
    else if(Season_chosen=='2013-2014')
    {
      selectInput('PlayerDropdown','',choices=S4,selected=1)  
    }
  })

  statsGraph<-eventReactive(input$Statistic,{

  
    Season_chosen<-input$Season
    player_chosen<-input$PlayerDropdown
    Statistic_chosen<-input$Statistic

    player_viz<-bstats%>%
    filter(Season_chosen==Season)%>%
    filter(player_chosen==player)%>%
    arrange(Rdate)
  
    player_viz$Opponent<-factor(player_viz$Opponent,levels=player_viz$Opponent[order(player_viz$Rdate)])
  
    if(Statistic_chosen=='Points'){
      ggplot(player_viz,aes(x=Rdate,y=pts))+
        geom_bar(stat='identity',color='red',fill='white',width=1)+
        geom_text(aes(label=pts),vjust=1.5,colour='black')+
        ggtitle("POINTS")+
        theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1.02,color='black',size=12),
              axis.ticks.y=element_blank(),
              axis.text.y=element_blank(),
              plot.title = element_text(lineheight=.8, face="bold",vjust=1.5),
              plot.margin = unit(c(0.3,0,.1,2.7),"cm"))+
        labs(x="", y='')+
        scale_x_discrete(labels=player_viz$Opponent)+
        scale_y_continuous(expand=c(0,0),limits=c(0,max(player_viz$pts)*1.05))
    }
    else if(Statistic_chosen=='Rebounds'){
      ggplot(player_viz,aes(x=Rdate,y=tot))+
        geom_bar(stat='identity',color='black',fill='red',width=1,alpha=0.75)+
        geom_text(aes(label=tot),vjust=1.5,colour='white')+
        ggtitle("REBOUNDS")+
        theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1.02,color='black',size=12),
              axis.ticks.y=element_blank(),
              axis.text.y=element_blank(),
              plot.title = element_text(lineheight=.8, face="bold",vjust=1.5),
              plot.margin = unit(c(0.3,0,.1,2.7),"cm"))+
        labs(x="", y='')+
        scale_x_discrete(labels=player_viz$Opponent)+
        scale_y_continuous(expand=c(0,0),limits=c(0,max(player_viz$tot)*1.05))
    }
    else if(Statistic_chosen=='Assists'){
      ggplot(player_viz,aes(x=Rdate,y=ast))+
        geom_bar(stat='identity',color='red',fill='green',width=1,alpha=0.50)+
        geom_text(aes(label=ast),vjust=1.5,colour='black')+
        ggtitle("ASSISTS")+
        theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1.02,color='black',size=12),
               axis.ticks.y=element_blank(),
               axis.text.y=element_blank(),
               plot.title = element_text(lineheight=.8, face="bold",vjust=1.5),
               plot.margin = unit(c(0.3,0,.1,2.7),"cm"))+
        labs(x="", y='')+
        scale_x_discrete(labels=player_viz$Opponent)+
        scale_y_continuous(expand=c(0,0),limits=c(0,max(player_viz$ast)*1.05))
    }
    else if(Statistic_chosen=='Minutes'){
      ggplot(player_viz,aes(x=Rdate,y=min,group=1))+
        geom_path(stat='identity',color='red',size=3)+
        geom_text(aes(label=min),colour='black',size=7.5)+
        ggtitle("MINUTES")+
        theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1.02,color='black',size=12),
              axis.ticks.y=element_blank(),
              axis.text.y=element_blank(),
              plot.title = element_text(lineheight=.8, face="bold",vjust=1.5),
              plot.margin = unit(c(0.3,0,.1,2.7),"cm"))+
        labs(x="", y='')+
        scale_x_discrete(labels=player_viz$Opponent)+
        scale_y_continuous(expand=c(0,0),limits = c(0,max(player_viz$min)*1.05))  
    }
  })

  output$PlayerSelector<-renderUI({
    players()
  })  
  
  output$plot_stats<-renderPlot({
    validate(
      need(input$Season != '','Select a season year.'),
      need(input$Statistic != '','Select Player and Statistic you wish to display.')
    )
    statsGraph()  
  })
  
  
})
