library(tableHTML)

# Create the data for the table
data <- data.frame(
  ENS = c("ENS 1", "ENS 2", "ENS 3", "ENS 4", "ENS 5"),
  Ensemble = c(
    "Mean",
    "Median",
    "Mean",
    "Mean",
    "Mean"
  ),
  Composition = c(
    "Holt Winter Additive + Holt Winter Multiplicative + MLP + ARIMA",
    "Holt Winter Additive + Holt Winter Multiplicative + MLP + ARIMA",
    "ARIMA + MLP",
    "Holt Winter Additive + Holt Winter Multiplicative + MLP",
    "Holt Winter Additive + Holt Winter Multiplicative + ARIMA + MLP + CES + Theta"
  )
)

# Create the HTML table
tableHTML <- tableHTML(data, header = c("ENS", "Ensemble", "Composition"))
tableHTML



tableHTML(data, header = c("Ensemble Name", "Ensemble Scheme", "Methods Used")) %>%
  add_css_caption(css = list(c('border-collapse', 'border-spacing'), c('separate', '15px'))) %>%
  # add_css_conditional_row(
  #   conditional = "min",
  #   css = list(c("border-top", "border-bottom"), c("1px solid #CD7F32", "1px solid #CD7F32")),
  #   rows = c(1, 2)
  # ) %>%
  add_css_row(css = list(c("font-weight",'text-align'), c("bold",'center')), rows = 1:6) %>%
  add_css_column(css = list("padding-right", "20px"), columns = 1)%>%
  add_css_row(css = list('background-color', '#f2f2f2'),
              rows = odd(2:6))%>%
  add_css_header(css = list( c('height','border-bottom','background-color','color','font-size'), c('10px','5px solid steelblue','steelblue','white','17px')),headers = 1:4)

# Display the HTML table
print(tableHTML)

n <- 3  # Total number of items
num_combinations
num_combinations <- sum(choose(n, 1:n))


nA <- 3  # Number of items in set A
nB <- 6  # Number of items in set B

num_combinations <- 2^nA * 2^nB - 2^(nA + nB) + 1
num_combinations
