library(lubridate)
library(ggplot2)
library(dplyr)
library(jpeg)
library(grid)

bstats<-read.csv('bstats.csv',stringsAsFactors = FALSE)

Seasons<- c('','2010-2011','2011-2012','2012-2013','2013-2014')

Statistic<- c('','Points','Rebounds','Assists','Minutes')

S1<-c(" ","COHEN-Iddo","DUPITON-Olivier","ELLINGTON-Keith","JACKSON-Shelton","LEAO-Luis","McLAIN-Pat","OUEGNIN-Jonathan","PENN-Joe","RATNER-Heiden","RICKARD-Andrew","SNOW-Jason","TURNER-Jamal","WEAVER-Bill")
S2<-c(" ","BILBO-Paul","COLEMAN-Steven","DAILEY-Callon","ELLINGTON-Keith","HEINE-Christian","INGRAM-Terrence","LEAO-Luis","LEE-Matt","LIBAZS-Arnis","OUEGNIN-Jonathan","RICKARD-Andrew","TURNER-Jamal","WEAVER-Bill")
S3<-c(" ","BEINS-Sean","BILBO-Paul","DAILEY-Callon","ELLINGTON-Keith","HOYING-Andy","INGRAM-Terrence","LEAO-Luis","ONANA-Jean","OUEGNIN-Jonathan","SAMUELSON-Beau")
S4<-c(" ","BEINS-Sean","BILBO-Paul","DAILEY-Callon","EWING-James","HALE-H'ian","HOYING-Andy","INGRAM-Terrence","LYTLE-Anthony","ONANA-Jean","OUEGNIN-Jonathan","SAMUELSON-Beau","WILLIAMS-Greg")

