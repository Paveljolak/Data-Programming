library(tidyverse)
library(readxl)

filename <- "SportsDatabase.xlsx"
filename

filename %>% readxl::excel_sheets() %>% sapply(\(x){readxl:: read_excel(filename, sheet=x)}) -> L


L$Coaches

L$Coaches$LastName

L %>% sapply(head, 3)

L %>% sapply(\(x){head(x, 3)})



# A _________________________________________________
# 1 
L$Teams %>% inner_join(L$Players, by=c("TeamID"="TeamID")) %>%
  group_by(Nickname) %>% summarise(Num.of.players=n())

# 2
L$Teams %>% inner_join(L$Players, by=c("TeamID"="TeamID")) %>%
  select(Colors, contains("tName")) %>% filter(grepl("Blue", Colors)) %>% .[,-1]


# B ________________________________________________

# 1

L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(contains("nickname"), DatePlayed) %>%
  filter(as.character(DatePlayed)=="2005-09-12") %>%
  rename(Home=Nickname.x, Visit=Nickname.y)


# 2 
# Pivot function
# We have the team spread out in different columns, the idea is to put them
# in the same column.
# So as long as we keep track from which column they came from, 
# we are not losing any information. It will just look different.



# We save previous function in B:
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(contains("nickname"), DatePlayed) %>%
  filter(as.character(DatePlayed)=="2005-09-12") %>%
  rename(Home=Nickname.x, Visit=Nickname.y) -> B


# Now we can easily work with it:
B %>% pivot_longer(Home:Visit) 
# usually we do not put column names here
# since we are using tiddyverse package we can do that.

?pivot_longer

  
B %>% pivot_longer(Home:Visit, values_to = "Nickname") 

B %>% gather("From", "Nickname", 1:2)

B %>% gather(,,-3)

# C ________________________________________________________
# 1

# Create a recycled B without the format
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(contains("nickname"), DatePlayed) %>%
  rename(Home=Nickname.x, Visit=Nickname.y) -> C

C

# Now we can work with it:
?pivot_wider
C %>% pivot_wider(names_from=Visit, values_from=DatePlayed) -> C1

C %>%
  pivot_wider(names_from=Visit, values_from=DatePlayed) %>%
  arrange(Home) %>%
  .[,c(1, order(colnames(.)[-1])+1)] -> C2
  

# Creating a symmetric table:
C %>%
  rename(Home=Visit, Visit=Home) %>%
  rbind(C) %>% pivot_wider(names_from=Visit, values_from=DatePlayed) %>%
  arrange(Home) %>%
  .[,c(1, order(colnames(.)[-1])+1)] -> C3

# ____________________________-
# 2 


custom.fun<-\(x, y){case_when(x>y~3, x==y~1, T~0)}
?case_when
# In case_when the " ~ " means return. so if x>y then return 3

custom.fun(10, 5)
custom.fun(5, 5)
custom.fun(4, 5)




# D ____________________________________________________


# 1
L$Coaches %>% inner_join(L$Games, by=c("TeamID"="HomeTeamID"))
L$Coaches %>% inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  group_by(CoachID, FirstName, LastName) %>% 
  summarise(n())


# So not to lose information, to keep all coaches we do:
L$Coaches %>% left_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  select(1:3, 10) %>% 
  group_by(CoachID, FirstName, LastName) %>%
  summarise(bla(TeamID))

bla<-\(x){sum(!is.na(x))}

# 2 
L$Teams %>%
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(Home=Nickname.x, Visit=Nickname.y, contains("score")) %>%
  mutate(HomePts=custom.fun(HomeScore, VisitScore), VisitPts=custom.fun(VisitScore, HomeScore)) %>%
  select(-3:-4) %>%
  {data.frame(Team=c(.$Home,.$Visit), Pts=c(.$HomePts,.$VisitPts))} %>%
  group_by(Team) %>%
  summarise(Total=sum(Pts)) %>% arrange(desc(Total))





