bstats<-read.csv('start_frame.csv',stringsAsFactors=FALSE)
for(year in 2010:2013){
    files<-dir(paste(year,'/tables',sep=''))
    for(i in 1:length(files)){
      df<-read.csv(paste(year,'/tables/',files[i],sep=''),stringsAsFactors=FALSE)
      bstats<-rbind(bstats,df)
    }
}

write.csv(bstats,'bstats.csv',row.names=FALSE)