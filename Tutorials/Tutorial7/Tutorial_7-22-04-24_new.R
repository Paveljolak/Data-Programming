# Tutorial 7 - 22/04/2024 

library(tidyverse)

# no need to load these you just need to have them
# installed
library(miniUI)
library(esquisse)


# Graphics

# __________________________________________________________
# A

# 1
# Draw y∼x using a scatterplot, with plot, lattice, and ggplot2.

n<-1000
x<-(1:n-1)^((sqrt(5)-1)/2)*cos((1:n-1)*2*pi*(sqrt(5)-1)/2)
y<-(1:n-1)^((sqrt(5)-1)/2)*sin((1:n-1)*2*pi*(sqrt(5)-1)/2)

plot(x, y)
lattice::xyplot(y~x) # a bit different, you first add y then x.
# 'y~x' means y depends on x
data.frame(X=x, Y=y) -> df
df
# %>% ggplot
# install.packages miniUI, esquisse
#install.packages("miniUI")
#install.packages("esquisse")



# 2
# Plot the sinus function on the interval [−π,π].
# ggplot2 is part of the tidyverse so we do not 
# need thte following library
# library(ggplot2)

ggplot(df) +
 aes(x = X, y = Y) +
 geom_point(shape = "circle")

# geom_point specifies the type
# of the plot


# We have different kind of plots:
# geom_point
# geom_path
# geom_line
# etc..

ggplot(df) + aes(x = X, y = Y) +
  geom_point()



# 3
# Plot a circle of radius 1 around the origin. Add a title and
# x,y labels. Plot a square on top of it.
seq(-pi, pi, 0.1) %>% 
  plot(sin(.), type="l")


# Plot also let's us plot a single variable
# like this. But it is quite inflexible
# since it only works for functions.
plot(sin, -pi, pi)


# Using a ggplot:
seq(-pi, pi, 0.1) %>% 
  data.frame(Angle=.,S=sin(.), C=cos(.)) %>% 
  ggplot() + aes(x=Angle, y=S) +
  geom_line()

# Solution to the actual task:
c(seq(-pi, pi, 0.1), pi) %>% {plot(cos(.),sin(.), type="l")}


# To add title and labels to the plot we do this:
c(seq(-pi, pi, 0.1), pi) %>% {plot(cos(.),sin(.), type="l", main="Title", xlab="X-axis", ylab = "Y-axis")}

plot(c(1,-1,-1,1,1), c(1,1,-1,-1,1),type="l")

# This deletes the previous plot, thats what plot does
# it erases the previous plot and draws the new one.

# So instead of plot we write down points
c(seq(-pi, pi, 0.1), pi) %>% {plot(cos(.),sin(.), type="l", main="Title", xlab="X-axis", ylab = "Y-axis", col="red")}

points(c(1,-1,-1,1,1), c(1,1,-1,-1,1),type="l",col="darkgreen")


# Alternative: GGPLOT

# Circle, then square
 df2 <- c(seq(-pi, pi, 0.1),pi) %>% 
  {data.frame(X = c(cos(.), c(1, -1, -1, 1, 1)),
              Y = c(sin(.), c(1, 1, -1, -1, 1)),
    Type = rep(c("Circle", "Square"), c(length(.),5)))}

# Grouping the plot by Type
ggplot(df2) + 
  geom_path(aes(x = X, y = Y, group = Type), colour = "red") +
  labs(
    x = "X",
    y= "Y",
    title = "Title",
  ) 

#Coloring the plot by Type
ggplot(df2) +
  geom_path(aes(x = X, y=Y, color = Type)) +
  labs(
    x = "X-Axis",
    y = "Y-Axis",
    title = "Circle and Square",
  ) +
  theme_minimal()

 
# __________________________________________________________
# B

# 1
# Create a function that given a positive integer n
# it creates n points at random in the square [−1,1]×[−1,1]
# then counts how many lie in the unit circle (radius=1) around 
# the origin (0,0). The function should return 4*count/n and 
# should also plot the random points, the square and the circle 
# on the same plot. Color the inside points with a different 
# color then outside points. Help yourself with the function 
# from the last tutorial:

montecarlo <-\(n){
  c(seq(-pi, pi, 0.1), pi) %>% {plot(cos(.),sin(.), type="l", main="Title", xlab="X-axis", ylab = "Y-axis", col="red")}
  points(c(1,-1,-1,1,1), c(1,1,-1,-1,1),type="l",col="darkgreen")
  x <- runif(n, -1, 1)
  y <- runif(n, -1, 1)
  points(x,y, col=ifelse(x^2+y^2<=1, "violet", "blue"))
  count <- sum(x^2+y^2<=1)
  4*count/n
} 

montecarlo(1000)
# This vaalue gets close to -> pi

# The reason for this is:
# area of square is 2*2=4
# area of disk is pi*r^2=pi
# chance to be in circle is pi/4
# given n points we expect pi/4*n to be
# in circle



# To do this with ggplot is more complicated


# 2
# Take the ggplot from the first problem and decrease the size
# of the point closer to the origin and also color based on 
# distance from the origin, like a sunflower.

n<-1000
x<-(1:n-1)^((sqrt(5)-1)/2)*cos((1:n-1)*2*pi*(sqrt(5)-1)/2)
y<-(1:n-1)^((sqrt(5)-1)/2)*sin((1:n-1)*2*pi*(sqrt(5)-1)/2)

# 'y~x' means y depends on x
data.frame(X=x, Y=y) -> df

ggplot(df) + aes(x = X, y = Y, color=sqrt(x^2+y^2), size = sqrt(x^2+y^2)) +
   geom_point() +
   scale_color_gradient(low = "#66AA66", high = "brown") +
   scale_size_continuous(range = c(1, 3))
# printers cyan yellow magenta
# screens/projectors red green blue


# __________________________________________________________
# C

# 1
# Ggplot the petal length in the dataframe iris with a 
# histogram. Color the species in different colors. How 
# do you plot only 1 species instead of all 3?
df3 <- iris 
df3 %>% head

ggplot(df3) +
  aes(y = Petal.Length, fill= Species, color = Species) +
  geom_histogram() +
  labs(
    y = "Length",
    x = "Count",
    title = "Count by length"
  )
  


# How do we plot only one species
# Instead of all 3. 

# We fiddle with the dataframe before 
# plotting:

df3 %>% .[.$Species=="setosa",] %>% 
  ggplot() +
  aes(y = Petal.Length, fill = Species, colour = Species) +
  geom_bar()





# __________________________________________________________
# D

# 1
# Pie chart with ggplot

dfB1<-data.frame(labels=c("no","no, but in yellow"),"values"=c(7,1))
ggplot(dfB1, aes(x="", y=values,fill=labels))+
  geom_bar(width = 1, stat = "identity")+coord_polar("y", start=0.2)+
  scale_fill_manual(values=c("blue", "yellow"))+
  #  ggtitle("Is this meme funny?")
  labs(title="Is this meme funny?",x="",y="")+
  theme(plot.title = element_text(size=30),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank(),
        legend.title=element_blank(),
        legend.text = element_text(size = 16, face = "bold"))




# Something about linear regression:

# To get the line for linear regression we use
# the function lm
lm(iris$Petal.Width~iris$Petal.Length) -> coeff
coeff$coefficients

# Now we plug the values in intecept and slope respectively

df3 %>% ggplot() +
  aes(x = Petal.Length, y = Petal.Width) +
  geom_point() +
  geom_abline(slope = 0.4157554, intercept = -0.3630755)

df3 %>% ggplot() +
  aes(x=Petal.Length, y=Sepal.Width) +
  geom_point() + geom_abline