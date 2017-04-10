library(httr)

for(year in 2010:2013){
    links_df<-read.csv(paste(year,'/links.csv',sep=''),stringsAsFactors=FALSE)
    links<-links_df[,1]
    
    names_df<-read.csv(paste(year,'/names.csv',sep=''),stringsAsFactors=FALSE)
    names<-names_df[,1]
    
    for(i in 1:length(links)){
        request<-GET(links[i])
        page<-content(request,'text')
        file_name<-paste(year,'/stats/',names[i],'.html',sep='')
        write(page,file_name)
    }
}