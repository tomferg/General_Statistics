##### Useful codes ######
# This is just a collection of useful codes for R
# It is a work in progress...if there are any errors, apologies!
# Parts of the code contain place holder example names, this will need to be changed for it to work

################ Useful Packages/Commands ################
install.packages("ggplot2") #remove
install.packages("lme4")
install.packages("lmerTest")
install.packages("checkmate")
install.packages("dplyr") #remove
install.packages("moments")
install.packages("psych")
install.packages("car")
install.packages("ez")
install.packages("tidyverse")

library("ggplot2") #
library("lme4") # for linear modeling - check this
library("checkmate") #
library("lmerTest") #
library("dplyr") #useful for summarizing data and re-organizing data, just use tidyverse
library("moments") #
library("psych") #
library(car)
library(ez)
library("tidyverse")


##### Useful Commands - Non-catagorized #####
rm(list=ls()) #remove data
cat("\014")  #clears workspace
save.image() #saves workspace

################ Mounting/Inputing Data ##################
getwd() #this gets your working directory, tells you were R is looking. We can change this via setwd()
setwd("/Users/samplename/samplefolder/") #this sets your working directory
#These two functions basically point your computer to a certain place
#This can be used for organization, and I would recommend it
#You can see what files you are working with and what their names are.

#Data can be input as elements or vectors
a = 2 #creates an element called a with a value of 2
x = c(1,2,3) #for adding a vector of data, with values 1,2,3

#read.csv and read.table
read.csv() #for reading data, make sure to include file location
read.csv("/Users/samplename/samplefolder/datasetname.csv", header = TRUE, sep = ",") #You need to choose the proper path
datasetname = read.csv("/Users/samplename/samplefolder/datasetname.csv", header = TRUE, sep = ",") #remember to assign it to work with it
#Note that the seperator matters, and depending on the file type this will change

#read.csv is just a specified form of read table
read.table()
read.table("http://lib.stat.cmu.edu/jcgs/tu",skip=4,header=T) #import from web, note that you have to skip the first 4 lines
read.table(file.choose(new=F),header=T) #useful way to use read table to choose data instead of playing around


#Selecting Parts of the dataset
datasetname$variablename #Remember when data is mounted, you can now examine data using the $ modifier 
data_set_name_2 <- data_set_name[c(2:5)] #Select data/select subsections of data, 2:5 would be the columns
data_set_name_3 <- data_set_name[-c(30,31),] #this drops the data, notice the - 
attach(datasetname) # this just attaches the data so you can use the names of columns and rows without using the $ modifier (specifies data)

#Commands for working with the data
names(...) #tells us the names of the columns
pairs() #shows the correlation plots
subset() #allows for the seperation of data from a dataset
droplevels()
summary() #very key! use for after tests and ANOVa and things of that nature
describe #need psych package!, used to describe the data set (means, n,sd, median and the like)

#Creating Matrix - for graphing purposes 
A = matrix(c(name_1,m1,sd1,cf_1,name_2,m2,sd2, cf_2),nrow=2,ncol=4,byrow = TRUE)
dimnames(A) = list(c("1","2"), c("Condition","Mean","Std","CI"))
A.frame <- as.data.frame(A) #turn into data frame so it can be graphed?
is.data.fram(A.frame) #just a check to make sure
A.frame$Mean <- as.numeric(as.character(A.frame$Mean)) #if data comes in as factor, change to numeric

#adding column names - can do the same for rownames
names = c(colnames(dataset), "...","...","...") #need to take out names, note the quotes around the string
colnames(datasetname) = c("avgdist","accuracy", "gender") #way to add names, makes sure header is false tho, 
rownames(datasetnam) = c("p_1","p_2","p_3") #p_1 could mean participant 1

#Commands for viewing the structure of the data 
str(mod2) #gives you the structure of the dataframe (e.g., this many factors with this many levels)
head(mod2) # gives you the first 6 subjects?
names(mod2) #gives you the names of the header (if they are included)
View(mod2)

################ Data analysis Section ###########################
#A lot of this section is in progress, and I hope to update it as I finish off the statistics
#tutorials for PSYC 300A. I have tried to be as general as possible. 

#Arithmetic commands
mean() #gives the mean
median() #gives the median
sd() #gives the standard deviation

##### T-tests - These are welch's t-test (the more conservative t-test) #####
t.test(y,mu=0) #One sample t-test, testing against 0, y is the dataframe
t.test(X, Y, paired = FALSE, alternative = "one.sided") #Independent Samples T-Test, replace X and Y
t.test(X, Y, paired = FALSE, alternative = "two.sided")
t.test(X, Y, paired = TRUE, alternative = "one.sided") #Paired T-test
t.test(X, Y, paired = TRUE, alternative = "two.sided")

##### ANOVA - IN PROGRESS#####
# ANOVA - not using CAR or EZANOVA #
one_way <- aov(y ~ X, data=mydataframe) #does an anova of the data, one-way anova
summary(one_way)
anova(y ~ X, data=mydataframe) #simple way

man <- manova(Y ~ A*B) #might need to use cbind
summary(man, test="Pillai") #test

#Pairwise T-test for multiple comparisons 
pairwise.t.test(data_frame$Y, data_frame$group, p.adjust.method = "BH") #can change the adjustment method if need
#can also shift pooled standard deviation if need be
# p.adjust methods are : "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"

#ANOVA - Ez anova package commands
#Repeated measures ANOVA
ez_anova_1 <- read.csv("/Users/username/folder/dataframename.csv", header = TRUE, sep = ",")#selects CSV file
rm1_lat <- rm1 %>% select(P_Code,Gender,Strat,Strat_Num,L1,L2,L3,L4,L5,L6,L7,L8,L9,L10) #selects the data called L1
rm1_long_lat <- gather(rm1_lat, trial, latency, L1:L10, factor_key=TRUE)#Data need to be in wide format so convert from long to wide
anova_lat_overall <- ezANOVA(data=rm1_long_lat,dv=latency,wid=P_Code,within = .(trial),type=3,detailed = TRUE)
print(anova_lat_overall) #prints the results of the anova

#For computing the chi-square value?
#https://stats.stackexchange.com/questions/41399/how-to-calculate-chi-squared-from-mauchly-of-rs-ezanova-output

#CAR package
leveneTest(Y ~ group, data = data_frame) #this lets you test the homogeniety of variance, which is key...EZanova 
#is easire to interpret though


##### Model building - IN PROGRESS #####
##### Correlations #####
#Note that both these are from the "stats" package
cor(x,y, na.rm = TRUE) #can be done on a matrix though, where cor will compute all the correlations between columns
cor.test(x,y, alterative = c ("two-sided"), method = "pearson") #this may need to be changed
#methods are "pearson", "kendall", "spearman"

##### Bayes Factors - IN PROGRESS #####

##### Power Analysis #####
#Note that these come from the "pwr" package
pwr.anova.test(k = , n = , f = , sig.level = , power = )	#balanced one way ANOVA
pwr.chisq.test(w =, N = , df = , sig.level =, power = ) #chi-square test, w is effect size, N is total sample size,
pwr.f2.test(u =, v = , f2 = , sig.level = , power = ) #general linear model,u and v are nom and denom DF, f2 is effect size
pwr.r.test(n = , r = , sig.level = , power = ) #correlation
pwr.t.test(n = , d = , sig.level = , power = , type = c("two.sample", "one.sample", "paired")) #t-tests (one sample, 2 sample, paired)
pwr.t2n.test	#t-test (two samples with unequal n)

#Stats commands
print() #simply prints the output of the function to the console, somes tests use this format
summary() # gives summary statistics of either the function (e.g., anova) or the table itself
#the types of statistics it gives depends on the input

##### Tidyverse -IN PROGRESS #####
#Dplyr examples - 
gapminder %>% arrange(desc(gdpPercap)) #descding just allows you to put in descending order
gapminder %>% filter(year == 2007) %>% arrange(desc(gdpPercap))#Can put the two verbs together! 
gapminder %>% mutate(pop = pop/1000000) #creates the new population value that is more readable
gapminder %>% summarize(meanLifeExp = mean(lifeExp)) #gives you the mean of the life expectency


##### Loops and Functions - In progress #####
#Functions
myfunction <- function(arg1, arg2, ... ){
  statements
  return(object)
}
