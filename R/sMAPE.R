my_forecasts<-read_forecasts(folder = folder,name = name)


my_sMAPES<-sMAPE_calculate(json_file,my_forecasts)

##

my_forecasts[[15]]
