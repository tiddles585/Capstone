## Get Cochrane orcutt trend results
json_file<-cochrane_orcutt_eval(json_file)

##Remove Trend
json_file<-remove_trend_differencing(json_file)
