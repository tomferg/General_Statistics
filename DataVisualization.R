##### Figures for Plotting #####
##### Packages #####
#This code has been commented out because you only need to install packages once
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("tidyverse")

#however, you will need to run the library everytime you start a new R session
#Dplyr and ggplot2 have been commented out because tidyverse contains both of these libraries
#library(dplyr)
#library(ggplot2)
library(tidyverse) #this packge contains both ggplot and dplyr

#Sample Data #####
cars
View(cars)
summary(cars)

##### Histogram #####
Histo <- ggplot(data=cars, aes(x = speed)) + #specifies the data
  geom_histogram(binwidth = 2) + #this specifies that the graph is a histogram, and the binwidth (number of values per bin)
  xlab("Speed (mph)") + ylab("Number of Cars")+ #y and x labels
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        text = element_text(size=12, family = "Times",face="bold"))
Histo
ggsave(Histo, width = 3.25, height = 6.5, units = c("in"))

##### Bar Plot #####

Barplot <- ggplot(data=cars, aes(x = speed, y= dist)) + #specifies the data
  geom_bar(stat = "identity") + #this specifies that the graph is a histogram, and the binwidth (number of values per bin)
  xlab("Speed (mph)") + ylab("Distance (m)")+ #y and x labels
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        text = element_text(size=12, family = "Times",face="bold"))
Barplot
ggsave(Barplot, width = 3.25, height = 6.5, units = c("in"))


##### Line Graph #####
#this uses the cars dataset
ggplot(data=cars, aes(y=dist, x=speed)) +
  geom_line(size=1) +
  geom_point(size=0.25, fill="black")+
  xlab("Speed (mph)") + ylab("Distance (ft)")+
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
      panel.grid.minor = element_blank(),
      panel.background = element_blank(), 
      axis.line = element_line(colour = "black"),
      text = element_text(size=12, family = "Times",face="bold"))


#this one uses simulation data....
set.seed(10)
a <- sample(-10:15,size=200,replace=TRUE)
b <- sample(-10:15,size=200,replace=TRUE)

timepoints <- 1:50
a <- rnorm(50, mean = 0, sd = 2)
b <- rnorm(50, mean = -5, sd = 2)

NewDat <- data.frame(TP = timepoints, Win = a, Loss = b)
#View(NewDat)

ggplot(data=NewDat, aes(timepoints)) +
  geom_line(aes(y = Win, colour = "Win"),size=1, color = "black") + 
  geom_line(aes(y = Loss, colour = "Loss"),size=1, color = "gray") +
  xlab("Time") + ylab("Amplitude (mV)")+
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        text = element_text(size=12, family = "Times",face="bold"))

#Alternative formats - Note that the names will need to be changed
#Trial by Trial graph
latency <- ggplot(HexERP_L, aes(x=Trial_L, y=Average_L, group =1))+
  geom_line(size =1.5, colour="indianred3")+
  #geom_point(fill="blue")+
  geom_errorbar(aes(ymin=Average_L-CI_Val_L,ymax=Average_L+CI_Val_L), width = .3, size =1, colour = "black")+
  #geom_hline(yintercept=c(8), linetype="dotted", size = 1.5, colour="black")+
  xlab("Find It Trial") + ylab("Latency (s)")+ 
  scale_x_continuous(breaks=seq(0,10,1))+
  scale_y_continuous(limits=c(0,40), breaks = scales::pretty_breaks(n = 8))+
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black", size = 1),
        axis.ticks = element_line(size=1, colour = "black"),
        axis.text = element_text(colour="black"),
        text = element_text(size=12, family = "Times", face="bold"))
latency
ggsave("latency.jpg", width = 4, height =3, units ="in",dpi=300)

HexERP_theta <- read.table(file.choose(new=F), header=T, sep=",") 
HexERP_theta$Allo_Image2 <- factor(HexERP_theta$Allo_Image, c("Positive", "Negative"))

#Bar Graph for theta
Theta <- ggplot(HexERP_theta, aes(x=Allo_Image2, y=Theta, group = 1)) + 
  geom_bar(stat="identity", colour = "black", fill = "indianred3")+
  geom_errorbar(aes(ymin=Theta-CI, ymax=Theta+CI), width=.3, size = 1, colour = "black", position=position_dodge(.9)) +
  xlab("Allocentric Images") + ylab(expression(bold("Power"~" ("*mu*v^2*")")))+
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black", size = 1),
        axis.ticks = element_line(size=1, colour = "black"),
        axis.text = element_text(colour="black"),
        text = element_text(size=12, family = "Times New Roman",face="bold"))
Theta
ggsave("theta.jpg", width = 2.75, height =3, units ="in",dpi=300)


#MDMNF - alpha by social stress
alpha_stai <- ggplot(MDMNF, aes(x=State, y=Alpha_diff, group =1))+
  geom_point(size =2, colour = "red")+
  #geom_point(fill="blue")+
  #geom_errorbar(aes(ymin=Average_L-CI_Val_L,ymax=Average_L+CI_Val_L), width = .3, size =1.5, colour = "black")+
  geom_hline(yintercept=c(0), linetype="dotted", size = 1.5, colour="black")+
  xlab("STAI Score") + ylab("Alpha Power Difference")+
  geom_smooth(method='lm',colour = "purple", se = FALSE, size = 1.5)+
  #scale_x_continuous(breaks=seq(0,10,1))+
  scale_y_continuous(limits=c(-4,8), breaks = scales::pretty_breaks(n = 7))+
  annotate("text", x = 45, y = 4.5, label = "r = .43", colour = "purple", size = 6)+
  theme(panel.grid.major = element_blank(), #this theme creates a completely blank background
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black", size = 1),
        axis.ticks = element_line(size=1.5, colour = "black"),
        axis.text = element_text(colour="black"),
        text = element_text(size=14, family = "Times", face="bold"))
alpha_stai
ggsave("alpha_stai.jpg", width = 6, height = 4, units ="in",dpi=300)

#Faceting allows you to divide your plot into subplots
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~ continent) #facets for our continent....~ is from modeling work


#Methods to remove data for ggplot
  ylim(c(350,450)) #this clips it, but will remove data points
  coord_cartesian(ylim = c(350, 450)) #this keeps the data point and just clips it (useful for bargraphs)
  scale_y_continuous(300,450)



##### Topo Plot? ######