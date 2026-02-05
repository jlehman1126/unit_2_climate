# 2026-02-05
# JEL

# 2.6 - Arctic Sea Ice, loading data from NOAA

# http://nsidc.org/data/G02135
url = "https://noaadata.apps.nsidc.org/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v4.0.csv"

arctic_ice = read.csv(file = url, skip = 2, header = F, 
  col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_Data"))

head(arctic_ice)
tail(arctic_ice)
summary(arctic_ice)

# change date format, lubridate allows date manipulation
install.packages("lubridate") # only need to do this once
library(lubridate) # do this every R session # use make_date()

arctic_ice$date = make_date(year = arctic_ice$Year, month = arctic_ice$Month, day = arctic_ice$Day)
# gives date in one column as YYYY-MM-DD

plot(Extent ~ date, data = arctic_ice, type = "l", 
      main = "NOAA Arctic sea ice extent",
      ylab = "Sea ice extent (*10^6 km^2)")

# calculate the annual average arctic sea ice extent

min(arctic_ice$Year)
max(arctic_ice$Year)
arctic_ice_averages = data.frame(Year = seq(from = min(arctic_ice$Year) + 1, to = max(arctic_ice$Year) - 1),
                                  extent_annual_avg = NA, 
                                  extent_5yr_avg = NA)

arctic_ice_averages$extent_annual_avg[1] = mean(arctic_ice$Extent[arctic_ice$Year == 1979])
head(arctic_ice_averages)

# create annual averages for sea ice extent
for(i in seq(dim(arctic_ice_averages)[1])){
  arctic_ice_averages$extent_annual_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year == arctic_ice_averages$Year[i]])
  print(paste("i =", i, "year =" , arctic_ice_averages$Year[i]))
}

plot(extent_annual_avg ~ Year, data = arctic_ice_averages, type = "l")

# create 5 yr average extent sea ice, defined as Jan 1 2 years before focal year and Dec 31 2 years after
# first and last two years will stay NA because we do not have the defined data

i = 3
for(i in seq(3, dim(arctic_ice_averages)[1] - 2)){
  years = seq(from = arctic_ice_averages$Year[i] - 2, to = arctic_ice_averages$Year[i] + 2)
  arctic_ice_averages$extent_5yr_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year %in% years])
  print(years)
}

tail(arctic_ice_averages)

plot(extent_5yr_avg ~ Year, data = arctic_ice_averages, type = "l")
lines(extent_annual_avg ~ Year, data = arctic_ice_averages, type = "l", col = "purple")

arctic_ice_averages$date = make_date(year = arctic_ice_averages$Year, month = 6, day = 30)
head(arctic_ice_averages)

plot(Extent ~ date, data = arctic_ice, type = "l")
lines(extent_annual_avg ~ date, data = arctic_ice_averages, type = "l", col = "red")
lines(extent_5yr_avg ~ date, data = arctic_ice_averages, type = "l", col = "blue")
