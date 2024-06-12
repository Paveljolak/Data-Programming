# Tutorial 9 - 13/05/2024


# Packages:
library(tidyverse)
library(readxl)
library(lubridate)



# Import the SportsDatabase.xlsx database from Excel
filename <- dir(pattern="Sports", recursive = T)  
#easiest to find it like this with dir

filename %>%
  excel_sheets() %>% 
  sapply(\(x){read_excel(filename, sheet=x)}) -> L
# The function above will read all of the excel
# sheets, and give them into L as a list of
# dataframes, which can be further accessed with
# $ 


# Just like this
L$Coaches

L$Coaches$FirstName
  
# We can even use sapply to pull data from
# all the spreadsheets, and see what they have
# inside them.
L %>% sapply(head, 3)


# We can also write it like this:
L %>% sapply(\(x){head(x, 3)})

# _______________________________________________
# A
# Do an inner_join between L$Teams and L$Players

# There are cases where we do not have to 
# specify on which field we are joining.
L$Teams %>% inner_join(L$Players) %>% head


# But to be completely sure that we get the join
# correct, we specify:
L$Teams %>%
  inner_join(L$Players,
             by=c("TeamID"="TeamID")) %>% head
  



# 1
# Return the column with team names and a column
# with the number of players in each.

  # For practice I will not save the joined 
  # dataframes into one. I will join them 
  # multiple times.

L$Teams %>% inner_join(L$Players,
                       by=c("TeamID"="TeamID")) %>%
  group_by(Nickname) %>%
  summarise(Num.of.players=n())



# 2
# Which players wear at least partially blue
# uniform? Return the first and last name.
L$Teams %>% inner_join(L$Players,
                       by=c("TeamID"="TeamID")) %>% 
select(Colors, contains("tName")) %>% 
filter(grepl("Blue", Colors)) %>% .[,-1]



# _______________________________________________
# B
# Do a double inner join, L$Teams inner_join L$Games
# inner_join L$Teams, the first time across 
# HomeTeamID and the second time VisitTeamID.

L$Teams %>% 
  inner_join(L$Games,
             by=c("TeamID"="HomeTeamID")) %>% 
  inner_join(L$Teams,
             by=c("VisitTeamID"="TeamID")) -> doubleJoin


# 1
# Which teams played on 2005-09-12?
doubleJoin %>%
  select(contains("nickname"), DatePlayed) %>% 
  filter(as.character(DatePlayed)=="2005-09-12") %>% 
  rename(Home = Nickname.x, Visit = Nickname.y) -> B

  
  
# 2
# Use pivot_longer() or gather() and return a
# column with “home” or “visit” values and a 
# column with the names of the teams.
doubleJoin %>% head

# Pivoting:
# We have these rows spread around multiple columns
# we can put them in the same column. 
# As long as we keep track on which column they belonged
# we do not lose any information


# Solution:
B
B %>% pivot_longer(Home:Visit, values_to = "Nickname")
# We need to tell pivot_longer which columns we want
# to join into one. We can do it as a vector.



# Gather does the same thing as pivot_longer
B %>% gather("Team","Nickname",1:2)
# Basically we specify the col1 name, col2 name, and 
# then we choose which ones we want, and which ones we 
# do not want.

# _______________________________________________
# C

# 1
# Make a table of teams x teams (one home one 
# visiting) with NA if they didnt play and the
# date otherwise. Use pivot_wider or spread.

# 
L$Teams %>% inner_join(L$Games,
                       by=c("TeamID"="HomeTeamID")) %>% 
  inner_join(L$Teams,
             by=c("VisitTeamID"="TeamID")) %>% 
  select(contains("nickname"), DatePlayed) %>% 
  rename(Home = Nickname.x, Visit = Nickname.y) -> C


C %>%
  pivot_wider(names_from=Visit, values_from=DatePlayed) -> C1
# 

C %>%
  pivot_wider(names_from=Visit, values_from=DatePlayed) %>% 
  arrange(Home) %>% .[,c(1,order(colnames(.)[-1])+1)] -> C2


# Adding symetricity
C %>% rename(Home=Visit, Visit=Home) %>% rbind(C) %>% 
  pivot_wider(names_from=Visit, values_from=DatePlayed) %>% 
  arrange(Home) %>% .[,c(1,order(colnames(.)[-1])+1)] -> C3


# 2
# Write a function using case_when, that given
# two numerical values returns 3 if first>second,
# 1 if first=second and 0 otherwise.
custom.fun<-\(x, y){case_when(x>y~3, x==y~1, T~0)}


custom.fun(10, 5)
custom.fun(5, 5)
custom.fun(4, 5)


# _______________________________________________
# D

# 1
# How many games did each coach play on their home 
# field?
L$Coaches %>% inner_join(L$Games,
                         by=c("TeamID"="HomeTeamID")) %>% 
  group_by(CoachID, FirstName, LastName) %>% summarise(n())

# L$Games %>% inner_join(L$Coaches,
#                        by=c("HomeTeamID"="TeamID"))


# Another issue arises if we want to show coaches
# that coached visiting games, or didnt coach any
# games. And put 0 in the column.

# To do that we have to do a left join.
L$Coaches %>% left_join(L$Games, 
                        by=c("TeamID"="HomeTeamID")) %>% 
  select(1:3, 10) %>% 
  group_by(CoachID, FirstName, LastName) %>% 
  summarise(funct(TeamID))

funct <-\(x){sum(!is.na(x))}

# 2  
# For each team return the total points of all
# the games played where a win is worth 3, tie
# worth 1 and defeat worth 0. Use the user 
# defined function from the previous excercise
# and if needed rowwise().

# We will use the function that we wrote in C Task 2
# custom.fun

L$Teams %>%
  inner_join(L$Games,
             by=c("TeamID"="HomeTeamID")) %>% 
  inner_join(L$Teams, 
             by=c("VisitTeamID"="TeamID")) %>% 
  select(Home=Nickname.x, Visit=Nickname.y, contains("score")) %>% 
  mutate(HomePts=custom.fun(HomeScore, VisitScore),
         VisitPts=custom.fun(VisitScore, HomeScore)) %>% 
  select(-3, -4) %>% 
  {data.frame(Team=c(.$Home,.$Visit), Pts=c(.$HomePts, .$VisitPts))} %>% 
  group_by(Team) %>% summarise(Total=sum(Pts)) %>%
  arrange(desc(Total))