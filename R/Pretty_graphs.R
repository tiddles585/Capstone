##THIS SECTION NEEDS WORK, BUT IS ARGUABLY NOT IMPORTANT YET.. MOST OF THE CODE IS JUST SHOTGUN STYLE AT THE MOMENT.

###
library(tidyr)
library(tableHTML)
library(flextable)

all_metrics <- data.frame(Name = character(), Horizon = integer(), Type = character(), Value = numeric())

my_method <- c("CES", "Theta", "ARIMA")
sapply(1:3, function(x) {
  temp <- data.frame(Mean = my_sMAPES[[x]]$Mean, Median = my_sMAPES[[x]]$Median, Horizon = 2:18)
  temp_long <- gather(temp, key = "Type", value = "Value", Mean, Median)
  temp_long$Name <- my_method[x]
  all_metrics <<- rbind(all_metrics, temp_long)
})
tableHTML(all_metrics)
# Display the table
table_html
library(tidyr)
temp<-all_metrics%>%pivot_wider(names_from=Name,values_from=Value)
temp_mean<-temp[temp$Type=='Mean',]
temp_mean<-temp_mean[,-2]
temp_mean<-t(temp_mean)
nem<-c('2','3','4','5',"6",'7','8','9','10','11','12','13','14','15','16','17','18')
nem<-as.character(nem)
temp_mean<-as.data.frame(temp_mean)
temp_mean<-round(temp_mean,digits=2)
names(temp_mean)<-nem
temp_mean<-temp_mean[-1,]
temp_mean$Horizon<-row.names(temp_mean)
temp_mean<-temp_mean[,c(18,1:17)]

####################
####################
temp_mean
min_vals <- apply(temp_mean[,-1], 2, min)




tableHTML(temp_mean,rownames = FALSE,widths = rep(100,18),spacing = '3px',
          border = 2 ,second_headers=list(18,c('Mean sMAPE Values on Horizons 2-18')))%>%
  add_css_conditional_column(conditional = 'min',
                             same_scale=FALSE,
                             css = list('border', '5px solid #CD7F32'),
                             columns =2:(length(temp_mean))) %>%
  add_css_row(css = list(c( 'font-size', 'text-align'), c( '35px', 'center')))%>%
  add_css_row(css = list('background-color', '#f2f2f2'),
              rows = odd(3:5))%>%
  add_css_header(css = list(c('transform', 'height'),
                            c('rotate(-25deg)', '50px')),
                 headers = 2:19)

json_file[[1]]

temp<-all_metrics%>%pivot_wider(names_from=Name,values_from=Value)
temp_mean<-temp[temp$Type=='Median',]
temp_mean<-temp_mean[,-2]
temp_mean<-t(temp_mean)
nem<-c('2','3','4','5',"6",'7','8','9','10','11','12','13','14','15','16','17','18')
nem<-as.character(nem)
temp_mean<-as.data.frame(temp_mean)
temp_mean<-round(temp_mean,digits=2)
names(temp_mean)<-nem
temp_mean<-temp_mean[-1,]
temp_mean$Horizon<-row.names(temp_mean)
temp_mean<-temp_mean[,c(18,1:17)]


tableHTML(temp_mean,widths = rep(100,18),spacing = '3px',second_headers=list(18,c('Median sMAPE Values on Horizons 2-18')),rownames = FALSE)%>%
  add_css_row(css = list(c( 'font-size', 'text-align'), c( '35px', 'center')))%>%
  add_css_conditional_column(conditional = 'min',
                             same_scale=FALSE,
                             css = list('border', '5px solid #CD7F32'),
                             columns =2:(length(temp_mean)))%>%
  add_css_header(css = list(c('transform', 'height'),
                            c('rotate(-25deg)', '50px')),
                 headers = 2:19) %>%
  add_css_row(css = list('background-color', '#f2f2f2'),
              rows = odd(3:5))


###
library(ggplot2)
library(ggthemes)

le_group=interaction(all_metrics$Name,all_metrics$Type)

all_metrics%>% ggplot(aes(x=Horizon,y=Value,group=interaction(Type,Name),color=interaction(Type,Name)))+geom_line(size=1.2)+
  ylab("sMAPE")+theme_clean()+theme(axis.title = element_text(face="bold"),axis.text = element_text(face="bold"))+
  ggtitle("Horizon vs sMAPE")+theme(plot.title = element_text(hjust=.5))+scale_color_manual(name = "Measure and Model",values=palette)

palette<-c("#00CD66", "#CD3278", "#36648B", "#CDAD00", "#CD7F32", "#BA55D3")


json_file[[1]]$series_features$series_length
max(sapply(json_file,function(x) x$series_features$series_length))
