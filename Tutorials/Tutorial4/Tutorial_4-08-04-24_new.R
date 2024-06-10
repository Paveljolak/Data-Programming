# Tutorial 4 - 08/04/2024 


# Packages:
library("lubridate")
library("readxl")
library("tidyverse")



# Some stuff about lubridate:
today() %>% class
Sys.Date() # date
Sys.Date() %>% class

Sys.time() # datetime, displays as posix
Sys.time() %>% class

"1.1.2002" # character
"1.1.2002" %>% class


# ________________________________________________________
# A 

# 1
# What is today’s date?
today()  



# 2
# What month is it, by name?
today() %>% month() %>% month.name[.]

# OR 
today() %>% month(label = T, abbr = F, locale = "Slovenian")


# 3  
# What day of the week is it, by name?
today() %>% wday(label = T, abbr = F, locale = "Slovenian")
# NOTE: The week starts with Sunday for some reason. 
# Even if the locale is Slovenian.

  
# 4  
# Write the vector v1<-c("13.1.2021","3.Jan.2011","4 March 14") 
# and parse it into R as a date.

v1 <- c("13.1.2021", "3.Jan.2011", "4 March 14")
v1 %>% dmy() %>% class




# 5
# How many days have passed since 1.Feb.2020?
"1.Feb.2020" %>% dmy() %>% {today()-.} 

  
# 6  
# How many days are in this year?
"1.1.2024" %>% dmy() %>% {.+years(1)} # gives same thing
                                     # only one year later

"1.1.2024" %>% dmy() %>% {.+years(1)-.} # gives us time 
                                       #dif of two dates



# 7  
# Write a vector with names of the days of the week on Christmas day for the 
# years 2010:2019. Which years did Christmas fall on a workday?
"25.12.2010" %>% dmy() %>%
  {.+years(0:9)} %>%
  .[wday(.)>1 & wday(.)<7] %>% 
  year
  
# 8
# For years 2021:2121 find out which day in January we start
# school/work again (1:2 are holidays, and we cannot start on
# a weekend).
"03.01.2023" %>%
  dmy %>%
  {.+years(0:100)} %>%
  {.[wday(.)==1] <- .[wday(.)==1]+days(1);.} %>% 
  {.[wday(.)==7] <- .[wday(.)==7]+days(2);.} %>% wday

# Cleaned 1's and 7's


# ________________________________________________________
# B

# 1
# Parse the strings below into R as a date:
#   
#   dB1<-"April 5th 22";dB2<-"30.1.2020"; dB3<-"2/14/00";
#   dB4<-"2010-6-19"; dB5<-"4. Jan 1999"
  
B1 <- "April 5th 22"
dB2 <- "30.1.2020"
dB3 <- "2/14/00"
dB4 <- "2010-6-19" 
dB5 <- "4. Jan 1999"

B1 %>% class
B1 %>% mdy %>% class

dB2 %>% class
dB2 %>% dmy %>% class


dB3 %>% class
dB3 %>% mdy %>% class


dB4 %>% class
dB4 %>% ymd %>% class

dB5 %>% class
dB5 %>% dmy %>% class
  

# _____________________________________________________
# Some lubridate stuff:
paste(letters, "= %", letters, ", ", LETTERS, "= %", LETTERS, sep="") %>% 
  paste(collapse = ", ") %>% format(today(), .)

# _____________________________________________________



# 2
# Format the above dates, such that each date appears in 
# the format of the next string(write dB1 in the format of 
# dB2, the format of dB3, dB3 in dB4, dB4 in dB5)
B1 %>% mdy() %>% format("%d.%m.%Y")

dB2 %>% dmy %>% format("%m/%d/%y")  

dB3 %>% mdy %>% as.character()
# Alternative
# format("%Y-%m-%d")

dB4 %>% ymd %>% format("%d. %b %Y")

"4. Jan 1999" %>% dmy() # skipping the last one


# 3
# Import "Sample - Superstore.xls"
# into R and add the column “Order delay”, which tells us 
# how many days passed between the order and shipping dates.
dir(recursive = T, pattern="Sample") %>% read_excel -> store


store %>% {as.Date(.$`Ship Date`) - as.Date(.$`Order Date`)}
# We convert them from posix into date types. So we do not
# get the solution back in seconds, and we get it back into
# days. 



# Another option is to use the function difftime
store %>% {difftime(.$`Ship Date`, .$`Order Date`, units = "days")}


# difftime -> takes two datetimes and gives the difference 
# between them. We can specify the units.
store %>% {difftime(.$`Ship Date`, .$`Order Date`)}
# by default is in seconds.


# Solution:
store$`Order Delay` <- store %>%
  {difftime(.$`Ship Date`, .$`Order Date`, units = "days")}

store$`Order Delay` %>% head
# ________________________________________________________
# C

# 1
# Parse "2009-1-14 18:30:00" into R as a date.

"2009-1-14 18:30:00" %>% ymd_hms() %>% as.Date %>% class
  
# Alternative
# regex
# [^ ] -> any single character that is not space -> " "
# ^a  means it starts with a
# a* matches to "" "a" "aa" "aaa" ...
"2009-1-14 18:30:00" %>% str_extract("^[^ ]*")
"2009-1-14 18:30:00" %>% strsplit(" ") %>% {.[[1]][1]}

# Alternative:
"2009-1-14 18:30:00" %>% str_remove(" .*")


# 2
# Split "24.10.1999" into a vector with numbers 24,10 in 1999.
"24.10.1999" %>% str_split("\\.") %>% unlist
# since "." means end character. We put two "\\" on it
# so we tell it, split on the "." and not see it as 
# an end character.

# Alternative:
"24.10.1999" %>% dmy() %>% {c(day(.), month(.), year(.))}

# Difference between the two is: one of them is 
# vector of strings, one of them is vector of numerics
# we can use as.character or as.numeric to switch to
# whichever we would like.


# 3
# Parse "9:15:00 5 Jan 2020" and "1/1/2017 9:15" into R
# as dates.

"1/1/2017 9:15" %>% dmy_hm %>% as.Date() %>% class

# non space multiple times then space
"9:15:00 5 Jan 2020" %>% str_remove("^[^ ]* ") %>% dmy()


# Alternative for datetime:
# We have to rearange the vector:

"9:15:00 5 Jan 2020" %>% 
  strsplit(" ") %>%
  unlist() %>%
  {c(.[-1], .[1])} %>%
  paste(collapse=" ") %>% 
  dmy_hms() %>% as.Date

# ________________________________________________________
# D

# 1
# How many characters and how many words are there in the 
# national anthem of Slovenia?

hymn <- "Zive naj vsi narodi
ki hrepene docakat dan,
da koder sonce hodi,
prepir iz sveta bo pregnan,
da koder sonce hodi,
prepir iz sveta bo pregnan,
da rojak
prost bo vsak,
ne vrag, le sosed bo mejak."

# To display purposes, we can use cat function.
# NOTE: this is only for display purposes.
hymn %>% cat


# Split it into words, then unlist it since we 
# got a list, then take the length from the vector.
hymn %>% str_split(" ") %>% unlist %>% length

# In the solution above we forgot the new lines. 
# so we will get multiple words in the same strings
# that we would like to have split:
hymn %>% str_split(" |\n") %>% unlist %>% length

# Alternative
hymn %>% strsplit(" |\n") %>% unlist %>% length

# Alternative 2:
# Count spaces and new line characters. And add +1
# since there is one less than the ammount of words.
hymn %>% str_count(" |\n") %>% {.+1}


# 2
# Import word.txt from e-classroom and find words, that
# contain the sequence "age". How frequently do letters
# a-z appear? Sort them by frequency.
"DataTutorial/word.txt" %>% read.csv -> words
words %>% .[grep("age", .[,1]), ] 


# Frequency:
# We want to break every word, to a single character.
# Don't forget to take the first column, since words 
# is a dataframe.
# Then we unlist it to turn it into a vector,
# then we turn it into a factor, and we summarize at the end
# to get the count of every letter.
words$X2 %>% strsplit("") %>% unlist %>% factor %>% summary

# Alternative:
# We count how many a and A appear inside the column
# with str_count
"a|A" %>% str_count(words$X2, .) %>% sum

# Unfourtenately with the function above we cannot
# put a whole vector, what we can do is this:
paste(letters, LETTERS, sep="|") %>%
  sapply(\(x){x %>%
  str_count(words$X2, .) %>%
    sum}) %>% .[order(-.)]
# function(x){}
#\(x){} only works with R>=4

# 3
# In the Superstore dataframe add a column named "C.N.",
# which contains the initals from the first and last name
# of customers in "Customer Name" (example: 
# "John Fitzgerald Kennedy"→"J.K.")

str_sub("abcd", 1, 1) # str_sub -> takes a string
                     # from some index, to another
str_sub("123456", 2, 5)


store$`Customer Name` %>% strsplit(" ") %>% sapply(\(x){
  paste(str_sub(x[1], 1, 1),".",str_sub(x[length(x)],1,1),".",sep="")})->store$C.N.


