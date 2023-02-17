##Read in monthly, quarterly, yearly, or other data
json_file<-read_data(which_data='monthly')
##Turns series into numeric values
json_file<-to_numeric(json_file)
## Sets meta data about series
json_file<-series_features(json_file)
