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
library("lme4") # for linear modeling
library("checkmate") #
library("lmerTest") #
library("dplyr") #useful for summarizing data and re-organizing data, just use tidyverse
library("moments") #
library("psych") #
library("car")
library("ez")
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
read.table("http://users.stat.ufl.edu/~winner/data/lsd.dat",header=F) #file with no header
read.table("http://lib.stat.cmu.edu/jcgs/tu",skip=4,header=T) #import from web, note that you have to skip the first 4 lines, and the header
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
my_data$newcol = oldcol*6 #this is how you add a new column, in this case just a simple linear transformation of an old column

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
str(my_data) #gives you the structure of the dataframe (e.g., this many factors with this many levels)
head(my_data) # gives you the first 6 subjects?
names(my_data) #gives you the names of the header (if they are included)
View(my_data)

################ Data analysis Section ###########################
#A lot of this section is in progress, and I hope to update it as I finish off the statistics
#tutorials for PSYC 300A. I have tried to be as general as possible. 

#Arithmetic commands
mean() #gives the mean
median() #gives the median
sd() #gives the standard deviation
var() #gives the variance

##### Correlations #####
cor() #will return all the correlations of your dataset
#it gets returned in a table
cor(my_data$variable1,my_data$variable2) #returns the correlation between two variables
#Pearson is the default method
cor(my_data$variable1,my_data$variable2, method = "pearson") #pearson, when you have cts X and Y
cor(my_data$variable1,my_data$variable2, method = "spearman") #spearman's rho, when you have non-para data, ordinal data
cor(my_data$variable1,my_data$variable2, method = "kendall")
#We can also use the cor.test fucntion from the "stats" package to test our significance
cor.test(x,y, alterative = c ("two-sided"), method = "pearson")

##### T-tests #####
# These are welch's t-test (the more conservative t-test)
t.test(y,mu=0) #One sample t-test, testing against 0, y is the dataframe
t.test(X, Y, paired = FALSE, alternative = "one.sided") #Independent Samples T-Test, replace X and Y
t.test(X, Y, paired = FALSE, alternative = "two.sided")
t.test(X, Y, paired = TRUE, alternative = "one.sided") #Paired T-test
t.test(X, Y, paired = TRUE, alternative = "two.sided")

##### ANOVA - IN PROGRESS#####
# ANOVA - Base R
one_way <- aov(y ~ X, data=mydataframe) #does an anova of the data, one-way anova
summary(one_way)
anova(y ~ X, data=mydataframe) #simple way
#MANOVA -Base R
man <- manova(Y ~ A*B) #might need to use cbind
summary(man, test="Pillai") #test

#Pairwise T-test for multiple comparisons 
pairwise.t.test(data_frame$Y, data_frame$group, p.adjust.method = "BH") #can change the adjustment method if need
#can also shift pooled standard deviation if need be
# p.adjust methods are : "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"

#ANOVA - Ez anova package commands
#EZANOVA is good because it outputs sphericity tests and effect size
aov3 = ezANOVA(data = datasetname, dv = yourDV,wid=.(subject_id), between=.(iv3)) #one way between
aov1 = ezANOVA(data = datasetname, dv = yourDV, wid=.(subject_id), within=.(iv1)) #one way within subject
aov2 = ezANOVA(data = datasetname, dv = yourDV, wid=.(subject_id),within=.(iv1,iv2)) #two way within subject
aov4 = ezANOVA(data = datasetname, dv = yourDV, wid=.(subject_id),within=.(iv1,iv2),between=.(iv3)) #two way within, one way between
print(aov1) #output
#Link for computing the chi-square value:
#https://stats.stackexchange.com/questions/41399/how-to-calculate-chi-squared-from-mauchly-of-rs-ezanova-output

#CAR package - In progress...
#CAR uses the modeling approach syntax
leveneTest(Y ~ group, data = data_frame) #this lets you test the homogeniety of variance, which is key
#...EZanova is easier to interpret


##### Model building #####
#Simple Linear Regression
linear_model = lm(my_data$Y ~ my_data$X1 + my_data$X2)
print(linear_model) #this gives us the intercept and the slope
summary(linear_model) #this gives us our summary output

# In progress
#Non-linear regression
#Logistic Regression
#Poisson Regression

##### Linear Mixed Models - IN PROGRESS #####
#need lme4 package for this
#for model building we always compare some model with more parameters to a null model with less parameters
#linear mixed models are nice because they contain both fixed and random effects
#fixed effect is an effect from a variable that is consistent across people such as weight or height
#random is our idiosyntratic version of an effect, so it could be location or person (if we have multiple measurements)

model.null = lmer(DV ~ IV_1 + #our IV_1 is our fixed effect
                         (1|subject) + (1|location), data=datasetname, #subject and location are our random effects
                       REML=FALSE)
summary(model.null)
model.full = lmer(DV ~ IV_1 + IV_2 + IV_3 + #here we have added more fixed effects, as it is a more complex model
                          (1|subject) + (1|location), #subject and location are our random effects
                        data=datasetname, REML=FALSE)
summary(model.full) #gives us the summary of 

anova(model.null,model.full) #this will compute our test for the models
coef(model.full)

#Useful links
#http://www.bodowinter.com./tutorial/bw_LME_tutorial1.pdf
#http://www.bodowinter.com./tutorial/bw_LME_tutorial2.pdf
#https://web.stanford.edu/class/psych252/section/Mixed_models_tutorial.html



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

##### Tidyverse #####
#this uses the gapmidner dataset (which can be installed via "gapminder" package)
gapminder %>% arrange(desc(gdpPercap)) #descding just allows you to put in descending order
gapminder %>% filter(year == 2007) %>% arrange(desc(gdpPercap))#Can put the two verbs together! 
gapminder %>% mutate(pop = pop/1000000) #creates the new population value that is more readable
gapminder %>% summarize(meanLifeExp = mean(lifeExp)) #gives you the mean of the life expectency

#Other examples - More General
Data_Set_name = data %>% summarize(average = mean(value)*1000) 
#goes from dataset, creates a column called average using the summarize function
Data_Set_name = data %>% group_by(gender) %>% summarize(average = mean(RT)) 
#does the same thing, but groups it by gender first (and no *1000 multiplication)
Data_Set_name = data %>% mutate(average_ms = average*1000)
#takes the data and creates a new column called average_ms, which is just average times 1000 (created above)


##### Loops and Functions #####
#Functions
myfunction <- function(arg1, arg2, ... ){
  statements
  return(object)
}

if{}

for{}
