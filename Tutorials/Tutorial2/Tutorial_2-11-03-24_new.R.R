# Tutorial 3 - 11/03/2024


# ______________________________________________
# A

# 1 Write m1 and df1
# Given in the tutorial
m1 <- matrix(c(1:9), 3, 3, byrow=T)
m1

df1 <- data.frame(A = c("Petar","Klavdija","Uros"), B = c("Mursic", "Kutnar", "Godnov"), C = c(T, F, T)) 
df1

# 2
# Rename the columns of matrix m1 with “column1”,
# “column2”, "column3” and rows with “row1”,
# “row2”,“row3”.

# You can grab the colnames like this:
colnames(m1)

# Then you can assign them like this:
colnames(m1) <- c("column1", "column2", "column3")
m1
# Or you can get them one by one like this:
colnames(m1)[1]
colnames(m1)[2]
colnames(m1)[3]


# You can assing a single colname like this:
# colnames(m1)[3] <- "thirdColumn"
# m1


# Same as columns we can do it like thisČ
rownames(m1) <- c("row1", "row2", "row2")
m1

# 3
# Rename “row2” z “mouse”.

rownames(m1)[2]

rownames(m1)[2] <- "mouse"
m1


# 4
# What value is the column “column3” and row
# “mouse”? Change that value to 100.

# You can find them as integer rows and columns:
m1[2, 3]

# Or we can do it directly by row and column names:
m1["mouse", "column3"]

m1["mouse", "column3"] <- 100
m1

# 5
# Change the values in the column “column2”
# to 10,11,12.

m1[, "column2"]

m1[, "column2"] <- c(10, 11, 12)
m1


# EXTRA:
m1[c(F, T, F), c(F, F, T)]
# You can grab values like this.
# It means:
# Do not include first row, include second row, 
# do not include third row
# And, do not include first column,
# do not include second column, and include
# third column.



# 6 
# In the dataframe df1 name the columns with 
# “Name”,“Surname”,“Gender”
df1

colnames(df1) <- c("Name", "Surname", "Gender")
df1

# Same as the matrix:
colnames(df1)[1]
df1[,"Name"]
df1[1]

# But for dataframes we can do something better.
# We can access cols like this:
df1$Name
df1$Surname
df1$Gender



# 7
# To dataframe df1 add a column “Year” with
# values 88,80,75, then add another row “Ademir”,
# “Hujdurovic”,TRUE,87.

# To add another column we just specify it 
# as it already exists:
df1

df1$Year <- c(80, 80, 75)

# To add some row, its a bit more complicated.
# We have to figure out how many rows we have.
nrow(df1)

# Now we want to add an empty row:
df1[nrow(df1)+1,] <- list("Ademir", "Hujdurovic", T, 87)
df1

# The difference between using list and c when assigning
# new rows, is that the list will keep the 
# types of the values. 
# And c will convert them. If there is a character type
# everything will be converted to character.
# This is because a vector can only have 1 type.

class("a")
class(1)

class(c("a", 1, T))


# ______________________________________________
# B

# 1
# Use the built in vector LETTERS or letters and
# make a vector v1 with values 1,2,3,…,26
# whose names are letters of the alphabet.
# What is the order within the alphabet of the
# vowels: “a”,“e”,“i”,“o”,“u”?
letters
LETTERS

v1 = 1:26

# For vectors we do not have columns and rows,
# We have the function names to set the names.
names(v1) <- letters
v1

v1[c("a", "e", "i", "o", "u")]

# Also we can do this the other way
names(v1[c("a", "e", "i", "o", "u")])





# # 2
# Make a list l1 with values m1,df1,v1,5 and names
# “matrix”,“dataframe”,“vector”,“number”.
 
l1 <- list(matrix=m1, dataframe=df1, vector=v1, number=5)
l1



# # 3
# In the list l1, change the value of “number”
# with 6.
l1$number <- 6
l1


# # 4
# Reverse the order of the elements in l1, then
# check the element in the first position.
rev(l1)[[1]]

# OR 
l1[4:1][[1]]

# # 5
# In the list l1 change the element named “vector” 
# by inserting in the 20th place another element
# named “sh” with value 19.5
l1_1st <- l1$vector[1:19]
l1_1st

l1_2nd <- l1$vector[end(l1_1st)[1]:end(l1$vector)[1]]
l1_2nd

l1$vector <- c(l1_1st, sh=19.5, l1_2nd+1)
l1$vector


# Better and easier way to do the previous function
l1$vector[1:19]
l1$vector[-1:-19]

c(l1$vector[1:19], sh=19.5, l1$vector[-1:-19]) -> l1$vector
l1$vector
l1

# # 6
# Show the first two rows of the dataframe
# “dataframe” inside the list l1.

l1$dataframe[1:2,]

# OR
head(l1$dataframe, 2)
# Show only 2 rows


# ______________________________________________
# C

# 1
# From the vector with values 1,2,3,1,2,3,2,0,3,4
# make a factor f1.

f1 <- factor(c(1, 2, 3, 1, 2, 3, 2, 0, 3, 4))
f1

# 2
# Which values appear in f1 and how many times does 3 repeat?
levels(f1)

# Summary tells us how many some element appears
summary(f1)["3"]



# 3
# Change all 2 to 6.

# We check the levels, find the position of 2
levels(f1)[3] <- 6
f1

# 4
# In what months was the data from the dataframe 
# airquality collected? Use the built in vector
# month.name to return the names of the months as well.
q4 <- factor(airquality$Month)
q4

names(month.name) <- 1:12
unique(month.name[levels(q4)])

# We can also convert the levels of q4 into itegers
month.name[as.integer(levels(q4))]

# OR 
month.name[unique(airquality$Month)]




# 5
# How many different number of cylinders do the cars
# from the dataframe mtcars have?
levels(as.factor(mtcars$cyl))

length(levels(factor(mtcars$cyl)))


# OR: 

length(unique(mtcars$cyl))
unique(mtcars$cyl)


# ______________________________________________
# D

# 1
# a lab they were testing the pH of 100 different 
# substances and they obtained the data 
#vpH<-runif(100, 0, 14). Factor the pH obtained based on
#the description from the table:
  
 # pH	  <3	    3-6	    6-8	    8-11    	>11
 #Desc	s.acid	w.acid	neutral	w.base	s.base

#How many strong acids are there?
vpH <- runif(100, 0, 14)
# runif(100, 0, 14)
# creates 100 values, between 0 and 14. 
# they are numeric uniformly distrubute values.
vpH


fpH <- cut(vpH, c(0, 3, 6, 8, 11, 14), labels = c("s.acid", "w.acid", "neutral", "w.base", "s.base"))
# Cut function will create intervals
# (0,3]
# (3, 6]
# .
# .
# (11, 14]
# ( -> The value is not included
# [ -> The value is included
summary(vpH)
summary(fpH)


# 2
#In a poll we asked 65 pedestrian how many children
# do they have and their answers were recorded in
# children<-sample(0:6, 65, replace=T). Factor the
# participants into 3 categories: 0,1,≥2. Add the order
# "0"<"1"<"≥2".

children <- sample(0:6, 65, replace=T)
# Replace = T -> Let's values repeat.

f2 <- cut(children, c(-1, 1, 2, 6), labels = c("0", "1", ">=2"), ordered_result = T) 

f2 > "1"
f2 > "0"


# 3
# Make a factor with 30 elements named “Coffee”,
# 30 elements named “Tea”, 30 elements named “Beer” 
# and 30 elements named “Juice”. Then shuffle them
# around in a random order. Finally reorder them back
# into alphabetical order.    
f3 <- 1:120
f3
f3 <- cut(f3, c(-1, 30, 60, 90, 120), labels = c("Coffee", "Tea", "Beer", "Juice")) 
f3
summary(f3)

# Easier way to do this is using the rep function
rep(2, 4)
rep(c(2, 4), 4)
rep(c(2, 5), c(4, 3))

f_3 <- factor(rep(c("Coffee", "Tea", "Beer", "Juice"), 30), ordered = T)
summary(f_3)
f_3

sample(f_3) %>% .[order(.)]


# ___________________________________________________

# We start using pipes from now on:

# There are two pipes:
# %>%  and |> 
# %>%  is tidyverse pipe
# this: |> is the base R pipe -> Basically you still need to 
# use parentheses with the base R pipe.
# So we will be using the tidyverse pipe.

sum(1:4)
1:4 |> sum() # bad pipe, almost useless
"dplyr" %in% installed.packages() # Checks if you have
# the package for the good pipe
library("dplyr") # the package for the good pipe
1:4 %>% sum() # same as sum(1:4)
1:4 %>% sum(.) # same as sum(1:4)
1:4 %>% {sum(.)+.} # {} prevent default behaviour of putting the argument
# inside the function

# without pipe
head(airquality, 2)

# with pipe
airquality %>% head(2)

# another way 
airquality %>% head(.,2)

# as well as:
2 %>% head(airquality, .) # period has to be in first level
# if it appears somewhere bellow, then it will not work
# and the default behavior will be called in the first

letters %>% .[c(3,2)]

# ___________________________________________________

# E

# 1
# Create a vector of 50 random names, each made of 5 
# letters, out of which only the first is capital. The
# first, third and fifth letters are consonants and the
# second and fourth are vowels.

# sets to be used: letters, LETTERS, sample, paste
letters
LETTERS
paste(LETTERS, letters, letters, letters, letters)

# Function paste, converts everything to character,
# then concatenates the vectors.

# We can separate on something else:
paste(LETTERS, letters, letters, letters, letters, sep="")

# the following function will give us a single vector
paste(letters, collapse = ".") 



# Positions of the vowels are:
# 1, 5, 9, 15, 21
letters[c(1, 5, 9, 15, 21)] # vowels
letters[-c(1, 5, 9, 15, 21)] # consonants

# 1 - E solved:
sample(LETTERS, 50, replace = T)
paste(sample(LETTERS[-c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[-c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[-c(1, 5, 9, 15, 21)], 50, replace = T),
      sep = "")






#2
# In the dataframe iris return only the rows of the 
# species “setosa”, with petal lengths less then 1.5cm.

  iris %>% str()
iris$Species %>% levels
iris$Species == "setosa"

iris[iris$Species == "setosa" & iris$Petal.Length<1.5,]

# We can do it like this using the pipe
iris %>% .[.$Species=="setosa",] %>% .[.$Petal.Length<1.5,]



# 3
# In the dataframe airquality return the rows with 
# temperature between 50 and 60.
airquality %>% .[.$Temp >= 50,] %>% .[.$Temp <= 60,] 

# 4
# In the dataframe airquality return the columns 
# “Wind”,“Day”,“Month” but only for the those entries
# with wind speeds over 15kmh.


# We will have to switch from mph to kmh. 
# Since it is easier to change a single value than many
# we will change only what we the 15 to 15/1.609
month.name 
names(month.name) <- 1:12
airquality %>% .[.$Wind < 15/1.609, ] %>% .[c("Wind", "Day", "Month")] 














