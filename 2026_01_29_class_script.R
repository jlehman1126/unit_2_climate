# JEL 2026-01-29
# Boolean Logic

vec = c(1,0,2,1) # can make a vector
vec[ c(T,F,T,F)] # can call specific adresses

x = 1
y = 3
x != y # does x not equal y?
x == y # does x equal y?

x %in% vec # is the value of x included in a vector?, "elemental" analysis and will go through each item

world_oceans = data.frame(oceans = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))

world_oceans[ world_oceans$avg_depth_m > 4000, ] # will return the rows that contain avg depths that are greater than 4000m
world_oceans$oceans[ world_oceans$avg_depth_m > 4000] # will only return the names of the oceans greater than 4000m

1 +2 == 3 # this says TRUE
0.1 + 0.3 == 0.3 # this says FALSE, binary cannot replicate a decimal

(0.1 + 0.2) - 0.3 # we see there is a measurable difference in 0.1 + 0.2 and 0.3 so FALSE
error_threshold = 0.001
abs(0.3 - (0.1 + 0.2)) > error_threshold # tells us difference is negligible

# Boolean operators
# &, |, xor, !, any, all

x = 7
x > 5 & x < 10 # is x greater than five AND less than 10

x > 5 & x %in% c (1,2,3)
x > 5 | x %in% c (1,2,3) # | means or, so is x > 5 or is it in the vector

vec1 = c(1,2,3)
vec2 = c(3,2,1)
vec1 == vec2

world_oceans[ (world_oceans$avg_depth_m > 4000) & (world_oceans$area_km2 > 100e6), ]

vec2 = c(1,2,NA,4)
2 %in% vec2
NA %in% vec2

x = NA
y = NA
x == y
is.na(x)

# test if else statements

num = -2

if(num < 0){
  num = num * -1
  print("I made num positive!")
}

# Class exercise 3.1 - figure this out
temp = 97

if(temp > 99){
  diff(temp - 99)
  print(diff)
} else{
  print("you dont have a fever")
}

a = 200
b = 200

if(a>b){
  print("a wins")
} else if (b > a){
  print("b wins")
} else if (a == b){
  print("it's a tie!")
} else{
  print("something is wrong with your data :(")
}
