# Tutorial 1 - 04-03-2024

# _______________________________________________
# A 
# 1
a = 3 + 5 - 10
a


# 2 
4^5

# 3
log(3*4)

exp( 2.484907)
# the two functions above are 
# reverse of each other by default.

# 4  
sin(pi)
# it means really small number.

# 5
sqrt(4) / log(10)
log(10)
# defualt is base "e".

# log(number, base)
log(100, 10)


# 6
abs(-10)+floor(4.6)+ceiling(3.2)


# ______________________________________________
# B 

# 1
# Write a vector:
c("table", "chair", "closet", "window") -> v0
v0

# Accessing values inside the vector:
v0[4]

# 2
# Change the element on position 4 to shelf
# Rewriting elements:
v0
v0[4] <- "shelf"
v0

# 3
#  Write vector v1 
c(1, 4, 3, 15, 75) -> v1


# 4 
# Write vector v2
c(5, 6, 0, sqrt(2), -4) -> v2

# 5
# increase values of v1 by 3
v1
v1 + 3 


# 6 
# Double values of v2
v2
v2 * 2


# 7 
# Sum vectors v1 and v2 
v1 
v2 
v1 + v2 


# 8 
# Dot product of v1 and v2
v1
v2
v1 * v2

sum(v1 * v2)

# 9 
# Merge vectors v1 and v2 into 
# one longer vector, in that order.
c(v1, v2)


# _______________________________________________
# C 

# 1 
# Write vector 1, "a", TRUE
# You can cut true and false into t and f
TRUE 
FALSE
F 
T 

c(1, "a", T)
# Everything gets transformed into a character element.


# 2 
# Write a vector v with values 1..100 
v <- 1:100
v

# 3
# Sum all values in v
sum(v)

# 4 
# Calculate 1 + 4 + 9 + 16 + 25 + 36 + .. + 1000
v^2
sum(v^2)


# 5 
# Find arithmetic mean in v
mean(v)


# 6 
# Find min and max of v
min(v)
max(v)


# 7 
# In v replace all but the the first seventy values
# with 0
end(v)[1]
v[71:end(v)[1]] <- 0
v

# 8
# In v replace all but every fifth value to -1
v[-seq(5, end(v)[1], 5)] <- -1
v
?1:100



# Peter's solutions for above:
v <- 1:100
v[71:length(v)] <- 0
v

v[1:20*-5] <- -1
v
# bit tid weird but, iz fine I guess.


# ______________________________________________
# D

# 1 
# Write the vector with values 100, 99, 98, ..., 2, 1.
seq(100, 1)


# 2
# Vector with values, -100,..,-2, -1
seq(-100, -1)

# 3
# Vector with values -1, -2, -3,..., -99, -100
seq(-1, -100)

# 4 
# Vector with values -50, -40, -30, -20,..., 1000
seq(-50, 1000, 10)

# 5
# Vector with value 1, 4, 7, 10, ..., 106
seq(1, 106, 3)


# 6
# Try all of the above also with : instead of seq.
# 1 
100:1
# 2
-100:-1
# 3
-1:-100
# 4
-5:100 * 10
# 5
0:35 * 3 + 1





# ________________________________
# E 

# 1 
# list 1, "a", T
l1 <- list(1, "a", T)


# 2
l2 <- list(2, 3, 2, "banana", 1:10)
l2

# To read the list in a reverse order we do it,
# like this:
l2[length(l2):1]

# 3
# Replace second el of l1 with "A"
l1[[2]] <- "A"
l1


# 4 
# l3 = l1 and l2 
l3 <- c(l1, l2)
l3

# When we do list instead of c, we get a 
# nested list. We do not want that in this case.
l4 <- list(l1, l2)
l4

# 5
# Find 4th value of vector on 5th position of l2.
l2[[5]][4] 

# First we specify which list, then which element
# of that list to get the vector. And then 
# specify which element of that vector we want to
# take.


# 6
# Write l4 with beer, 4.3, l1, KOPER, l2
l4 <- list("beer", 4.3, l1, "KOPER", l2)
l4


# 7
# Change the 3rd element of the list, l4,
# with value -2
l4[[3]][[3]] <- -2



# 8
# Find sum of values of list l5 
# l5 = 4, 5.3, 1.4, 0, -3, 3, 3
l5 <- list(4, 5.3, 1.4, 0, -3, 3, 3)
l5

# since sum() works only for vectors:
# we have to turn the list into a vector.
# We do this by using unlist function.
unlist(l5) 

sum(unlist(l5))


# _______________________________________________
# F

# 1 
# Write the matrices:

m1 <- matrix(1:9, 3, byrow = T)
m2 <- matrix(9:1, 3)
m3 <- matrix(1:4, 2, 6)
m1
m2
m3


# 2
# Find sum of the matrices m1 and m2 
m1 + m2

# 3 
# Decrease values of m3 by 10
m3 <- m3 - 10

# 4 
# Triple the values of m1
m1 <- m1 * 3 
m1 

# 5
# Merge m1 and m2 horizontally, and then
# vertically with m3

# To achieve this we have functions, called
# rbind and cbind.

cbind(m1, m2) # column wise - horizontally
rbind(cbind(m1, m2), m3) # row wise - vertically


# 6
# Square the values of m1.
m1^2

# Different from matrix multiplication:
m1 %*% m1




# ____________________________________________
# G

# 1
# Find dimensions of m3 
dim(m3)
nrow(m3)
ncol(m3)

# 2 
# Change value of element in second row
# first column of matrix m1 to -1
m1[2,1] <- -1
m1

# 3
# Find second column of matrix m2
m2
m2[,2] 

# We get back a vector, If we want to keep it
# as a matrix we use drop=F
m2[, 2, drop=F]
# The conversion to vector happens, when we get back
# a matrix with a dimensions of 1, for row or column.


# 4 
# Find any 2x2 submatrix in the matrix m2 and change
# its values to zero 
m2
m2[1:2, 1:2] <- 0
m2


# 5
# Change all but the first row in the matrix m1 with 5
m1
m1[-1,] <- 5
m1

# 6
# Write the matrix ... a, b
#                      c, d
# and merge it horizontally with m3.
m4 <- matrix(c("a", "b", "c", "d"), 2, 2, byrow=T)
m4

cbind(m4, m3) # merges horizontally
m3



# We can do it like this:

m4 <- matrix(letters, 2, 2, T)
m4
cbind(m4, m3)
# Everything got converted to characters. Since 
# we have to have only on type inside a matrix.





