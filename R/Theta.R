json_file<-fix_start(json_file)

ts_Theta<-create_monthly_timeseries(json_file)


##function(json_file, horizon=0,add_mult='additive',exponential=FALSE)
Theta_Forecasts<-lapply(horizon,function(x) forecast_theta(ts_Theta[which_series],horizon=x)) # "which_series" & "horizon" are globals in Main.R

write_forecasts(Theta_Forecasts,folder = folder,name=name)


