#Masson-Loftus CI Test for R 
#Packages
library(dplyr)

#Load Data
data = read.csv(file.choose(new=F),header=TRUE) #load in the data
View(data) #make sure data is in long format, if it is wide, you'll need to modify it using Dplyr
data$Subject = factor(data$Subject) #Make sure your subject is a factor
data$Condi = factor(data$Condi) #Make sure the condition is a factor


#If Data is non-normalized, you'll need to normalize it
#this uses the dplyr package
data$norm1 = 
data$norm2 =
data$norm3 = 

#Run the actual ANOVA
CI_aov = aov(RT ~ Condi + Error(Subject/Condi), data=data) #this runs an AOV
  
#Condition and Sample Size
N =10 #this is your N
K =3 #this is your Condition

#Masson Loftus 1994
MSe = summary(CI_aov)[["Error: Subject:Condi"]][[1]][["Mean Sq"]]#this isolates the MSE for the within subject
CI = sqrt(MSe[2]/N)* qt(.975,((K-1)*(N-1)))
#Masson Nathoo 2018
SSe = summary(CI_aov)[["Error: Subject:Condi"]][[1]][["Sum Sq"]]#this isolates the SS score for the within subject
CI2 = sqrt(SSe[2]/(N*(N-1)*k))*(tinv(0.975,((k*(N-1)))))
