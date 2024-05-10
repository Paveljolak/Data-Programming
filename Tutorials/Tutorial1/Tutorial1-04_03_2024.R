# Tutorial1 - 04/03/2024

#Calculate with R:
  
  #a=3+5−10
 # 4^5
  #ln(3⋅4)
 # sin(π)
 # , what does the result mean?
 #   4√log10(100)
#  # |−10|+⌊4.6⌋+⌈3.2⌉



# A _____________________________________________________
#1
a=3+5-10

a  

# 2
4^5

4**5
# the above two are the same shit


# 3
#this is a natural log
log(3*4)


# 4
sin(pi)

1e-4

# 5
sqrt(4)/log10(100)

# 6
abs(-10) + floor(4.6) + ceiling(3.2)

?floor

# B _______________________________________________________
# 1
# Write the vector v0 with values “table”, “chair”, “closet”, “window”.


# function c is for creating vectors

v0 <- c("table", "chair", "closet", "window")

v0


# 2
# my try, probably slower with bigger vectors, should work
# better for when we dont know the size of the vector
v0 <- c(v0, "shelf")

v0

# tutorial way to do it
v0[4]<-"shelf"

v0


# 3 
v1 <- c(1, 4, 3, 15, 75)

v1


# 4
v2 <- c(5, 6, 0, sqrt(2), -4)

v2

# 5
v1 <- v1 + 3

v1

# 6 
v2 <- v2 * 2

v2 


# 7
sum <- v1 + v2

sum


# this is how you find a length of your vector
length(v1)

# 8
v1 
v2

# take first value of v1 multiply by first value of v2
v1*v2 # mult elements of same positions

# then we want to sum them, so we get:
sum(v1*v2)


# 9

# we can do this
c(1,2,v1,12)

# so to solve 9 we get
c(v1, v2)

# this is how we get them to merge.



# ____________________________________________
# C

# 1
c(1, "a", TRUE)
# everything turned to strings


# We can also write true's and false's like this
T
F

# another automatic type conversion
c(1,T)


# 2
v <- c(1:100)


# the convention c(1:100) is the only way to create integers
# anything else it would give us numeric values.


# 3
sum(v)

# 4
sum(v^2)


# 5
mean(v)


# 6
min(v)
max(v)

# 7
v[2] # this is how we access the second value
v[101] # NA -> Not Available - since it does not exist



v[c(2,4,5)] # it will give us the numbers on those positions

v[71:100] <- 0 # access the 71 to 100 numbers and overwrite them with 0

v


# more dynamic approach would be
v[71:length(v)]

# this is accessing elements from 71 position until the end
# it works when we don't know which one is the end

# 8 
v[1:20*5] # basically get nums from 1-20 then multiply
          # everything by 5 and we get 1, 5, 10 ....

v[1:20*5] <- -1 

v


# but the task asks to turned every num to -1 except
# the ones on every fifth position so:
v[2] # gives the second element
v[-2] # gives everything but the second element

# similarly to up just with minuses now
v[c(-2, -4)]
# so this would ommit 2 and 4 

# so we can just write -5 at the end and get 
# everything -1 except every fifth element.

v[1:20*-5] <- -1

v

# predefined vector with all letters
letters
letters[c(2, 4)] # only 2 and 4
letters[-c(2, 4)] # everything but 2 and 4

# ________________________________________________
# D


# 1
c(100:1)

# apperently the right choice
seq(100,1,-1)

# 2
c(-100:-1)

# apperently the right choice
seq(-100,-1,1)


# 3
c(-1:-100)

# apperently the right choice
seq(-1,-100,-1)


# 4 
v <- c(-50:1000)
v[0:105*10+1] # idk man

v[v*10]

# apperently the right choice
seq(-50,1000,10) #-5:100*10

# 5 
v <- c(1:106) 
size <- length(v)/3
size <- ceiling(size)
size 
v <- v[0:(size-1)*3+1]
v


# apperently the right choice
seq(1,106,3) #3*0:35+1

# 6
?seq

# E ___________________________________
# 1 
l1 <- list(1, "a", T)

l1

# 2
l2 <- list(2, 3, 2, "banana", 1:10)
l2


# 3
l1[2] <- "A"
l1[2]

# 4
l3 <- c(l1, l2)
l3

l3.2 <- list(l1, l2)
l3.2
# c is superior yes yes, maybe no, more likely yes

# 5
l2[[5]][4]


# 6
l4 <- list("beer", 4.3, l1, "KOPER", l2)
l4


# 7
l4[[3]][[1]] <- -1
l4


# 8
l5 <- list(4, 5.3, 1.4, 0, -3, 3, 3)
sum(unlist(l5)) # changes from list to vector

sum(l5)


# F _______________________________________

# 1
# first we need the vector values
m1 <- matrix(1:9,3)
m1

# if we do this bellow
matrix(1:9, 3, 9)
# there is not enough data to fill out the matrix
# so it gets recycled.

matrix(1:9,3, 8) # like this we get a warning, it still works but warning


# sol for first
m1 <- matrix(1:9,3)
m1

# but like this the rows and cols are 
# not in the right positions so we fix it:

# Transpose:
m1 <- t(m1)
m1

# The better way to do it, cuz probably
# uses less operations is the bellow one.
# with the byrow parameter.

# Specify a different parameter byrow:
m1 <- matrix(1:9, 3, byrow = T)
m1


m2 <- matrix(9:1, 3)
m2 


m3 <- matrix(1:4, 2, 6)
m3


# _ _ _ _ _ 
# 2 

sum(m1)
sum(m2)
sum(m1, m2)

# 3
m3
m3-10


# 4 
m1
m1*3

# 5
# we have functions rbind and cbind
?rbind
?cbind

cbind(m1, m2) # basically merges the cols, goes in width.

rbind(m1, m2) # merges the rows, goes in height.

rbind(cbind(m1, m2), m3)


# 6
m1^2

m1**2

# Matrix multiplication %*% 
m1 %*% m2 


# G ___________________________________
# 1
dim(m3)

# also we can find the dim of the rows or cols
nrow(m3)
ncol(m3)

# access the # of rows like this
dim(m3)[1]

# access the # of columns like this
dim(m3)[2]

# 2
m1
m1[2][1] 
m1[2][1] <- -1
m1

# tutorial
m1[2, 1] <- -2
m1


# 3
m2[,2]

m2[,2, drop = F] # drop = F keeps the matrix.


# 4 
m2[1:2, 1:2] <- 0
m2


# 5 
m1[-1,] <- 5
m1


# 6
m4 <- matrix(c("a", "b", "c", "d"), 2, byrow = T)
m4


cbind(m4, m3)
# everything changed to strings 



# a different way to write the matrix
matrix(letters, 2, 2, T) # same shit as above, just more efficient
