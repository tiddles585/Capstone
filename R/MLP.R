###
#series 689, #4 and 7 had the auto seasonality selector turned off and reps turned to 1
#series 689 #8 had auto seasonality and lag selector turned off, reps turned to 1
#the rest of 689 had reps set to 1
#series 1201, 7,13,14, and 16 had reps turned to 1 and seasonality/lag selector turned off
#series 369, h=15 had reps set to 1
#This was due to the nnfor MLP not converging


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
library(dplyr)
library(nnfor)
##try catch one
forecast_mlp <- function(json_file, h = 0) {
  error_log <- list()

  fore_holder <- invisible(lapply(seq_along(json_file), function(i) {
    y <- json_file[[i]]  # Get the current element from the json_file list
    tryCatch({
      model_mlp <- mlp(
        ts(y$target[1:(length(y$target) - h)]),
        reps = 1,
        difforder = NULL,
        allow.det.season = FALSE,
        sel.lag = TRUE,
        comb = 'median'
      )

      list('forecasts' = array(forecast(model_mlp, h = h)$mean))
    }, error = function(e) {
      # Save the error information to the global error_log variable
      error_log <<- append(error_log, list(index = i, error = conditionMessage(e)))
      print(paste("Error occurred for index:", i))
      # Handle the error case if needed
      # For example, you can return a specific value or NULL
      # list('forecasts' = NULL)
    })
  }))

  return(fore_holder)
}

error_log=c()
#

# # Create an empty list with one index
# MLP_Forecasts_3 <- list()
#
# # Add 1428 indexes to the list
# MLP_Forecasts_3[[1]] <- vector("list", 1428)
#
# # Loop over the 1428 indexes and add a `$forecast` item to each index
# for (i in 1:1428) {
#   MLP_Forecasts_3[[1]][[i]] <- list(forecast = rep(0, 2))
# }

#json_file[[689]]$target<-gen.arma.wge(144)
mlp
for(my_h in 5){
  my_h=7
  rm(MLP_Forecasts_3)
  horizon=my_h
  name=paste0('MLP_forecast_',horizon)
  time_start=Sys.time()


  which_series=1201
  rm(MLP_Forecasts_3)
  MLP_Forecasts_3<-lapply(horizon,function(x) forecast_mlp(json_file[which_series],h=x))



#adds forecast in
  series_689[[7]][1]$forecasts<- MLP_Forecasts_3[[1]][[1]]$forecasts
#removes error message
series_689[[7]][[1]] <- series_689[[4]][[1]][-1]

series_689[[4]][[1]][['forecasts']]
time_end=Sys.time()
  differ=time_end-time_start

  OutApp <- COMCreate("Outlook.Application")
  outMail = OutApp$CreateItem(0)
  outMail[["To"]] = '3308532285@txt.att.net'
  outMail[["subject"]] = paste("Done! series",my_h,":time:",differ)
  #outMail[["body"]] = ""
  outMail$Send()
  write_forecasts(MLP_Forecasts_3,folder = folder,name=name)
}


write_forecasts(MLP_all_forecasts,folder = folder,name=name)

######################



my_files <- dir("MLP_Forecasts")


##sort files in directory
sort_files <- function(files) {

  numbers <- gsub("[^0-9]", "", files)

  numbers <- as.numeric(numbers)

  sorted_files <- files[order(numbers)]

  return(sorted_files)
}

sorted_files <- sort_files(my_files)

series_689[[7]][[1]]


MLP_all_forecasts <- lapply(sorted_files, function(file) {
  read_in<-readRDS(paste0("MLP_Forecasts/",file))  # Load each file into the list
  modified_list <- lapply(read_in[[1]], function(x) {
    x
  })
  return(modified_list)  # Add the loaded object to the list
})


