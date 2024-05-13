# Tutorial3 - 18-03-2024 and some at 25-03-2024

# Libraries that we need:
library("readxl")
library("writexl")
library("tidyverse")

# A _________________________________________________
# 1
getwd()

# This will set up our
setwd("[Path to your data director here.]")

getwd()


dir.create("DataTutorial")

dir(recursive = T)

# 2
"file_example_XLS_50.xls" %>%
  read_excel(skip = 2) -> df1

# We can skip rows by writing skip = [amount we want to skip]

df1

# 3 

"data.csv" %>% read_csv -> df2
df2


df2 %>% write_xlsx("Data.xlsx")

"Data.xlsx" %>% read_excel 

# 4
getwd()
dir()
?dir

# B _________________________________________________________
# 1
"https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv&filename=time_series_covid19_confirmed_global.csv" %>%
  read.csv() -> dfcovid


dfcovid %>% .[1:6,1:6]
dfcovid %>% tibble

# 2

dfcovid %>% .[.$Country.Region=="Slovenia", 1:5]
# This means: dfcovid[dfcovid$Country.Region=="Slovenia", 1:5]


dfcovid %>% .[.$Country.Region=="Slovenia", c(1:4, ncol(.)-6:0)]
# basically ncol(.) gets the number of columns which is 1147
# then -6:0 it will give us. 1147-6:0 which will be 1141:0
# This will generate the indexes of the last 7 columns
# So given the full thing: c(1:4, ncol(.)-6:0) we will get 
# the first four and the last seven.

dfcovid %>%
  .[.$Country.Region=="Slovenia", c(1:4, ncol(.)-6:0)] %>% 
  write.csv("CovidSlo.csv")

dir()
dfcovid %>% .[,ncol(.)] %>% sum
# basically ncol(.) in this case is:
# ncol(dfcovid)


# 3

dfcovid %>% .[,ncol(.)-1:0] %>% {.[,2]-.[,1]} %>% sum

# the { } is for operators like "-" 
# They interfere with the pipe so we have to enclose them
# so the pipe doesn't get confused.


# 4

# just the new infected on the last day
dfcovid %>% .[,c(2,ncol(.))] %>% write.csv(gzfile("CovidGlobal.csv.gz"))

# gz is like a zipped file.
# Usually in zipped files you can have multiple files.
# In gz we only have one file. gz is a compression of one file.


# If we check the files, we can see that the gz file takes
# less space on the disk, than if we extract it.



# R can read gz files without decompressing them.
"CovidGlobal.csv.gz" %>% read.csv %>% head

# C ______________________________________________________
# 1
dir()

"SI.zip" %>% unzip(list = T) # we get a dataframe from the files in the zip
?unzip
"SI.zip" %>% unzip()
dir()

# we can also specify a directory where we want to unzip
# by specifying a path like this:
# "SI.zip" %>% unzip(exdir = "DataTutorial)

# the "SI.txt" data is a tab separated data file
# shortcut also tsv
# we read it like this:

"SI.txt" %>% read.csv(sep="\t")
"SI.txt" %>% read.delim(sep="\t")
"SI.txt" %>% read.table(sep="\t")


# we will for now use read.table
"SI.txt" %>% read.table(sep="\t")


"SI.txt" %>% read.table(sep="\t") %>%
  .[,-4:-9] -> dfZIP

dfZIP %>% head # zip codes of towns

# 2
dfZIP %>% .$V3 # we need to look at this column

# and also look at this functions
# grep, grepl, stringr::str_detect()


# GREP
grep("Pattern", c("ananas", "cucumber", "potato", "tomato"))
?grep


# when using grep we specify a pattern, and then
# we specify the string, or the vector of strings
# that we want to find the pattern in

grep("s", c("ananas", "cucumber", "potato", "tomato", "red", "blue"))
# since there is "s" only in the first string we get result: 1

grep("u", c("ananas", "cucumber", "potato", "tomato", "red", "blue"))
# since there is "u" in the second and sixth string we get result 2 6


# GREPL
# basically grep logical
# instead of indexes we get true false vectors at the end
grepl("u", c("ananas", "cucumber", "potato", "tomato", "red", "blue"))


# to continue with the task:
dfZIP %>%
  .$V3 %>% 
  .[grep("z",.)]

# if we put the grep inside subsetting
# instead of getting the positions back
# we will get the actual values of those positions


dfZIP %>% 
  .[grep("z", .$V3),]

  

# 3
dfZIP %>% 
  .[grep("h|H", .$V3), 2:3]
# values that have "h" or "H"

dfZIP %>% 
  .[grep("[hH]",.$V3), 2:3]
# values that have "h" or "H"

# "|" means OR
# "$" means END
# "^" means START



# 4

dfZIP %>% 
  .[grep("r$",.$V3), 2:3]
# values that end with "r"


dfZIP %>% 
  .[grep("^K",.$V3), 2:3]
# values that start with "K"




# 5

dfZIP %>%
  .[.$V2>= 6000 & .$V2<7000, 1:3]


dfZIP %>%
  .[.$V2>= 6000 & .$V2<7000, 1:3] %>% 
  write.table("coast.tsv", sep="\t", row.names = F)


# D ___________________________________________
# 1

grep("Sample - Superstore.xls", dir(),)

?grepl
dir() %>% .[grepl("Sample - Superstore.xls", dir())] # checking if the file is there.


"Sample - Superstore.xls" %>% read_excel() # will read the excel
"Sample - Superstore.xls" %>% excel_sheets() 
# since there are multiple sheets in a single excel file,
# the excel_sheets will give the names of all of the sheets
# inside the excel file.

# with read_excel() we read the first sheet by default

# to choose which sheet we want to read, we write it like this
# read_excel(sheet = 2) 


# let's work with the first one:
"Sample - Superstore.xls" %>%
  read_excel(sheet = 1) -> dfstore

dfstore %>% head

# 2
dfstore %>%
  .[seq(100, nrow(.), 100),1:7] %>% 
    write_xlsx("store.xlxs")
# when using the seq() function
# we have to provide lower bound, upper bound, and the jump
# in our case we will start from 100, go to the number of rows
# and then jump by 100



# 3
dfstore$`Customer Name`

dfstore$`Customer Name` %>% unique

dfstore$`Customer Name` %>%
  unique %>% 
  .[grep(" [^ ]*",.)]


 