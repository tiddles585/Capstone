LSTM_forecasts <- read.csv("C:/Users/tavin/OneDrive/Desktop/Capstone_git_main/Capstone/R/LSTM_Forecasts/LSTM_forecasts_1428.csv", header=FALSE)

dir()

my_list <- list()

for (i in 1:17) {
  nested_list <- list()
  for (j in 1:1428) {
    temp<-LSTM_forecasts[(i-1)*1428+j,-1]
    temp<-temp[!is.na(temp)]
    forecasts <- list()
    forecasts$forecasts <- temp
    nested_list[[j]] <- forecasts
  }
  my_list[[i]] <- nested_list
}

write_forecasts(my_list,'LSTM_forecast','LSTM_Forecasts')
