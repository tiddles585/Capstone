d_values = lapply(json_file, function(x) x[[4]][3])
d_values_counts <- table(unlist(d_values ))
print(d_values_counts)

domain_values = lapply(json_file, function(x) x[[3]][2])
domain_values_counts <- table(unlist(domain_values))
print(domain_values_counts)