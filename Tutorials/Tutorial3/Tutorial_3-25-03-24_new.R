# Tutorial 3 - 25/03/2024


# Packages:
library(tidyverse)
library(readxl)
library(writexl)

# _____________________________________________________
# A 

# 1
# Create a new folder “DataTutorial” inside a new or 
# existing R project. Download and export files that 
# follow inside this folder.

# Navigate with 
# getwd
# setwd

# Create the folder:
dir.create("DataTutorial")

# Put the files inside the folder, 
# and check if they are there:
dir("DataTutorial")




# 2
# Import the file file_example_XLS_50.xls from e-classroom
# into R. Skip the first two rows.

# set the directory with setwd() command
"DataTutorial/file_example_XLS_50.xls" %>%
  readxl::read_excel(skip = 2) -> df1
df1


"DataTutorial/data.csv" %>% 
  read.csv() -> df2

# 3
# Import the file
# https://datahub.io/core/country-list/r/data.csv into R,
# then export it into the folder “DataTutorial” as .xlsx.

df2 %>% writexl::write_xlsx("DataTutorial/Data.xlsx")



# 4
# Check in which directory we are currently in and which 
# files are in your working directory.
getwd()
dir(recursive=T)


# _____________________________________________________
# B

# 1
# Import time_series_covid19_confirmed_global.csv from the
# web page 
# https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases
# into R.

# We can read directly from the web:
"https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv&filename=time_series_covid19_confirmed_global.csv" %>% 
  read.csv() -> dfcovid

# OR download it manually and read it from our machine:
"DataTutorial/time_series_covid19_confirmed_global.csv" %>% 
  read.csv() -> dfcovid
  

dfcovid %>% dim()
dfcovid %>% tibble()

# 2
# Find the (cumulative) number of confirmed infected in 
# Slovenia in the last week and save it into a .csv file.
dfcovid %>% .[.$Country.Region == "Slovenia", 
              c(1:4, ncol(.)-6:0)] %>% write.csv("DataTutorial/covidSlo.csv")

dir(recursive = T)


# 3
# What was the global number of confirmed infected 
# yesterday?

dfcovid %>% .[,ncol(.)] %>% sum


# or we can find which ones are new from yesterday
# to today
# just new infected on the last day
dfcovid %>% .[,ncol(.)-1:0] %>% {.[,2]-.[,1]} %>% sum()


  
# 4
# Return the countries and the confirmed infected amount
# for yesterday and save it into a .csv.gz file.

# For the purposes of the tutorial, yesterday is the last
# column
dfcovid %>% .[,c(2, ncol(.))] %>% write.csv(gzfile("DataTutorial/CovidGlobal.csv.gz"))


# R can read without decompressing gz first.
"DataTutorial/CovidGlobal.csv.gz" %>% read.csv()

# _____________________________________________________
# C

# 1
# Import Slovene ZIP codes from
# http://download.geonames.org/export/zip/ into R
# (hint: tab \t)is the separator). Remove the empty columns.

# We can unzip a file directly from RStudio:
dir(recursive = T)
"DataTutorial/SI.zip" %>% unzip(list = T)
"DataTutorial/SI.zip" %>% unzip(exdir = "DataTutorial")
# exdir -> extraction directory.

"DataTutorial/SI.txt" %>% read.table(sep="\t") %>% .[,9] %>% unique()
# Until the 9th column there are empty columns.
# so we clean them.

"DataTutorial/SI.txt" %>% read.table(sep="\t") %>% .[,-4:-9]->dfZIP


# 2
# Return the column with town names, that contain the 
# letter “z”. What class is the result? How do we keep 
# it as a dataframe?
dfZIP %>% head
dfZIP %>% .$V3 %>% head
# grep, grepl, str_detect
grep("u", c("ananas", "cucumber", "potato", "tomato", "blue", "red"))
# grep gives us the positions of the words that contain the pattern,


grepl("u", c("ananas", "cucumber", "potato", "tomato", "blue", "red"))
# Grepl does the similar thing, just gives us the same length vector
# as the one we are scanning and gives true values where the pattern
# is found and false where the pattern is not found.


# regex: regular expressions.

dfZIP %>% .$V3 %>% .[grep("z",.)]
dfZIP %>% .$V3 %>% grep("z",.)


# If we want to keep it as a dataframe we omit the second step
dfZIP %>% .[grep("z", .$V3),1:3]
# and we get:


# 3
# Return the column with town names, that contain “h”
# or “H”.
dfZIP %>% .[grep("h|H", .$V3), 2:3]

# or 
dfZIP %>% .[grep("[hH]", .$V3), 2:3]



# 4
# Return the column with town names, that end with “r”.
dfZIP %>% .[grep("r$", .$V3), 3]
                                                                               
# 5
# Return the column with town names and ZIP codes for the
# coastal region (6000-7000). Save the result in a .txt 
# file also with the tab separator.
dfZIP %>% .[.$V2>=6000 & .$V2<7000,1:3]

# _________________________________________________________
# D

# 1
# Download Sample - Superstore.xls from the web page
# https://community.tableau.com/docs/DOC-1236 and import it in R.
dir(recursive = T)

"DataTutorial/Sample - Superstore.xls" %>% 
  read_excel(sheet = 1) -> dfstore

dfstore %>% head
  
  
# 2
# Return every hundredth row (100,200,300,…) and the first 7 
# columns. Export the result in a .xlsx file.
dfstore %>% .[seq(100,nrow(.), 100),1:7] %>% write_xlsx("DataTutorial/store.xlsx")

# 3
# Return the name of customers, without duplicates.
dfstore$`Customer Name` %>% unique

# 4
# Return the name of customers, without duplicates, that have 
# at least three names (first name, last name and another).
dfstore$`Customer Name` %>% unique %>% .[grep(" [^ ]* ",.)]



# 5
# Import also the second worksheet of the file
# Sample - Superstore.xls into R.
"DataTutorial/Sample - Superstore.xls" %>% read_excel(sheet = 2)



                                                  