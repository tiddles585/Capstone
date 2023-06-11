json_file<-fix_start(json_file)

ts_CES<-create_monthly_timeseries(json_file)


##function(json_file, horizon=0,add_mult='additive',exponential=FALSE)
CES_Forecasts<-lapply(horizon,function(x) forecast_ces(ts_CES[which_series],horizon=x)) # "which_series" & "horizon" are globals in Main.R

write_forecasts(CES_Forecasts,folder = folder,name=name)


