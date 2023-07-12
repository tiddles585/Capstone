#Clears Environment
    #rm(list=ls())
###############
###############
##Global Variables
###############
###############

  #Can be single number or x:y
    horizon=2:18

  ##Mainly for testing, this allows you to only use the first 20 series in the object for simplicity
  ##Presently if you want to use the whole series, you will have to change this to 1:1428
  ##Note: for horizon and which_series, this only affects
    which_series=1:1428

  #####
  ##name of file to save, folder name for model
  ##Folder can be 'ARIMA_Forecasts','HW_Forecasts, or 'MLP_Forecasts' at the moment
  ##Naming convention: <Model>_<Trend_Remover>_<Seasonality_Remover>_forecast<horizons>


    #name='HW_ADDI_forecast_1428'
    name='CES_forecast_1428'
    folder = 'CES_Forecasts'

    #name='ARIMA_CochraneOrc_forecast_1428'
    #folder = 'ARIMA_Forecasts'


###############
###############
##Run your things
###############
###############
##MLP

##LSTM
    ARIMA_Forecasts<-lapply(horizon,function(x) forecast_arima(json_file[which_series],horizon=x))
    source('Functions.R')
    source('Preprocess.R')

start_time=Sys.time()
error_log=c()
   LSTM_Forecasts <- lapply(1:1428, function(x) {
     if(x%%2==0){
       message(paste("I'm at",x))
     }
     tryCatch({
     return(run_LSTM(json_file[[x]]$target,
              horizon = 7,
              n_steps = 20,
              cells = 500,
              learning_rate = 0.01,
              epochs = 300,
              patience = 3,
              min_delta = 1))
     }, error=function(e){
       error_log<-c(error_log, x)
     })
   })
end_time=Sys.time()
end_time-start_time


#YOU NEED TO CHANGE THE NAME OF THE FORECAST TO MATCH THE HORIZON.
write_forecasts(LSTM_Forecasts,"LSTM_Forecasts_7","LSTM_Forecasts")

##ARIMA

    source('Functions.R')
    source('Preprocess.R')
    source('Cochrane_Orcutt.R')
      start <- Sys.time()
    source('ARIMA.R')
      print( Sys.time() - start )
    # TRY WITH auto.ssarima() from smooth

#ES

    source('Functions.R')
    source('Preprocess.R')
      start <- Sys.time()
    source('ES.R')
      print( Sys.time() - start )

#CES

    source('Functions.R')
    source('Preprocess.R')
      start <- Sys.time()
    source('CES.R')
      print( Sys.time() - start )

#Theta

    source('Functions.R')
    source('Preprocess.R')
      start <- Sys.time()
    source('Theta.R')
      print( Sys.time() - start )

source('sMAPE.R')
##write sMAPES to file
write_sMAPES(my_sMAPES,'sMAPES',name)

summary_all_horizons(my_sMAPES)
