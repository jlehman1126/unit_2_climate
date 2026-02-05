# 2026-02-03
# JEL

url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'

co2 = read.table(file = url, col.names = c("year", 
                                          "month", 
                                          "decimal_date", 
                                          "monthly_average",
                                          "deseasonalized", 
                                          "n_days", 
                                          "st_dev_days", 
                                          "monthly_mean_uncertainty"))

# plot it!

plot(monthly_average ~ decimal_date, data = co2, type = "l") # plots average co2 over times series
lines(deseasonalized ~ decimal_date, data = co2, col = "red") # adds line with seasonality factored out

co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized #creates new columnn showing seasonality

plot(seasonal_cycle ~ decimal_date, data = co2, type = "l") # plots seasonal effects

# grab most recent 5 years and plot it

co2_2021to2026 = co2[co2$decimal_date > 2021 , ]

plot(seasonal_cycle ~ decimal_date, data = co2_2021to2026, type = "l")

jan_anomalies = co2$seasonal_cycle[co2$month == 1]
mean(co2$seasonal_cycle[co2$month == 1])

# create data frame with monthly detrended co2 anomalies
co2_monthly_cycle = data.frame(month = c(seq(12)),
                              detrended_monthly_cycle = NA)

# fill in the data
co2_monthly_cycle$detrended_monthly_cycle[1] = mean(co2$seasonal_cycle[co2$month == 1])
co2_monthly_cycle$detrended_monthly_cycle[2] = mean(co2$seasonal_cycle[co2$month == 2])
co2_monthly_cycle$detrended_monthly_cycle[3] = mean(co2$seasonal_cycle[co2$month == 3])
co2_monthly_cycle$detrended_monthly_cycle[4] = mean(co2$seasonal_cycle[co2$month == 4])
co2_monthly_cycle$detrended_monthly_cycle[5] = mean(co2$seasonal_cycle[co2$month == 5])
co2_monthly_cycle$detrended_monthly_cycle[6] = mean(co2$seasonal_cycle[co2$month == 6])
co2_monthly_cycle$detrended_monthly_cycle[7] = mean(co2$seasonal_cycle[co2$month == 7])
co2_monthly_cycle$detrended_monthly_cycle[8] = mean(co2$seasonal_cycle[co2$month == 8])
co2_monthly_cycle$detrended_monthly_cycle[9] = mean(co2$seasonal_cycle[co2$month == 9])
co2_monthly_cycle$detrended_monthly_cycle[10] = mean(co2$seasonal_cycle[co2$month == 10])
co2_monthly_cycle$detrended_monthly_cycle[11] = mean(co2$seasonal_cycle[co2$month == 11])
co2_monthly_cycle$detrended_monthly_cycle[12] = mean(co2$seasonal_cycle[co2$month == 12])

# plot the detrended monthly cycle
plot(detrended_monthly_cycle ~ month, data = co2_monthly_cycle, type = "l", col = "navy")


# for loops - for when you know how many times a task is to be repeated
for (i in c(1:4)){
    print(i)
}

sentence = c("loops", "are", "fun", "y'all")
for (word in sentence){
    print(word)
}


my_vector = c(1,3,5,2,4)

# square every element in this vector, create results vector to store for loop results
my_vector_squared = rep(NA, 5)
my_vector_squared = rep(NA, length(my_vector))

for (i in seq(n_my_vector)){
    print (paste ("I'm on iteration: ", i))
    my_vector_squared[i] = my_vector[i]^2
    print(paste("My answer is: ", my_vector_squared[i]))
}
my_vector_squared

# calculate total of a vector
my_vector = c(1,2,3,4,5)
n_my_vector = length(my_vector)
my_vector_total = 0 
for (i in seq(n_my_vector)){
  print(my_vector_total)
  my_vector_total = my_vector_total + my_vector[i]
}

# class exercise 5.1

num = 6
factorial_result = 1
for(i in seq(num)){
  factorial_result = i * factorial_result
  print(factorial_result)
}


# nested for loops

mat = matrix(c(2,0,8,3,5,-4), nrow = 2, ncol = 3)
mat
mat_squared = matrix(rep(NA, 6), nrow = 2, ncol =3)
mat_squared

dim(mat)

for(i in seq(dim(mat)[1])){
  for(j in seq(dim(mat)[2])){
    print(paste("I'm on row: ", i, "and column: ", j))
    mat_squared[i,j] = mat[i,j]^2
  }
}
# this will run the inner most for loop first so it went through each column first (j) then moved to rows (i)
mat_squared


# while loops - for when you don't know how many times a task needs to be repeated

x = 1
while (x > 0){
  x = x + 1
} # this is going to be an infinite loop and will not stop

# fish catching game - can't catch more than 50lb of fish

total_catch_lb = 0
n_fish = 0
while (total_catch_lb < 50){ # keep fishing while total catch is under 50
  new_fish_weight = rnorm(n = 1, mean = 2, sd = 1)
  total_catch_lb = total_catch_lb + new_fish_weight
  n_fish = n_fish + 1
  print(paste("n fish =", n_fish, " and new fish weight = ", new_fish_weight))
}

