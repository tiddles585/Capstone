
start_time=Sys.time()
error_log=c()
LSTM_Forecasts <- lapply(1, function(x) {
  if(x%%2==0){
    message(paste("I'm at",x))
  }
  tryCatch({
    temp_fores<-matrix(nrow=5,ncol=18)

    for(runner in 1:5){
    set.seed(as.integer(Sys.time()))
    foress<-run_LSTM(json_file[[x]]$target,
             horizon = 18,
             n_steps = 25,
             cells = 500,
             learning_rate = 0.35,
             epochs = 1000,
             patience = 10,
             min_delta = .01)
    temp_fores[runner,]<-foress
    }
    #message(apply(temp_fores, 2, paste(median,0)))
    return(list('forecasts'=apply(temp_fores, 2, median)))
    #return(list('forecasts'=temp_fores))
    #return(temp_fores)
  }, error=function(e){
    error_log<-c(error_log, x)
  })
})
end_time=Sys.time()
end_time-start_time

sapply(LSTM_Forecasts, function(forecasts) {
print(unlist(forecasts))

})
?colMedians
horizon=18
h=18
which_series=1
sMAPE_calculate(json_file,LSTM_Forecasts)


library(jsonlite)

# Assuming your R list is named 'my_list'
# Convert the R list to a JSON string
json_str <- toJSON(json_file)

# Save the JSON string to a file
write(json_str, file = "list_data.json")
