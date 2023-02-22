
json_file<-fix_start(json_file)

json_file<-create_timeseries(json_file)

HW_Forecasts<-lapply(horizon,function(x) forecast_hw(json_file[which_series],horizon=x))

write_forecasts(HW_Forecasts,folder = folder,name=name)
