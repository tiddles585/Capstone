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
    name='ARIMA_CochraneOrc_forecast_1428'
    folder = 'ARIMA_Forecasts'

###############
###############
##Run your things
###############
###############
##MLP

##LSTM

    source('Functions.R')
    source('Preprocess.R')

    run_LSTM(json_file[[1]]$target,
             horizon=5,
             n_steps=10,
             cells=500,
             learning_rate=.1,
             epochs=100,
             patience=3,
             min_delta=1)

##ARIMA

    source('Functions.R')
    source('Preprocess.R')
    source('Cochrane_Orcutt.R')
    source('ARIMA.R')

#Holts Winter

    source('Functions.R')
    source('Preprocess.R')
    source('HW.R')

source('sMAPE.R')
##write sMAPES to file
write_sMAPES(my_sMAPES,folder,name)

summary_all_horizons(my_sMAPES)
