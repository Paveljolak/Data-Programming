# Tutorial 5 - 15/04/2024

# Packages:
library(tidyverse)


# ________________________________________________
# something about functions:
# function(x,y){} -> nameoffunction


# short notation:
# \(x,y){}  -> requires R > version 4

# _____________________________________________

# ____________________________________________________
# A

# 1.
# Create a function that given a positive n, it returns
# its factorial n! = n*(n-1)*...*2*1 (don't use built in
# factorial function).

# This is a way you write functions:
# function(of n) that does something " {} "
fac2 <- function(n){prod(1:n)}


# We can shorten the function word to -> \
fac2_short <-\(n){prod(1:n)}

fac2_short(5)

# We can also do it with a recursion:
# We need if-else:
if(T){3}else{"laptop"}
if(F){3}else{"laptop"}
# Another version of if-else:
ifelse(T, 3, "laptop")
ifelse(F, 3, "laptop")

# The beauty of this ifelse, is that we can 
# place a vector of true's and false's 
ifelse(c(T, F, F), 3, "laptop")
# And receive a vector back.

# NOTE: With the first if else we cannot do this.



# 2.
# Also try the factorial as a recursion:
# f(n) = 1 if <= 1 or n*f(n-1) otherwise
fac3_recursive <-\(n){ifelse(n<1, 1, n*fac3_recursive(n-1))}

fac3_recursive(5)



# 3. 
# Write a function given an input x, it checks whether x
# is a positive integer and returns TRUE if it is and FALSE
# otherwise. (TRUE: 4, 1.0 FALSE: 0, -2, 3.4)
is_positive3 <-\(x){ifelse(x>0, T, F)}

is_positive3(3)
is_positive3(-4)
is_positive3(0)

# Note we need to check if its valid integer also:
is_natural <-\(x){x>0 & (x==floor(x))}

is_natural(3)
is_natural(3.1)

c(4, 1.0, 0, -2, 3.4) %>% is_natural


# We can make it work with detecting which type the input
# is:
is_natural <-\(x){ifelse(is.numeric(x), x>0 & (x==floor(x)), F)}
# But this breaks the input of vector now. So we change it
# like this:
is_natural <-\(x){ifelse(sapply(x, is.numeric), x>0 & (x==floor(x)), F)}
# This works since vectors can be of one type.

# 4.
# Apply the above functions on vectors.

# Recursive version on a vector:
-1:5 %>% fac3_recursive

# First version on a vector:
-1:5 %>% fac2_short
# We can see that the first one does not work for 
# vectors

# We can use apply function in this case:
-1:5 %>% sapply(fac2)

-5:5 %>% is_positive3

-5:5 %>% is_natural
c(4, 1.0, 0, -2, 3.4) %>% is_natural

# ____________________________________________________
# B

# 1
# Create a function incircle with arguments x and y, that
# returns TRUE if the point (x,y) lies in or on the unit
# (radius=1) circle around the origin (0,0), and is FALSE
# if it does not.

# Basically this is for a squar:
incircle <-\(x, y){ifelse(x<= 1 & x>=-1 & y<= 1 & y >= -1, T, F)}

incircle(1, 2)
incircle(-4, 0.1)
incircle(-1, 0.1)
incircle(-1, -1.1)

# To find the circle we do this:
-5:5 %>% plot(.,.)
# Explicit plot is of the form plot(x, f(x))
seq(-1, 1,0.01) %>% plot(.,sqrt(1-.^2), type="l")
seq(-1, 1,0.01) %>% plot(.,-sqrt(1-.^2), type="l")
#x^2+y^2=1^2 -> y=sqrt(1-x^2)


# Parametrized plot is of the form plot(x(t), y(t)) for 
# some vector t.  
seq(0, 2*pi, 0.1) %>% {plot(cos(.), sin(.), type="l")}

incircle <-\(x, y){x^2+y^2<=1}

  
# 2
# Apply this function to vectors x<-seq(0,1,0.1); y<-x
x <- seq(0, 1, 0.1); y<-x
x
y
points(x, y)
incircle(x, y)


# 3
# Create a function nrt with arguments x and n that
# calculates x-th root of n if n is specified and x-th √ if n it 
# is not specified.
nrt <-\(x, n=2){x^(1/n)}

nrt(8, 3)
# If we do not provide a second argument
# by default is 2.
nrt(4)


# ____________________________________________________
# C 

# 1
# Write a function that given a numeric matrix it returns 
# a vector containing the minimums in each column.

m1 <- 1:12 %>% sample %>% matrix(3, 4)
m1 %>% min
# It only gives us the minimum for the whole matrix

# apply
# sapply -> Flexible with output.
# lapply -> returns a list
# mapply -> for multiple parameters
# tapply -> for aggregation

?apply
# a vector giving the subscripts which the function
# will be applied over. E.g., for a matrix 1 indicates
# rows, 2 indicates columns, c(1, 2) indicates rows
# and columns. Where X has named dimnames, it can be
# a character vector selecting dimension names.
m1 %>% apply(2, min) # minimumns of the columns
m1 %>% apply(1, min) # minimumns of the rows
m1

# In the task we need the minimum by columns:
minimums <-\(m){m %>% apply(1, min)}
minimums(m1)

  
# 2
# Write a function that given positive integers nrow,ncol
# and nmines, creates a nrow × ncol matrix with nmines
# elements equal to TRUE and rest are FALSE at random 
# locations. If nmines is not specified then set 1/5 of 
# the elements to be TRUE. Add an if check that displays
# a message if input does not make sense and returns NaN.

minesweeper <-\(nrow, ncol, nmines=round(nrow*ncol/5)){
    rep(c(T,F), c(nmines, nrow*ncol-nmines)) %>% 
    sample %>% matrix(nrow, ncol) %>%
    tryCatch(error=\(x){message("Input is nonsense");NaN})
}


minesweeper(4, 4, 3)

#  NOTE: You have to round the value of nrow*ncol/5 so you get
# full integer value. Otherwise it is not going to work.
minesweeper(3, 4)
minesweeper(3, 4, 5)

# NaN
minesweeper(3, -4)
minesweeper(3, 4, -5)
minesweeper(-3, 4, 5)


# We can print messages like this:
message("This")
warning("This")
print("This")

# ____________________________________________________
# D  

# 1
# Write a function aggregate2, with an input vector,
# dataframe and a function. The datamaframe rows match
# the length of the vector, which contains repeated names.
# The function merges the rows in the dataframe that
# have a matching name in the input vector. The value 
# for the merged rows should be the input function 
# applied to the respective row values. 
# (hint: tapply and apply).

iris %>% str()
?tapply
tapply(1:10, rep(c("a", "b"), 5), sum)

1:10 %>% {names(.)<- rep(c("a", "b"), 5);.}

tapply(iris[,1], iris[,5], mean)
sapply(iris[,-5],\(x){tapply(x, iris[,5], mean)}) 

aggregate2 <-\(v, d, f){sapply(d,\(x){tapply(x, v, f)})}

aggregate2(iris[,5], iris[,-5], mean)



mtcars %>% rownames %>% str_remove(" .+") %>% aggregate2(mtcars, mean)

# 2
# Write a function translate that, given an input 
# string s and a dataframe containing two columns 
# with strings, it substitutes all words in s that
# appear the first column of the dataframe to the
# ones in the second column.


df<-data.frame(From=c("colour","lift","centre"), To=c("color","elevator","center"),stringsAsFactors=F)
s<-"In the centre of the lift there was a banana"


translate<-\(s, df){
  s %>% str_split(" ") %>% unlist -> temp
  temp %>% {sapply(df[,1],\(x){x==.})} %>% 
    apply(1,\(x){df[x,2]}) %>%  
    mapply(\(x,y){if(length(x)==0){y}else{x}},.,temp) %>% 
    paste(collapse=" ")
}

translate(s, df)


