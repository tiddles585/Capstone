
json_file<-fix_start(json_file)

<<<<<<< HEAD
<<<<<<< HEAD
json_file<-create_timeseries(json_file)
=======
=======
>>>>>>> main
ts_HW<-create_timeseries(json_file)


                                        ##function(json_file, horizon=0,add_mult='additive',exponential=FALSE)
HW_Forecasts<-lapply(horizon,function(x) forecast_hw(ts_HW[which_series],horizon=x))

write_forecasts(HW_Forecasts,folder = folder,name=name)


<<<<<<< HEAD
>>>>>>> main
=======
>>>>>>> main
