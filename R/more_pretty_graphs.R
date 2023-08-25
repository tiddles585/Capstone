library(tableHTML)

# Create the data for the table
data <- data.frame(
  ENS = c("Ensemble 1","Ensemble 2 ","Ensemble 3","Ensemble 4"),
  Ensemble = c(
    "Median",
    "Mean",
    "Median",
    "Mean"
  ),
  Composition = c(
    "DeepAR + ARIMA Differenced + CES + Theta",
    "DeepAR + ARIMA Differenced + CES + Theta",
    "DeepAR + ARIMA Differenced + CES + ARIMA Cochrane + ES",
    "DeepAR + ARIMA Differenced + CES + ARIMA Cochrane + ES"
  )
)

# Create the HTML table
tableHTML <- tableHTML(data, header = c("ENS", "Ensemble", "Composition"))
tableHTML



tableHTML(data, header = c("Ensemble Name", "Ensemble Scheme", "Methods Used")) %>%
  add_css_caption(css = list(c('border-collapse', 'border-spacing'), c('separate', '15px'))) %>%
  # add_css_conditional_row(
  #   conditional = "min",
  #   css = list(c("border-top", "border-bottom"), c("1px solid #CD7F32", "1px solid #CD7F32")),
  #   rows = c(1, 2)
  # ) %>%
  add_css_row(css = list(c("font-weight",'text-align'), c("bold",'center')), rows = 1:6) %>%
  add_css_column(css = list("padding-right", "20px"), columns = 1)%>%
  add_css_row(css = list('background-color', '#f2f2f2'),
              rows = odd(2:6))%>%
  add_css_header(css = list( c('height','border-bottom','background-color','color','font-size'), c('10px','5px solid steelblue','steelblue','white','17px')),headers = 1:4)

# Display the HTML table
print(tableHTML)

plotts.sample.wge(json_file[[809]]$target)
#######################

##Plot Realizations
palette<-c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b", "#e377c2", "#7f7f7f",
           "#bcbd22", "#17becf", "#aec7e8", "#ffbb78", "#98df8a", "#ff9896", "#c5b0d5", "#c49c94")

data.frame(target=json_file[[809]]$target)%>%ggplot(aes(x=1:length(target),y=target,col="#9ef8ee"))+geom_line(size=1)+
  #scale_x_date(date_labels="%b %y",date_breaks  ="1 month")+theme_clean()+
  xlab("Months")+ylab("Value")+theme(legend.position = "none",axis.text=element_text(face="bold"),axis.title=element_text(face="bold"))+
  ggtitle("Seasonality")+theme(plot.title=element_text(hjust=.5))+
  theme(plot.subtitle = element_text(hjust = .5))+scale_color_manual(values = "#2ca02c")+
  ggthemes::theme_clean()


