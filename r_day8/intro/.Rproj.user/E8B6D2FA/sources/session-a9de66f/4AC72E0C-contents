# basic commands -------------
#get the working directory/ pwd in R
getwd()

#change dir
setwd("path/to/somewhere")

#info: ob 'inhalt' oder "inhalt" ist egal, einzel oder doppelt Anführungszeichen sind gleich
#create new dir
dir.create("data")
#create sub dir in the new dir
dir.create("data/raw_data")

# types of different vectors -------------
#create variable
x <- 2+2
#what kind of variable is it?
class(x) #numeric: numbers, either integer (2) or decimal (2.0)

y <- "Hallihallo"
class(y) #character: Buchstaben, Namen, etc.
# string = whatever is in quotation marks "string"

z <- TRUE #logical: TRUE and FASLE (also less than, more than, ...)
class(z)
#bulian vector = TRUE and FALSE

w <- charToRaw("Moinsis")
class(w) #raw


d <- data.frame(matrix(1:6, nrow = 2, ncol = 3))
class(d) #dataframe = table
# data.frame is a function and matrix also

c <- 1+2i
class(c) #complex: Buchstaben und Zahlen zusammen


# example data ------------
#list all data sets available
data()

#get the iris data
data("iris")
#auf iris data klicken im environment rechts, dann fetched es das

class(iris$Sepal.Length)

#create all plots for every combination of cols and rows
plot(iris)
#strg + shift + 6 = zoomt plot groß

#create one boxplot
boxplot(data=iris, x=iris$Sepal.Length, y=iris$Species)
#create 3 boxplots (one for every species, all in one plot)
boxplot(data=iris, iris$Sepal.Length~iris$Species)

# ggplot ------------

install.packages("ggplot2")
library(ggplot2)

#mehrere packages auf einmal installieren
install.packages(c("readxl","plotly"))

install.packages("tidyverse")

#basic components of every plot
#mapping -> data
#aesthetics -> y und y Achsen definieren, color, size, etc.
#geometrics -> what kind of plot
# u always need all three to plot sth
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, fill=Species)) + geom_boxplot()

#wann welchen plot benutzen?
# https://apandre.files.wordpress.com/2011/02/chartchooserincolor.jpg


#use color, shape or size in aes to grouß the data, choosing depending on the type of data u want to group by
#when u want to group by character/group liek species= col, shape, in boxplot=fill)
#when group by numeric variable also size possible, zwar auch bei anderen möglich aber sinnlos
ggplot(data = iris, mapping = aes(x = iris$Petal.Length, y = iris$Sepal.Length, col = Species)) + geom_point()
ggplot(data = iris, mapping = aes(x = iris$Petal.Length, y = iris$Sepal.Length, shape = Species)) + geom_point()
ggplot(data = iris, mapping = aes(x = iris$Petal.Length, y = iris$Sepal.Length, size = iris$Petal.Width)) + geom_point()


#plot speichern
plot1 <- ggplot(data = iris, mapping = aes(x = iris$Petal.Length, y = iris$Sepal.Length, col = Species)) + geom_point()
plot1 + ggsave("plot1.pdf", plot1)
#weiter spezifizieren
plot1 ++ ggsave("plot1_tidy.pdf", plot1, width = 8, height = 6, units = "cm", dpi = 300)
plot1 ++ ggsave("plot1_compressed.tiff", plot1, width = 8, height = 6, units = "cm", dpi = 300, compression = "lzw")
#dpi = Auflösung, wenn zu hoch, dann gerne compression, damit datei nicht ewig groß, tiff datei= image datei, sehr groß, da dann compression drauf


library(tidyr)
try1 <- spread(data = iris, key = Species, value = Sepal.Length)


#Aufgabe für Protokoll:

#convert iris dataframe into long format


#check ob die Daten normalverteilt sind
hist(iris$Sepal.Length)
hist(iris$Sepal.Width) #sieht wie eine sehr schöne Gaußkurve aus
hist(iris$Petal.Length)
hist(iris$Petal.Width)

#auch möglich mit
boxplot(iris$Sepal.Width)
#Linie in box (median) sollte etwa in der Mitte liegen von box


# statistical methods --------

#sind daten normalverteilt?

#ja -> parametrical vs nein -> non-parametrical
#parametrical -> numerical -> t-test (1 oder 2) oder ANOVA (mehrere)

data()
data(ChickWeight)

ggplot(data = ChickWeight, aes(x = Time, y = weight, col = Diet)) +
  geom_point()

#evtl in protocol, viele schöne farben
ggplot(data = ChickWeight, aes(x = Time, y = weight, col = Chick)) +
  geom_line()

#evtl mit rein, der von Lea
ggplot(data = ChickWeight, aes(x = Diet, y = weight, col = Time)) +
  geom_point()

#1. für documentation (mehrere kleine plots mit facet wrap)
ggplot(data = ChickWeight, aes(x = Time, y = weight, col = Diet)) +
        geom_point() + 
        facet_wrap( ~ Diet)

ggplot(iris, 
      aes(x=Species, y=Petal.Length)) + 
      geom_boxplot() +
      facet_wrap(~Species)

#2- für protocol mit geom_smooth
ggplot(data = ChickWeight, aes(x = Time, y = weight, col = Diet)) +
  geom_point() + 
  geom_smooth()
  facet_wrap( ~ Diet)



library(dplyr)

data_msd <- ChickWeight %>%                           # Get mean & standard deviation by group
  group_by(Diet, ChickWeight$Time) %>%
  summarise_at(vars(Time),
               list(mean = mean,
                    sd = sd)) %>% 
  as.data.frame()
data_msd                                       # Print means & standard deviations


beauty_with_sd <- ggplot(data_msd, aes(x=ChickWeight$Time, y=mean, group=Diet, color=Diet)) + 
  geom_line() +
  geom_point()+
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,
                position=position_dodge(0.05))
print(p)


#3. für protocol, nur die MW 
mean <- ChickWeight %>% group_by(Time, Diet) %>% 
  summarise(mean_weight=mean(weight))

beauty <- ggplot(mean, aes(x=Time, y=mean_weight, group=Diet, color=Diet)) + 
  geom_line() +
  geom_point()

print(beauty)




#wide to long

library(tidyr)
iris_long <- gather(iris, leave, measurement, Sepal.Length:Petal.Width, factor_key=TRUE)



