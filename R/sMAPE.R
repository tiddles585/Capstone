folder='CES_Forecasts'
name='CES_forecast_1428'

name='DeepAR_forecast'
folder = 'DeepAR_Forecasts'
my_forecasts<-read_forecasts(folder = folder,name = name)


my_sMAPES<-sMAPE_calculate(json_file,my_forecasts)

##

my_forecasts[[15]]
my_forecasts
