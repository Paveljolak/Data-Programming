# Tutorial 10 - 20/05/2024


# Packages:
library(tidyverse)
library(readxl)
library(lubridate)



# ___________________________________________________
# Import the database from Excel:
dir(pattern = "Sports", recursive = T) -> filename

filename %>%
  excel_sheets() %>%
  sapply(\(x){read_excel(filename, sheet = x)}) -> L


# All of the excel sheets are into one file.

# ____________________________________________
# A


# 1
# dfA<-data.frame(Day=1:50,Infected=round(1.2^(1:50)))
# stores information about the cumulative total infected
# by day. Add a column that tells the number of new 
# infected each day.

dfA<-data.frame(Day=1:50,Infected=round(1.2^(1:50)))

# To find the new infected, we need to subract 
# today - yesterday. This might be a time extensive
# so we use a vector function for it

c(1, 4, 8, 10, 11, 20) %>% lead()
# lead -> we give a vector of length 6
# gives back the same length vector, 
# pushes everything 1 spot to the left, giving NA 
# at the end

c(1, 4, 8, 10, 11, 20) %>% lag()
# lag -> works the same way as lead, the only difference
# is the it pushes everything to the right
# giving NA value to the leftmost side.

c(1, 4, 8, 10, 11, 20) %>% diff()
# diff -> Gives a output vector with length of
# length(inputVector) - 1 and it gives the difference
# between second element and first, third and second,
# fourth and third, and so on until the end.


# So in our case we can use the diff function
  dfA$Infected %>%
    {c(dfA$Infected[1], diff(.))} -> dfA$NewInfected

  
  
  
# Peter's solution:
dfA %>% mutate(NewInfected2=c(NA, diff(Infected)))

# Alternative:
dfA %>% mutate(NewInfected=Infected-lag(Infected))
  
  

# 2
# In dfA reverse the row order, and then recalculate
# the number of new infected.
dfA %>% arrange(desc(Day)) %>% 
  mutate(NewInfectedReverse = c(-diff(Infected), Infected[length(Infected)])) -> dfA


# Peter's solution:
dfA %>% 
  arrange(desc(Day)) %>%
  mutate(NewInfected = Infected-lead(Infected)) 




# ____________________________________________
# B

# 1
# In L$Coaches unite() the first and last name into 
# one with a space in between.
L$Coaches

# we will use the function unite
# we provide a df and we tell it which columns
# we want to merge
L$Coaches %>% unite("Name", 2:3)

# By default the separator is "_" so we can change it
# to " "
L$Coaches %>% unite("Name", 2:3, sep = " ")
# unite will merge the specified columns into one
# and then delete the merged ones.


# To keep the previous columns it is better to just
# use mutate
L$Coaches %>% mutate(Name = paste(FirstName, LastName)) %>% .$Name



# 2
# In L$Teams seperate() the colors and return a
# column with unique colors and second column with
# the number of times it appears as a primary color
# and a third column with the number of times as 
# secondary. Use pivot_longer or gather.

?separate

L$Teams %>% separate(Colors, c("PrColor", "SeColor"))   
# by default separate separates columns into other columns
# on any non alpha numerical value. Or multiple of them


# Now we have to count colors:
L$Teams %>%
  separate(Colors, c("PrColor", "SeColor")) %>% 
  pivot_longer(3:4) %>% group_by(Color = value) %>% 
  summarise(PrCount = sum(name=="PrColor"), 
            SeCount = sum(name=="SeColor"), Total = n())



L$Teams$Colors

# ____________________________________________
# C

# 1
# For each team, return the birth year of the oldest
# player in it.
L$Teams %>% inner_join(L$Players, 
                       by=c("TeamID"="TeamID")) %>% 
  select(contains("name"), BirthDate) %>% 
  mutate(Year = as.numeric(str_remove(BirthDate, "^.+/"))) -> C1

C1 %>%
  group_by(Nickname) %>% 
  summarise(min(Year))

C1 %>% 
  group_by(Nickname) %>% 
  filter(min(Year)==Year)

# To mitigate the duplicates we have:
C1 %>% 
  group_by(Nickname) %>% 
  top_n(1, Year)


# Just find the oldest player:
C1 %>% 
  mutate(Date=mdy(BirthDate)) %>% 
  select(1:3, 6) %>% 
  group_by(Nickname) %>% 
  top_n(1, desc(Date))
  


# 2
# Separate the address from L$Players into three
# columns, the first with the number, second with names
# (can be muliple) and the third with the type of road 
# (road,drive,lane, …).

# Cut it to playerId and address so they fit nicely on screen
L$Players %>%
  select(ID=PlayerID, Address) %>% 
  separate(Address, c("a", "b", "c", "d"))


# separate(Address, c("a", "b", "c")
#  This will give problem that some information is lost.
# This is because there are some addresses with 3 elements
# and some with 4.


# separate(Address, c("a", "b", "c", "d"))
# And for this one, the separate default separator,
# thinks the last dot is a separator and it treats it as such
# So we have to change the separator

L$Players %>%
  select(ID=PlayerID, Address) %>% 
  separate(Address, c("Num", "b"), sep=" ", 
           extra = "merge") %>% 
  separate(b, c("c", "d", "TypeOfRoad"), sep=" ",
           fill="left") %>% 
  unite("Rest", c:d, sep=" ", na.rm = T)




# ____________________________________________
# D

# 1
# Change the lines with sapply() in the Intro with an
# appropriate/similar map family function.

# The purpose of D is to look at the map function.
# map is essentially the same as mapply

# Hence we are skipping this one.




# 2
# Show the first 2 lines of each dataframe in the 
# list L.
L %>% lapply(head)

L %>% lapply(\(x){head(x, 2)})

L %>% lapply(head, 2)

# Map does essentially the same:
L %>% map(head, 2)


# 3
# In the dataframe L$Games, calculate the arithmetic
# mean of each numeric column. Aftewards, also calcualte
# the time difference between the oldest and newest day.
# Hint: lubridate::is.timepoint()/lubridate::is.POSIXct()
L$Games %>% 
  summarise_if(is.numeric, mean)
# But this solution deletes the information regarding 
# the dates.

# So we will use the map_if function:
L$Games %>% 
  map_if(is.numeric, mean) %>% 
  map_if(is.POSIXct,\(x){as.numeric(max(x)-min(x))}) %>% 
  unlist

# Since everything is numeric, we can do unlist to get 
# a vector.


