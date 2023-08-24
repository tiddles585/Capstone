library(tswge)
library(zoo)
library(dplyr)
library(tidyverse)
library("readxl")
library(reshape2)
library(directlabels)

df = read_xlsx("C:/Users/User/Desktop/0 Capstone/M3C_monthly.xlsx")

MonSeries = as.data.frame(df)
head(MonSeries)
#view(MonSeries)

MSeriesTrans = data.frame(t(MonSeries[-1])) ### transposing data frame
colnames(MSeriesTrans) = MonSeries[, 1]     ### rename columns

MSTransplusDom = MSeriesTrans[-c(1,2,4,5),] ## keeping domain
colnameMSTransplusDom = colnames(MSTransplusDom) ## renaming columns
DomainMSTransplusDom = MSTransplusDom
DomainMSTransplusDom[1:5, 1:10]

### function for rolling mean
get.rllmn = function(monSrs,n=2){
  if(is.na(monSrs[1])) monSrs[1] = mean(monSrs,na.rm=TRUE)
  monSrs = na.locf(monSrs,na.rm=FALSE)
  if(length(monSrs)<n) return(monSrs)
  c(monSrs[1:(n-1)],rollapply(monSrs,width=n,mean,align="right"))  
}

### function for rolling standard Deviation
get.rllsd = function(monSrs,n=2){
  if(is.na(monSrs[1])) monSrs[1] = mean(monSrs,na.rm=TRUE)
  monSrs = na.locf(monSrs,na.rm=FALSE)
  if(length(monSrs)<n) return(monSrs)
  c(monSrs[1:(n-1)],rollapply(monSrs,width=n,sd,align="right"))  
}

n = 12 ## yearly rolling 

###################################################################################
######  Creating Plot for Micro Series N1407
##################################################################################

### Micro N1407 series
MicroN1407 = as.numeric(c(na.omit(DomainMSTransplusDom[-1,]$N1407)))
nn = c(1:length(MicroN1407))

#Create nested list with nn and MicroN1407
N1407_nn = list(nn=nn,N1407=MicroN1407)
dfN1407_nn = as.data.frame(do.call(cbind,N1407_nn)) ## convert to df
head(dfN1407_nn)

dfN1407_nn$RollingMean = get.rllmn(dfN1407_nn$N1407,n) ## adding rolling mean to df

dfN1407_nn$RollingSd = get.rllsd(dfN1407_nn$N1407,n) ## adding rolling stad dev to df

dfN1407_nn = dfN1407_nn[-c(1:(n-1)), ]
head(dfN1407_nn)

###  creating plot
dfN1407_nn.Melt = melt(dfN1407_nn, id = c('nn'))
str(dfN1407_nn)

P1 = ggplot(dfN1407_nn.Melt, aes(x=nn, y = value, group = variable)) +
  geom_line(aes(color = variable), size = 0.5) +
  geom_point(aes(color = variable), size = 1, shape = 19) +
  scale_color_manual(values=c('steelblue4',"springgreen4",'violetred3'))+
  labs( x = 'Months', y = 'Index') +
  theme(legend.position = 'top', legend.title = element_blank(), 
        legend.key.width = unit(0.4, "cm"), legend.key.height = unit(0.2, "cm")) +
  theme(panel.grid.major.y = element_line(size = 0.1, color = 'lightgrey')) +
  theme(plot.title = element_text(hjust=0.5, size=30, face = 'bold')) +
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  ggtitle("MicroSeries N1407 \nRolling Standard Deviation, Rolling Mean vs Series") + 
  theme(plot.title = element_text(hjust=.5,size=30)) 
 
P1

###################################################################################
######  Creating Plot for Macro Series N2480
##################################################################################

### Micro N2480 series
MacroN2480 = as.numeric(c(na.omit(DomainMSTransplusDom[-1,]$N2480)))
nn = c(1:length(MacroN2480))

#Create nested list with nn and MacroN2506
N2480_nn = list(nn=nn,N2480=MacroN2480)
dfN2480_nn = as.data.frame(do.call(cbind,N2480_nn)) ## convert to df
head(dfN2480_nn)

dfN2480_nn$RollingMean = get.rllmn(dfN2480_nn$N2480,n) ## adding rolling mean to df

dfN2480_nn$RollingSd = get.rllsd(dfN2480_nn$N2480,n) ## adding rolling stad dev to df

dfN2480_nn = dfN2480_nn[-c(1:(n-1)), ]
head(dfN2480_nn)

###  creating plot
dfN2480_nn.Melt = melt(dfN2480_nn, id = c('nn'))
str(dfN2480_nn)

P2 = ggplot(dfN2480_nn.Melt, aes(x=nn, y = value, group = variable)) +
  geom_line(aes(color = variable), size = 0.5) +
  geom_point(aes(color = variable), size = 1, shape = 19) +
  scale_color_manual(values=c('steelblue4',"springgreen4",'violetred3'))+
  labs( x = 'Months', y = 'Index') +
  theme(plot.title = element_text(hjust=0.5, size=30, face = 'bold')) +
  theme(legend.position = 'top', legend.title = element_blank(), 
        legend.key.width = unit(0.4, "cm"), legend.key.height = unit(0.2, "cm")) +
  theme(panel.grid.major.y = element_line(size = 0.1, color = 'lightgrey')) +
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  ggtitle("MacroSeries N2480 \nRolling Standard Deviation, Rolling Mean vs Series") + 
  theme(plot.title = element_text(hjust=.5,size=30)) 

P2

##########################################################################################
################   Realization mean and sd --- Micro
##########################################################################################

slen = 66 ## first 60 values

DMicro = subset(MonSeries, Category == "MICRO")[,c(7:slen)]
DMicroTrans = data.frame(t(DMicro))
dim(DMicroTrans)

DMicroTrans$Rlmean = rowMeans(DMicroTrans) ## adding mean 
DMicroTrans$Rlsd = apply(DMicroTrans[,-dim(DMicroTrans)[2]], 1, sd) ## adding sd

rd = round(runif(10, 1,(dim(DMicroTrans)[1] -2 )),0)
DMicroTransFn = DMicroTrans[,c(rd,(dim(DMicroTrans)[2]-1),(dim(DMicroTrans)[2]))]
head(DMicroTransFn)

DMicroTransFn$nn = c(1:dim(DMicroTrans)[1])

###  creating plot
DMicroTransFn.Melt = melt(DMicroTransFn, id = c('nn'))
str(DMicroTransFn)

P3 = ggplot(DMicroTransFn.Melt, aes(x=nn, y = value, group = variable)) +
  geom_line(aes(color = variable), size = 0.5) +
  geom_point(aes(color = variable), size = 1, shape = 19) +
  scale_color_manual(values=c('lightgrey', 'lightgrey', 'lightgrey', 'lightgrey', 'lightgrey','lightgrey', 'lightgrey', 'lightgrey', 'lightgrey', 'lightgrey',"springgreen4", 'violetred3'))+
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  theme(axis.text.x = element_text(vjust = 0.5, hjust = 0.5, angle = 90, size = 8, face = 'bold')) +
  geom_dl(aes(label = variable, color = variable) , method =c('last.bumpup')) + 
  theme(legend.position = 'none') +
  labs( x = 'Months', y = 'Index', 
        title = "Domain Micro \nRealization Std Dev, Realization Mean vs Domain Series") +
  theme(plot.title = element_text(hjust=0.5, size=30, face = 'bold')) +
  #theme(legend.position = 'top', legend.title = element_blank(), 
        #legend.key.width = unit(0.4, "cm"), legend.key.height = unit(0.2, "cm")) +
  theme(panel.grid.major.y = element_line(size = 0.1, color = 'lightgrey')) 

P3

##########################################################################################
################   Realization mean and sd --- Micro
##########################################################################################

slen = 66 ## first 60 values

DMacro = subset(MonSeries, Category == "MACRO")[,c(7:slen)]
DMacroTrans = data.frame(t(DMacro))
dim(DMacroTrans)

DMacroTrans$Rlmean = rowMeans(DMacroTrans) ## adding mean 
DMacroTrans$Rlsd = apply(DMacroTrans[,-dim(DMacroTrans)[2]], 1, sd) ## adding sd

rd = round(runif(10, 1,(dim(DMacroTrans)[1] -2 )),0)
DMacroTransFn = DMicroTrans[,c(rd,(dim(DMacroTrans)[2]-1),(dim(DMacroTrans)[2]))]
head(DMacroTransFn)

DMacroTransFn$nn = c(1:dim(DMacroTransFn)[1])

###  creating plot
DMacroTransFn.Melt = melt(DMacroTransFn, id = c('nn'))
str(DMicroTransFn)

P4 = ggplot(DMacroTransFn.Melt, aes(x=nn, y = value, group = variable)) +
  geom_line(aes(color = variable), size = 0.5) +
  geom_point(aes(color = variable), size = 1, shape = 19) +
  scale_color_manual(values=c('lightgrey', 'lightgrey', 'lightgrey', 'lightgrey', 'lightgrey','lightgrey', 'lightgrey', 'lightgrey', 'lightgrey', 'lightgrey',"springgreen4", 'violetred3'))+
  theme_clean() + 
  theme(axis.title = element_text(face="bold",size=30),
        axis.text = element_text(face="bold",size=20)) +
  theme(axis.text.x = element_text(vjust = 0.5, hjust = 0.5, angle = 90, size = 8, face = 'bold')) +
  geom_dl(aes(label = variable, color = variable) , method =c('last.bumpup')) + 
  theme(legend.position = 'none') +
  labs( x = 'Months', y = 'Index', 
        title = "Domain Macro \nRealization Std Dev, Realization Mean vs Domain Series") +
  theme(plot.title = element_text(hjust=0.5, size=30, face = 'bold')) +
  #theme(legend.position = 'top', legend.title = element_blank(), 
  #legend.key.width = unit(0.4, "cm"), legend.key.height = unit(0.2, "cm")) +
  theme(panel.grid.major.y = element_line(size = 0.1, color = 'lightgrey')) 

P4




