d_values = lapply(json_file, function(x) x[[4]][3])
d_values_counts <- table(unlist(d_values ))
print(d_values_counts)

domain_values = lapply(json_file, function(x) x[[3]][2])
domain_values_counts <- table(unlist(domain_values))
print(domain_values_counts)

########## BELOW IS METHODS sMAPES BY DOMAIN ########## 

library(ggplot2)
library(ggthemes)

name='Theta_forecast_1428'
folder = 'Theta_Forecasts'
Monthly_Domains <- read.csv("C:/Users/dnguy/OneDrive/Desktop/0 Capstone/Capstone/R/Monthly_Domains.csv")

domain_array<-rep(Monthly_Domains$Category,17)
#domain_array<-gsub(" ","",domain_array)
#domain_array<-paste(domain_array,"MLP")


my_forecasts<-read_forecasts(folder = folder,name = name)


my_sMAPES<-sMAPE_calculate(json_file,my_forecasts)

unlist_smapes<-data.frame(unlist(my_sMAPES))

#domain_forecasts
domain_forecasts_ces<-cbind(unlist_smapes,domain_array)

repeats <- c()

for (i in 2:18) {
  repeats <- c(repeats, rep(i, 1428))
}

domain_forecasts_ces$Horizon=repeats

names(domain_forecasts_ces)<-c("sMAPES","Domain","Horizon")
#names(domain_forecasts)
#domain_forecasts<-rbind(domain_forecasts_mlp,domain_forecasts_ces)

mean_data <- domain_forecasts_ces %>%
  group_by(Domain, Horizon) %>%
  summarize(mean_sMAPES = mean(`sMAPES`))

# Plotting the mean MLP sMAPES against the Horizon, separated by Domai

mean_data %>% 
  ggplot(aes(x=Horizon,y=mean_sMAPES,color=Domain)) +
  geom_line(size=1) +
  ylab("sMAPE") +
  theme_clean() +
  theme(axis.title = element_text(face="bold"), 
        axis.text = element_text(face="bold")) +
  ggtitle("Theta sMAPES by Domain") +
  theme(plot.title = element_text(hjust=.5))
#+scale_color_manual(name = "Measure and Model",values=palette)
