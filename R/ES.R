
json_file<-fix_start(json_file)

ts_ES<-create_monthly_timeseries(json_file)


                                         ##function(json_file, horizon=0,add_mult='additive',exponential=FALSE)
ES_Forecasts<-lapply(horizon,function(x) forecast_es(ts_ES[which_series],horizon=x)) # "which_series" & "horizon" are globals in Main.R

write_forecasts(ES_Forecasts,folder = folder,name=name)


