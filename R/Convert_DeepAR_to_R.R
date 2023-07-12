DeepAR_forecasts <- read.csv("DeepAR_Forecasts/DeepAR_forecasts.csv", header=FALSE)

dir()

my_list <- list()

for (i in 1:17) {
  nested_list <- list()
  for (j in 1:1428) {
    temp<-DeepAR_forecasts[(i-1)*1428+j,-1]
    temp<-temp[!is.na(temp)]
    forecasts <- list()
    forecasts$forecasts <- temp
    nested_list[[j]] <- forecasts
  }
  my_list[[i]] <- nested_list
}

write_forecasts(my_list,'DeepAR_forecast','DeepAR_Forecasts')

