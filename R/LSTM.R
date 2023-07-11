library(keras)
library(dplyr)

#######################################################################################-

##SMAPE LOSS FUNCTION ONLY FOR KERAS

##This is tensor math and will not work elsewhere

smape_loss <- function(y_true, y_pred) {
  
  ##allows for tensor abs mean and epsilon functions to be used
  backend()
  
  horizon <- ncol(y_pred)
  numer <- 2 *  k_abs(y_pred - y_true)
  denom <- k_abs(y_pred) + k_abs(y_true) + k_epsilon()
  return(200 / horizon * k_mean(numer / denom))
}

#######################################################################################-

run_LSTM<-function(ts,min,max,horizon,n_steps,cells,learning_rate,epochs,patience,min_delta){
  #ts=series, #horizon , n_steps=# steps to remember ,cells=units ,learning_rate, epochs,
  #patience=callback patience, min_delta,callback min change
  
  # vars
  
  n <- length(ts)
  n_steps <- n_steps
  horizon <- horizon
  
  ## make tensor
  #double check which is right
  
  #array_size = n - n_steps - horizon + 1
  array_size = n - n_steps - horizon
  
  #preset dimensions
  
  x_train <- array(0, dim = c(array_size, n_steps, 1))
  y_train <- array(0, dim = c(array_size, horizon))
  
  x_test <- array(0, dim = c(1, n_steps, 1))
  y_test <- array(0, dim = c(1, horizon))
  
  ##insert values
  
  for (i in 1:(array_size)) {
    x_train[i,,] <- ts[i:(i+n_steps-1)]
    y_train[i,] <- ts[(i+n_steps):(i+n_steps+horizon-1)]
  }
  
  y_test[1,] <- ts[(n-horizon+1):n]
  x_test[1,,] <- ts[(array_size+1):(n-horizon)]
  
  
  # make lstm model
  
  model <- keras_model_sequential() %>%
    layer_lstm(units = cells, input_shape = c(n_steps, 1)) %>%
    layer_dense(units = horizon)
  
  # compile
  
  model %>% compile(
    loss = smape_loss,
    optimizer = optimizer_adam(learning_rate = learning_rate)
  )
  
  
  # fit
  
  model %>% fit(
    x_train, y_train,
    epochs = epochs,
    verbose = 0,
    
    callbacks = list(callback_early_stopping(monitor = 'loss',patience = patience,min_delta = min_delta))
  )
  
  #predict
  preds<-model %>% predict(x_test)
  
  # invert scale
  preds<-rescale(preds,
                 from=c(-1,1))#,
                 #to=c(min,max))
  
  return(list('forecasts'=preds))
  
  #print results
  
  # cat("####ACTUAL####\n" )
  # cat(y_test)
  # cat("\n\n")
  # cat("####PREDICTED####\n")
  # cat(y_pred)
  # return(model)
  
}




