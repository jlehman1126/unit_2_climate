# 2026-02-10
# JEL 

# Defining your own functions
x = c(1,2,3,4)

# good idea to name your function a verb so you know what you are doing with that function
avg = function(x){
  s = sum(x)
  n = length(x)
  answer = s/n 
  return(answer)
}

avg(x)
avg(seq(from = 3, to = 500))

# this function will calculate the arithmetic mean by default otherwise, will calculate the geometric mean 
avg = function(x, arithmetic = T){
  if( !is.numeric(x) ){
    stop("Error: x isn't numeric") # this is a check to ensure the data you are working with is correct
  }
  if(arithmetic){
    result = sum(x) / length(x)
  } else if (arithmetic == F){ # assume user wants geometric mean
    result = prod(x)^(1/length(x))
  } else {
    print("Unclear if you wanted an arithmetic mean")
  }
  return(result)
}

avg(x)
avg(x, arithmetic = F)
avg(arithmetic = F, x = seq(from = 5, to = 13))
avg(x, TRUE)

avg("hi")

# Examining global temperature trends

url = "https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt"

temp_anomaly = read.delim(file = url, 
                          skip = 5, 
                          sep = "",
                          header = F,
                          col.names = c("Year", "No_Smoothing", "Lowess_5"))
head(temp_anomaly)

# Plot this

plot(No_Smoothing ~ Year, data = temp_anomaly, 
    ylab = "Global Temp Anomaly (*C)")
lines(No_Smoothing ~ Year, data = temp_anomaly)
lines(Lowess_5 ~ Year, data = temp_anomaly, col = "red")

temp_1998 = temp_anomaly$No_Smoothing[temp_anomaly$Year == 1998]
temp_2012 = temp_anomaly$No_Smoothing[temp_anomaly$Year == 2012]

# A B Line can add aditional lines 
abline(v = 1998 , lty = "dashed") # v will add a vertical line at 1998
abline(v = 2012, lty = "dashed")

# Add a line from 1998 to 2012 - "global warming hiatus"
# lwd = line width
lines(x = c(1998, 2012), y = c(temp_1998, temp_2012), col = "blue", lwd = 3)

# Smoothing our own data
# Calculating rolling 
# make a user defined funciton to calculate rolling average

calc_rolling_avg = function(data, moving_window = 5){
  result = rep(NA, length(data))
  for (i in seq(from = moving_window, to = length(result))){ #skip the elements proceeding the moving_window
    result[i] = mean(data[seq(from = (i - moving_window +1), to = i)])
  } 
  return(result)
}

temp_anomaly$avg_5yr = calc_rolling_avg(temp_anomaly$No_Smoothing)
temp_anomaly$avg_10yr = calc_rolling_avg(temp_anomaly$No_Smoothing, moving_window = 10)
head(temp_anomaly)
tail(temp_anomaly)


# plot it 

plot(No_Smoothing ~ Year, data = temp_anomaly, type = "l")
lines(avg_5yr ~ Year, data = temp_anomaly, type = "l", col = "red", lwd = 2)
lines(avg_10yr ~ Year, data = temp_anomaly, type = "l", col = "green", lwd = 2)
# a little bit of a lag in the smoother due to the fact that the last year is the focal year

grade_calc = function(data){
    if (data >= 90)
      print(paste("You got an A!"))
      letter = "A"
  } else if (data < 90 & data >= 80){
    print(paste("You got a B!"))
    letter = "B"
  } else if (data < 80 & data >= 70){
    print(paste("You got a C!"))
    letter = "C"
  }

data = 78
what_my_grade = grade_calc(data)
