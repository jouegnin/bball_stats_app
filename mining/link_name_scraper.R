library(xml2)
library(rvest)
library(stringr)

for(year in 10:13){
      symbol<-'_'
      url<-paste('http://www.hurstathletics.com/custompages/MBasketball/20',year,symbol,year+1,'/teamgbg.htm',sep='')
      ppage<-try(read_html(url))
      
      if(class(ppage)[1]=='try-error'){
        symbol<-'-'
        url<-paste('http://www.hurstathletics.com/custompages/MBasketball/20',year,symbol,year+1,'/teamgbg.htm',sep='')
        ppage<-read_html(url)
      }
      
      a<-html_nodes(ppage,'font a')
      a<-a[1:length(a)-1]
      
      links<-html_attr(a,'href')
      base<-paste('http://www.hurstathletics.com/custompages/MBasketball/20',year,symbol,year+1,'/',sep='')
      links<-paste(base,links,sep='')
      write.csv(links,paste('20',year,'/links.csv',sep=''),row.names=FALSE)
      
      names<-html_text(a)
      names<-str_trim(names)
      names<-str_replace(names,', |,','-')
      write.csv(names,paste('20',year,'/names.csv',sep=''),row.names=FALSE)
      
}