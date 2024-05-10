# Tutorial 2 - 11/03/2024 

# A ________________________________________
# 1 
m1 <- matrix(1:9, 3, 3, T)
m1


df1 <- data.frame(A=c("Petar", "Klavdija", "Uros"), B=c("Mursic", "Kutnar", "Godnov"), C=c(T, F, T))

df1


# 2 

rownames(m1) <- c("row1", "row2", "row3")
colnames(m1) <- c("column1", "column2", "column3")

rownames(m1)
colnames(m1)
m1


# 3
rownames(m1)[2] <- "mouse"
m1


# 4
m1["mouse", "column3"] 
# the value is 6

m1["mouse", "column3"] <- 100
m1


# Another way to access elements inside a matrix
# access by logical values
m1[c(F, T, F), c(F, F, T)]

# Basically we say in the first c
# don't show first row, show second row, don't show third row
# second c says: don't show first column, don't show second column, and show third column.

# 5
m1[,"column2"] <- 10:12
m1


# 6 
colnames(df1) <- c("Name", "Surname", "Gender")
df1

#Tutorails:
df1$Surname # this is simpler version of this
df1[, "Surname"]

# 7

colnames(df1)[4] <- "Year"
df1[,4] <- c(88, 80, 75)
df1

# Tutorials way to do it:
df1$Year<-c(88, 80, 75)
df1


# Gotta be carefull with dataframes, we have to 
# use lists instead of vectors, so we keep the types
# of the columns. Otherwise everything will become character
df1[4,] <- list("Ademir", "Hajdurovic", T, 87)
df1

class(df1$Year)
class(df1$Gender)
class(df1$Surname)




# B ________________________
# 1 

LETTERS
letters

v1<-1:26
names(v1) <- letters
v1

# Note: in vectors you only have names, no row or cols.

v1[c("a", "e", "i", "o", "u")]
# the order is ascending

# 2
l1 <- list(m1, df1, v1, 5)
names(l1) <- c("matrix", "dataframe", "vector", "number")
l1
l1$vector
l1$matrix

# names can also be added directly
# l1 <- list(matrix=m1, dataframe=df1, vector=v1, number=5)
# l1


# 3
l1$number <- 6
l1$number 


# 4
l1[4:1][[1]]


# 5
l1$vector 


# we need to cut the vector into two pieces
# insert sh in between and push the second part next
# first cut
l1$vector[1:19]
# second cut
l1$vector[-1:-19]

v1
l1$vector <- c(v1[1:19], sh=19.5, v1[-1:-19])
l1$vector


# 6
l1$dataframe[1:2,]


# Or also we can do it with head function
head(l1$dataframe, 2)
head(l1$dataframe, 3)


# C _________________________________________
?factor
# factor is a list of vectors.

# 1
f1 <- factor(c(1, 2, 3, 1, 2, 3, 2, 0, 3, 4))
f1
summary(f1)

# to be more clear
f2 <- factor(c("Male", "Female", "Male", "Female"))
f2
summary(f2)


# 2
levels(f1)
summary(f1)["3"]

# 3
levels(f1)[3] <- "6"
f1


# 4
datasets::airquality

# if we have the check in packages we dont
# need the "datasets::" as prefix
head(airquality)

airquality[1:6,]
# same shit above two

# check for each column in airquality for its class
sapply(airquality, class) 

# as we have learned until now
levels(factor(airquality$Month))

# since we get the values as characters and we want them
# as numeric values we use them like this
as.numeric(levels(factor(airquality$Month)))

# also we can use function unique
unique(airquality$Month)
# it also does not convert elements to characters.


month.name
month.name[1]
month.name[c(1, 2)]
month.name[unique(airquality$Month)]


# 5
datasets::mtcars

# or 

mtcars

# we can find more info for the built in dataframes
# with the following line
?mtcars


length(unique(mtcars$cyl))


library(tidyverse)
# this is a pipe %>% 
# its a way to write from left to write without jumping back and forth

# EXAMPLE:
mtcars$cyl %>% unique %>% length()



# D ___________________________________

# 1

vpH<-runif(100, 0, 14) 

# runif(100, 0, 14)
# give me a vector of length 100, 
# give random values between 0 and 14



vpH
d1 <- cut(vpH, c(0, 3, 6, 8, 11, 14), labels = c("s.acid", "w.acid", "neutral", "w.base", "s.base"))

summary(d1)["s.acid"]


# 2

children <- sample(0:6, 65, replace=T)

children %>% head

children %>% cut(.,c(-1,0,1,6))
# When writing like this, the . is children
# basically the dot is replaced with the 
# first argument, in this case its 'children'

d2 <- children %>% cut(.,c(-Inf,0,1,6), labels = c("0", "1", ">=2"), ordered_result =  T)

d2>0
d2[d2>0]



# 3
rep(2, 4) # repeat 2 four times
rep(c("a", "b"), 4) # repeat the vector "a", "b" four times

d3 <- factor(rep(c("Coffee", "Tea", "Beer", "Juice"), 30))


summary(d3)

summary(sample(d3))

sum(1:4)

1:4 |> sum()

# the pipe |> is the same as %>% but it needs
#  to be enabled. It comes with R. 
# NOTE: 

1:4 |> sum # this will not work

1:4 %>% sum # this will work

# this pipe |> requires the parentheses
# this one %>% does not. So it is better, but
# it requires the tiddyverse package.

airquality %>% head
airquality %>% head(2)
airquality %>% head(., 2)

2 %>% head(airquality,.)

# the . takes the first argument from the left side.
# if its somewhere bellow and not on the first level
# it will not be detected



# Now we want to order d3 alphabetically
sample(letters)

letters %>% sample %>% length # get the length of the letters

letters %>% sample %>% {print(.);.} %>% order()


v1 <- c("b", "c", "a")

v1[order(v1)] # order puts them in order from smallest to largest

# you can skip some part like this

c("b", "c", "a") %>% .[order(.)] # we don't even have to save it
# we automatically have it ordered


# so to solve the task
sample(d3) %>% .[order(.)]



# E __________________________________________
# 1 
letters
LETTERS
?sample
?paste

paste(LETTERS, letters, letters, letters, letters, sep = "")

# sep = "" - makes it so they dont have spaces inbetween.

paste(letters) # this will not glue a single vector together
# so we use collapse
paste(letters, collapse = "")
paste(letters, collapse = ".") # we can choose whatever we want in between


sample(LETTERS, 50, replace = T) 
# replace = T 
# this makes so the same letter appears more than once.

paste(sample(LETTERS[c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[-c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[-c(1, 5, 9, 15, 21)], 50, replace = T),
      sample(letters[c(1, 5, 9, 15, 21)], 50, replace = T),
      sep = "")

letters[c(1, 5, 9, 15, 21)] # vowels


letters[-c(1, 5, 9, 15, 21)] # consonants
            
      
    

# 2 

iris %>% str %>% head

iris$Species %>% levels

iris$Species == "setosa"

iris[iris$Species == "setosa" & iris$Petal.Length<1.5,]

# we can also do it like this:
iris %>% .[.$Species=="setosa",] %>% .[.$Petal.Length<1.5,]


# 3 
airquality %>% head
airquality[airquality$Temp >= 50 & airquality$Temp <= 60,]


# 4 
airquality[airquality$Wind>15/1.609, c("Wind", "Day", "Month")]
?airquality
# NOTE: You have to be careful with the metrics.
#       for this question we are asked kmh but we have mph.
# So we have to convert it.