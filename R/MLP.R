forecast_mlp<-function(json_file,h=0){


  ##this just returns forecasts horizon and series features.
  fore_holder<-invisible(lapply(json_file,function(y){
    model_mlp<-(mlp(ts(y$target[1:(length(y$target)-h)]),
                    reps=5,difforder = NULL,allow.det.season = TRUE,sel.lag = TRUE,
                    comb='median'))


    return(list('forecasts'=array(forecast(model_mlp,h=h)$mean)))}
  ))



  return(fore_holder)
}


# Create an empty list with one index
MLP_Forecasts_3 <- list()

# Add 1428 indexes to the list
MLP_Forecasts_3[[1]] <- vector("list", 1428)

# Loop over the 1428 indexes and add a `$forecast` item to each index
for (i in 1:1428) {
  MLP_Forecasts_3[[1]][[i]] <- list(forecast = rep(0, 7))
}

no_689<-json_file[-(689)]
name=paste0('MLP_forecast_test_',7)
time_start=Sys.time()
horizon=7
which_series=1:1427
MLP_Forecasts_3<-lapply(horizon,function(x) forecast_mlp(no_689[which_series],h=x))

time_end=Sys.time()
time_start-time_end

###send text

OutApp <- COMCreate("Outlook.Application")

outMail = OutApp$CreateItem(0)

outMail[["To"]] = '3308532285@txt.att.net'

outMail[["subject"]] = "Done!"

#outMail[["body"]] = ""

outMail$Send()



##
##Write forecasts to folder as json

write_forecasts(MLP_Forecasts_3,folder = folder,name=name)
#}

######################
