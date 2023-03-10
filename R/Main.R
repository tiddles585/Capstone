#Clears Environment

rm(list=ls())

###############
###############
##Global Variables
###############
###############

  #Can be single number or x:y
    horizon=2:3

  ##Mainly for testing, this allows you to only use the first 20 series in the object for simplicity
  ##Presently if you want to use the whole series, you will have to change this to 1:1428
  ##Note: for horizon and which_series, this only affects
    which_series=1:20

  #####
  ##name of file to save, folder name for model
  ##Folder can be 'ARIMA_Forecasts','HW_Forecasts, or 'MLP_Forecasts' at the moment
  ##Naming convention: <Model>_<Trend_Remover>_<Seasonality_Remover>_forecast<horizons>

    name='HW_ADDI_forecast_1_20'
    #name='HW_MULTI_forecast_1428'
    folder = 'HW_Forecasts'

###############
###############
##Run your things
###############
###############

source('Functions.R')
source('Preprocess.R')
#source('Cochrane_Orcutt.R')
#source('ARIMA.R')

# BE CAREFUL WHEN RUNNING, SAYS ADDI BUT MIGHT HAVE MULTI FORECASTS
source('HW.R')

source('sMAPE.R')
##write sMAPES to file
write_sMAPES(my_sMAPES,folder,name)




##sMAPE values are saved to disk and also in the object my_sMAPES
###############
###############
##Summary
###############
###############

##summary

##Prints one horizon at a time + a histogram
sMAPE_summary(my_sMAPES,h=18)

#Prints mean, median, min and max of all horizons at once
summary_all_horizons(my_sMAPES)
