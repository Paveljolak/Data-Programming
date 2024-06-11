# Tutorial 8 - 06/05/2024


# Packages:
library(tidyverse)


# Solve by only using chains of pipe operators
# %>% to pass along dataframes and appropirate
# dplyr functions. Some of the appropriate dplyr
# functions: mutate, filter, group_by, summarise,
# select, arrange, rename, summarize, top_n, 
# slice_max, sample_frac, slice_sample, ungroup,
# drop_na


# _____________________________________________
# A
# In the dataframe airquality solve independently:

# 1
# Show the rows without NA and the last 4 columns
airquality %>% 
  .[,4:0] %>% 
  na.omit

# Checking for NA values
# We can do it in multiple ways, 
c(1, 2, NA) %>% sum(na.rm = T)
is.na(3)
is.na(NA)

# NA == NA

# We can use the drop_na function
airquality %>% drop_na
# this delete rows as well.

# So we can keep the rows, and just remove the na value
airquality %>% filter(!is.na(Ozone)) %>% select(ncol(.)-3:0) 
# We keep all not na values in ozone

# We can essentially do the same thing with:
airquality %>% .[!is.na(.$Ozone), ncol(.)-3:0]



# 2
# Show 1/15th of the rows and only columns 
# containing the letter “o”.
airquality %>% {.[1:floor(nrow(airquality)/15),grep("o", colnames(.))]}


# Alternative:
airquality %>% .[sample(1:nrow(.),floor(nrow(.)/15)), grep("o|O", colnames(.))]
# It is better since we will have a random 1/15 and not
# just the first one.


# Alternative
airquality %>% sample_frac(1/15) # for rows

select # for selection of columns
?select

airquality %>% sample_frac(1/15) %>% select(contains("o"))


# OR
airquality %>% slice_sample(prop=1/15)

# 3
# Add a new column, that shows temperature 
# in Celsius and then show the max, min and 
# average temperature.
airquality %>% head
?airquality

# The Temp column shows the temp in
# F 
# We need to change it to C 
# The formula is: °C = (°F - 32) × 5/9

airquality$celzius <- 1
airquality <- -airquality[,colnames(airquality["celzius"])]
airquality %>% {.$celzius}

airquality %>% head
# Deleting a column from the dframe
airquality <- airquality %>% select(!contains("celzius")) 

# solution 
airquality %>% {.$Celsius <- (.$Temp - 32) * 5/9;.} %>% head



# New way to add a column to the dataframe is to
# use the function mutate:
airquality <- airquality %>%
  mutate(Celsius=(Temp - 32) * 5/9) %>%
  head

# Now we can find the max, min, etc. 
airquality %>%
  {c(max=max(.$Celsius),
     min=min(.$Celsius),
     mean=mean(.$Celsius))}

# For dplyr we have the function summarise
airquality %>% summarise(max=max(Celsius),
                         min=min(Celsius),
                         mean=mean(Celsius)) 





# Find the safest and the most dangrerous
# day to sunbathe.

# The safest would be the minimum radiation
# Most dangerous would be maximum radiation


airquality %>% filter(Solar.R==min(Solar.R, na.rm = T) |
                      Solar.R==max(Solar.R, na.rm = T)) %>% 
  .[1,]
# we then choose it with the .[1,]



# _____________________________________________
# B
# In the dataframe mtcars:
 
# 1
# By using rownames_to_column() add the rownames 
# into a column names “Type”, save the new 
# dataframe and from now on use the new one.
mtcars %>% {.$Model <- rownames(.);rownames(.) <- NULL;.}


# we can also use this rownames_to_column() function
# it will give us the column of rownames as the first
# column
df <- mtcars %>% rownames_to_column("Type")
# Inside the "" we specify the name of the column


df %>% head


# 2
# How much horsepower do the Mercedes brand
# cars have on average?
df %>% filter(grepl("Merc", Type))
# Since filter is not accepting indices
# we are using grepl. So we get the logical values
# back.

df %>% filter(grepl("^Merc", Type)) %>%
  summarise(mean(hp))

# First we grab all the mercedes cars, then
# we summarise them -> use the mean function on the
# horsepower.



# 3
# Count how many cars come in 4, 6 and 8 cylinders.

# We can use a factor to find out this information
# We pull only the cyl column, then we make it 
# a factor and at the end we use summary
df$cyl %>% factor() %>% summary()


# Alternative: group_by

# we say group_by cyl and then we do an operation
# that we want to be done by group. In this case
# the mean operation on the hp.
df %>% group_by(cyl) %>% summarise(mean(hp))
# the function above will give the average of the 
# horsepower per cylinders

# if we want to count we use summarise(n())
df %>% group_by(cyl) %>% summarise(n())


# We can also do this
df %>% group_by(cyl) %>% summarise(length(mpg))
# It's the length of any column can work.


# 4
# return the min and max value for each 
# numerical column.
df %>% sapply(class)

# Basically we will use the function 
# select_if 
# It is the same as the function select,
# it selects column, but only if they satisfy 
# the condition given inside the if
df %>% select_if(is.numeric)
# In this case we select if the column is numeric.
# And we will get back all the columns that are numeric

# Then we can do this:
df %>%
  select_if(is.numeric) %>% 
  summarise_all(min)
  
df %>%
  select_if(is.numeric) %>% 
  summarise_all(max)


# To connect these two into a single function 
# we can use sapply on a custom function:
df %>%
  select_if(is.numeric) %>% 
  sapply(\(x){c(min=min(x),max=max(x))})


#  Alternative:
# We can directly use the summarise_if function
df %>% 
  summarise_if(is.numeric,\(x){c(min=min(x), max=max(x))})


# _____________________________________________
# C
# In the dataframe USArrests

# 1
# How many states are there in the USA?
USArrests %>% length

# Alternative
USArrests %>% summarise(n())

# OR
USArrests %>% nrow

# OR
USArrests %>% dim() %>% .[1]
  
# 2
# Which are the top three most dangerous states
# in each of the arrest categories?

USArrests %>% .[order(-.$Murder),] %>% head(3)
# This way we can see the top 3 countries for murder
# But there are some ties. Countries with the same
# murder rate or similar.

# So we use the following function:
# top_n
USArrests %>% top_n(3, Murder)
# The difference between order and top_n
# Is that with top_n we get the ties as well
# Lets say we say give me top 1 country for murder
# but two countries share the top place, both of them
# will be returned.


# Slice max will give us the maximum of a specified
# column, and it will return n specified rows.
# ordered in a descending order
USArrests %>% slice_max(Assault, n=3)

# Of course slice_min will give us the minimum
# in an ascending order.
USArrests %>% slice_min(Assault, n=3)

# Difference between slice and top_n is that 
# slice orders the elements. top_n does not

USArrests %>% arrange(Assault) %>% head(3) # for min
USArrests %>% arrange(-Assault) %>% head(3) # for max

# with arrange if we have strings instead of column
# we cannot just slap a "-" infront to change the 
# order

# So we have to do something like this
USArrests %>% arrange(desc(Assault)) %>% head(3) 


USArrests %>% arrange(desc(Rape)) %>% head(3) 

# 3
# Sort the states based on the total number 
# of arrests from all three crime categories.
USArrests %>%
  mutate(TotalArrests=Murder+Assault+Rape) %>% 
  arrange(desc(TotalArrests)) %>% head(3)
  