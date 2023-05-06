my_forecasts<-read_forecasts(folder = folder,name = name)
#forecast_object=my_forecasts
##sMAPE source
my_sMAPES<-sMAPE_calculate(json_file,my_forecasts)

##
