##Get Phis and Thetas for ARIMA (currently uses top AIC for p and q)
json_file<-get_Phi_Thetas_aic(json_file)

##Forecast

ARIMA_Forecasts<-lapply(horizon,function(x) forecast_arima(json_file[which_series],horizon=x))

##Write forecasts to folder as json

write_forecasts(ARIMA_Forecasts,folder = folder,name=name)
