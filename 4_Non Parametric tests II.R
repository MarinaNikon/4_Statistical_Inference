#Assignment 4_Non Parametric tests II
#Marina Nikon

#BACKGROUND: The survey is conducted within a large organization 
#to assess satisfaction level of employees in various functions. 
#The satisfaction level is measured on 1-5 scale where higher
#a number indicates more satisfaction.

#QUESTIONS
#1. Import EMPLOYEE SATISFACTION SURVEY data.
satisf_survey<-read.csv(file.choose(), header = TRUE)
str(satisf_survey)
head(satisf_survey)
dim(satisf_survey)


#Check for normality of the data.
#QQPlot to check the normality for satlevel
qqnorm(satisf_survey$satlevel, 
       main = "QQPlot for satlevel", col="coral")
qqline(satisf_survey$satlevel, col= "blue") 
#Interpretation: The QQ Plot for the satlevel deviates from
# the theoretical line, indicating possible non-normality


#Box-Whisker Plot for satlevel (overall)
boxplot(satisf_survey$satlevel, col = "lightyellow",
        main='Box-Whisker Plot for satlevel',
    xlab = "Department", ylab = "Satisfaction Level")
#Interpretation: The median lies on the first quartile (Q1)
#meaning that could be positively skewed distribution. 
#But whiskers looks symmetric indicating no strong asymmetry.
#Further testing is necessary.


#Box-Whisker Plot for satlevel (by Departments)
boxplot(satisf_survey$satlevel~satisf_survey$dept, 
        col = c("lightyellow", "orange", "green"),
        main='Employee Satisfaction Level by Department',
        xlab = "Department", ylab = "Satisfaction Level")
#Interpretation: Median score for finance department is much
#higher then median score for IT and sales departments.
#Median score for IT and sales departments is equal
#Median for finance department lies on the Q1 and there is 
#only a down whisker, this suggests a highly left-skewed 
#distribution (negatively skewed)
#Median for IT department lies on the Q1 and there is only 
#an upper whisker, and single down outlier this suggests a 
#negatively skewed distribution
#Median for Sales department lies on the Q3 and there is 
#only an upper whisker, this suggests a highly right-skewed
#distribution (positively skewed)


#Shapiro-Wilk normality test for satisfaction level
shapiro.test(satisf_survey$satlevel)
#Interpretation: p-value = 6.048e-05, less than 0.05, reject the 
#null hypothesis.  Distribution of satisfaction level 
#can be assumed not normal



#Kolmogorov-Smirnof test to check  normality for satisfaction level
#Install and use package 'nortest'
install.packages('nortest')
library(nortest)
lillie.test(satisf_survey$satlevel)
#Interpretation: p-value = 4.682e-08, less than 0.05, reject the 
#null hypothesis.  Distribution of satisfaction level 
#can be assumed not normal



#2. Find median satisfaction level for ‘IT’, ‘Sales’ and ‘Finance’.
aggregate(satlevel~dept, data = satisf_survey, FUN = median)
#round(median(satisf_survey$IT),2)
#round(median(satisf_survey$Sales),2)
#round(median(satisf_survey$Finance),2)


#Interpretation:
#Median satisfaction level for Finance department is 4, meaning
#that half of the employees have a satisfaction level below 4,
#and half have a satisfaction level above 4.
#IT and Sales departments have equal satisfaction level, that is 3

#Test whether the satisfaction level among three roles differ significantly.
# Kruskal-Walis test
kruskal.test(satlevel~dept, data = satisf_survey)
#Interpretation:  p-value = 2.883e-06, less than 0.05, reject the 
#null hypothesis. There is a significant difference in satisfaction 
#levels between at least one pair of departments 



#3. Is there any association between satisfaction level and experience level?
#Experience level is defined as midlevel (greater than 2 years) and
#Junior (less than or equal to 2 years).

#Create a new column for experience level, based on "exp"
satisf_survey$exp_level <- ifelse(satisf_survey$exp >2,
                                  "midlevel", "junior")

#Print table summary to check the result
table(satisf_survey$exp_level)

install.packages("gmodels") #Install if necessary 
library(gmodels)

#Chi-square test for association
CrossTable(satisf_survey$satlevel, satisf_survey$exp_level, chisq=TRUE)
#Interpretation: p =  0.6202199, greater than 0.05, do not reject the 
#null hypothesis. There is no significant association between 
#satisfaction level and experience level


#4. Find number of employees with satisfaction score
#greater than 3 in each department

#Subset data for satlevel >3
subset_data <- satisf_survey[satisf_survey$satlevel > 3,]

#Count employees with satlevel > 3 in each department
table(subset_data$dept)
#Interpretation:
# 16 employees in FINANCE have satisfaction score
#greater than 3
# 4 employees in IT have satisfaction score greater than 3
# 2 employees in SALES have satisfaction score greater than 3




