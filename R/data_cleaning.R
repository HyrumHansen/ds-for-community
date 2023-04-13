library(readxl)

# Read in the data
snac_data <-  read_excel("data/snac_data.xlsx")

subset_data <- cbind(snac_data["Month"],
                 snac_data["Unduplicated Individuals"])

# It looks like SNAC was closed May, June, and July 2020.
# We can replace these values with the average of the surrounding months
set.seed(1234)
subset_data[c(88),]['Unduplicated Individuals'] <-
  (sum(subset_data[c(85, 86, 87, 91, 92, 93),]['Unduplicated Individuals'])
   +100*runif(1, -1, 1))/6
subset_data[c(89),]['Unduplicated Individuals'] <-
  (sum(subset_data[c(85, 86, 87, 91, 92, 93),]['Unduplicated Individuals'])
   +100*runif(1, -1, 1))/6
subset_data[c(90),]['Unduplicated Individuals'] <-
  (sum(subset_data[c(85, 86, 87, 91, 92, 93),]['Unduplicated Individuals'])
   +100*runif(1, -1, 1))/6

subset_data <- subset_data[complete.cases(subset_data),]

# Convert the data to time series data
ts_data <- ts(ts_data['Unduplicated Individuals'],
              start=c(2017, 9), end=c(2023, 3), frequency=12)

write.csv(ts_data, "data/ts_data.csv")
