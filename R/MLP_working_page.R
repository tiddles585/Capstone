MLP_all_forecasts[[6]][1201]=MLP_Forecasts_3[[1]][1]
MLP_all_forecasts[[6]][1201]
MLP_Forecasts_3[[1]][1]
for(i in 1:16){
print(length(series_689[[i]][[1]]$forecasts))

}

series_689[[1]][[1]]
MLP_Forecasts_3[[1]][[1]]$forecasts
MLP_all_forecasts[[12]][[1200]]$forecasts
MLP_all_forecasts[[14]][[369]] <- list(forecasts = MLP_Forecasts_3[[1]][[1]]$forecasts)

length_mismatch_indices <- c()

for (i in 1:1428) {
  tryCatch({
    if (length(my_forecasts[[6]][[i]]$forecast) != 7) {
      length_mismatch_indices <- c(length_mismatch_indices, i)
    }, error = function(e) {
      # Save the error information to the global error_log variable
      error_log <<- append(error_log, list(index = i, error = conditionMessage(e)))
      print(paste("Error occurred for index:", i))
  })
  }
}

# Print the indices where the length of the forecast is not 15
if (length(length_mismatch_indices) > 0) {
  print("The length of the forecast is not 15 in the following indices:")
  print(length_mismatch_indices)
} else {
  print("The length of the forecast is 15 for all nested lists.")
}
