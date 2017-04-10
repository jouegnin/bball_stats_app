library(xml2)
library(stringr)
library(rvest)

for(year in 2010:2013){        

      names_df<-read.csv(paste(year,'/names.csv',sep=''),stringsAsFactors=FALSE)
      names<-names_df[,1]
       for(i in 1:length(names)){       
              ppage<-read_html(paste(year,'/stats/',names[i],'.html',sep=''))
              
              table<-html_table(ppage,fill=TRUE)[[2]]
              
              
              del_symbol<-function(col){
                  #col<-str_replace_all(col,'Â','')
                  col<-str_replace_all(col,'[^[:ascii:]]','')
                  return(col)
              }
              
              #getting rid of the ugly symbol
              table<-data.frame(lapply(table,del_symbol),stringsAsFactors=FALSE)
              
              #get rid of white space
              table<-data.frame(lapply(table,str_trim),stringsAsFactors=FALSE)
              
              #use row 2 as column names
              colnames(table)<-table[2,]
              
              #slice off end of table
              totals_index<-which(table$Opponent=='Totals')
              table<-table[1:(totals_index-1),]
              
              #slice off top of table
              table<-table[3:dim(table)[1],]
              rownames(table)<-1:dim(table)[1]
              
              #add location column
              table$location<-'home'
              table<-table[,c(1,23,2:22)]
              
              #modify location column
              beginning<-str_extract(table$Opponent,'^\\w+')
              at<-which(beginning=='at')
              vs<-which(beginning=='vs')
              table$location[at]<-'away'
              table$location[vs]<-'neutral'
              
              #modify Opponent column
              table$Opponent<-str_replace(table$Opponent,'^at ','')
              table$Opponent<-str_replace(table$Opponent,'^vs ','')
              table$Opponent<-toupper(table$Opponent)
              
              #adjust col names
              new_col_names<-c("Opponent","location","Date","gs","min","fg","fg_pct","threes","threes_pct","ft","ft_pct","off","def","tot","reb_avg","pf","fo","ast","turn_overs","blk","stl","pts","avg")
              colnames(table)<-new_col_names
              
              #fix fg column
              table$fg_att<-str_replace(table$fg,'^\\d+-','')
              table$fg<-str_replace(table$fg,'-\\d+$','')
              table<-table[,c(1:6,24,7:23)]
              
              #fix threes column
              table$threes_att<-str_replace(table$threes,'^\\d+-','')
              table$threes<-str_replace(table$threes,'-\\d+$','')
              table<-table[,c(1:9,25,10:24)]
              #fix ft column
              table$ft_att<-str_replace(table$ft,'^\\d+-','')
              table$ft<-str_replace(table$ft,'-\\d+$','')
              table<-table[,c(1:12,26,13:25)]
              
              #add name
              table$player<-names[i]
              table<-table[,c(27,1:26)]
              
              #modify gs column
              started<-which(table$gs=='*')
              not_started<-which(table$gs=='')
              table$gs[started]<-'yes'
              table$gs[not_started]<-'no'
              
              #save table
              file_name<-paste(year,'/tables/',names[i],'test.csv',sep='')
              write.csv(table,file_name,row.names=FALSE)
              
       }
}