###### Lecture 4 - Plotting ######
# Reminder of how to Load Data #
my_data = read.table(file.choose())
my_data = read.table("your path here",header=T,sep=",")

#There are 4 basic types of plots
#Scatterplots, line graphs, histograms, and bar graphs
#For the first two types, we just use the hand "R" function "plot()"
#For a histogram we use: "hist()"
#for a bargraph we use "barplot()"
#In between the () we would input our data (either vectors or datasets)
#Also in the () is where we enter our arguments to customize the figure itself
#some examples include: 
# col = "red" - changes the color
# pch = 18 - changes the point type
#Remember we need to seperate our arguments via commas in R


###### Scatter Plot ######
#First thing we need to do is create a vector
v1 = c(4,5,3,8,15,10) #this vector conatins 6 numbers

#Then we  create a plot
plot(v1) #this simply creates a scatterplot of our vector

plot(v1, pch = 2, col = "green", main = "My Title") #changes the type of dots

v2 = c(3,7,9,16,12,18) #create a second vector to plot the relationship
plot(v1,v2, xlab = "X Label",col = "red")
abline(lm(v1~v2),  col = "seagreen1",lwd=2) #this adds a best fit line and the line width is 3


###### Line Graph ######
v3 = c(1,5,7,12,14,16)
plot(v3)
lines(v3)

#Another try
plot(v3,ylim=c(0,100), xlim=c(1,5), pch = 4, col = "forestgreen") #change the limits of the graph (so what data is shown)
lines(v3, lwd=4, col = "forestgreen") #changes the line width 
#you can also do the same with "xlim"
#note that the "line" between dots will be plotted in the order they are given in the dataset

#try chaning the xlim values. What do you notice happens?

#Alternative metho
plot(v3, type = "l") #this type command just tells R to use the "line" type

#Let's now add two lines and then a legend
v4 = c(1,5,7,12,14,16)
plot(v3,v4,type="c", pch=19, col="darkorchid4") 

# Add a line. We'll need to create a new vector first
v5 = v4*2 #this multiplies the vector by 2

plot(v3,v4, type ="b", pch=19, col="darkorchid4",lty=3,ylim=c(0,50)) #we've also changet the linetype here using "lty"
lines(v3, v5, pch=18, col="blue",lty=2) #let's add the type command
#this just specifies what type of arguement we want: p for point, l for lines, b for both
legend(1, 15, legend=c("Line 1", "Line 2"), # Add a legend
       col=c("darkorchid4", "blue"), lty=3:2, cex=1) #this lty just tells the legend which 
        #which type of lines to use

#Try changing hte colours and the line types. Can you find resources to do so?

###### Histogram #####
RT = c(1,12,13,24,56,4,2,55,13,2,15,45,20,18,16,23,20,38,31,41,43,23,25,32,31,21)
hist(RT) #creates a basis histogram of the vector "RT"
hist(RT, col = 'cyan4') #customizes the histogram to add colour
hist(RT, col = 'dodgerblue2',main = NULL,xlab = "Reaction time (s)") #customizes the histogram to get rid
#of the title and changes the x axis label
hist(RT, col = 'tomato2',main = NULL,xlab = "Reaction time (s)", breaks = 5) #this changes the breaks
#breaks = number of bars
hist(RT, col = 'tomato2',main = NULL,xlab = "Reaction time (s)", breaks = 20) 

###### Bar Plot #####
RT_2 = c(1,4,6)
barplot(RT_2)

#We can add category names as well
RT_cat = c("1","2","3") #first we need to create a vector
barplot(RT_2,names.arg = RT_cat, xlab = "School") #then we add it with names.arg argument
barplot(RT_2,names.arg = RT_cat, xlab = "School", col = "darkgreen")

#We can flip the graph horizontal
barplot(RT_2,names.arg = RT_cat, xlab = "School", col = "darkgreen", horiz = "TRUE")

###### To Do for Today #####
# Try to add a vertical axis title
# change some titles
#Create your own vector of 5 numbers and try to plot it
# change the font on a graph
# Try to plot the dataset I've attached for this class
# Try changing the colours on your graphs

#Resources
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf - R colours
# https://www.statmethods.net/advgraphs/parameters.html - R parameters for lines and dots