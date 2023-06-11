
json_file<-fix_start(json_file)

ts_HW<-create_timeseries(json_file)


                                         ##function(json_file, horizon=0,add_mult='additive',exponential=FALSE)
HW_Forecasts<-lapply(horizon,function(x) forecast_hw(ts_HW[which_series],horizon=x)) # "which_series" & "horizon" are globals in Main.R

#write_forecasts(HW_Forecasts,folder = folder,name=name)


