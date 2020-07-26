###---START---###

### Importing required libraries
library(data.table) # for using the data.table structure
library(ggplot2) # for creating graphs
library(varhandle) # for using unfactor() method
library(plyr) # for using mapvalues() method
library(party) # for decision trees
library(plotly) # for creating graphs

'%notin%' <-
  Negate('%in%') # operator definition for "not in" a vector

### Loading the dataset
setwd("~/Documents/@University/#2 2020 Spring/CICS 197R/Final Project") # go to containing directory
divData <-
  read.csv("Data/Diversity-Data-Silicon-Valley-2016.csv") # load the .csv file

### Viewing the data

str(divData) # seeing how the data is stored internally
# Output:
# 'data.frame':	4500 obs. of  6 variables:
# $ company     : Factor w/ 25 levels "23andMe","Adobe",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ year        : int  2016 2016 2016 2016 2016 2016 2016 2016 2016 2016 ...
# $ race        : Factor w/ 8 levels "American_Indian_Alaskan_Native",..: 4 4 4 4 4 4 4 4 4 4 ...
# $ gender      : Factor w/ 3 levels "","female","male": 3 3 3 3 3 3 3 3 3 3 ...
# $ job_category: Factor w/ 12 levels "Administrative support",..: 3 5 8 11 9 1 2 6 4 10 ...
# $ count       : Factor w/ 725 levels "0","1","10","100",..: 1 2 616 1 1 1 1 1 1 1 ...

head(divData) # seeing how the data is stored visually
# Output:
# company year               race gender           job_category count
# 1 23andMe 2016 Hispanic_or_Latino   male             Executives     0
# 2 23andMe 2016 Hispanic_or_Latino   male               Managers     1
# 3 23andMe 2016 Hispanic_or_Latino   male          Professionals     7
# 4 23andMe 2016 Hispanic_or_Latino   male            Technicians     0
# 5 23andMe 2016 Hispanic_or_Latino   male          Sales workers     0
# 6 23andMe 2016 Hispanic_or_Latino   male Administrative support     0

levels(divData$company) # seeing the name of companies for which data is available
# Output:
# "23andMe"    "Adobe"      "Airbnb"     "Apple"      "Cisco"      "eBay"       "Facebook"   "Google"     "HP Inc."    "HPE"        "Intel"
# "Intuit"     "LinkedIn"   "Lyft"       "MobileIron" "NetApp"     "Nvidia"     "PayPal"     "Pinterest"  "Salesforce" "Sanmina"    "Square"
# "Twitter"    "Uber"       "View"

unique(divData$year) # seeing the years for which the data is available
# Output:
# 2016

levels(divData$race) # seeing the race divisions for which the data is available
# Output:
# "American_Indian_Alaskan_Native"      "Asian"                               "Black_or_African_American"
# "Hispanic_or_Latino"                  "Native_Hawaiian_or_Pacific_Islander" "Overall_totals"
# "Two_or_more_races"                   "White"

levels(divData$gender) # seeing what gender data is available
# Output:
# ""       "female" "male"

levels(divData$job_category) # seeing the job categories for which the data is available
# Output:
# "Administrative support" "Craft workers"          "Executives"             "laborers and helpers"   "Managers"
# "operatives"             "Previous_totals"        "Professionals"          "Sales workers"          "Service workers"
# "Technicians"            "Totals"

# Overall, we notice that the data is stored as a data.frame and contains 4500 entries with 6 columns as company (Factor type), year (int type), race
# (Factor type), gender (Factor type), job category (Factor type), and count (Factor type). We notice that there's only one unique year (which therefore
# becomes a redundant column as we can specify all the data to belong to that year) and that count is also stored as a Factor type which can be better
# represented as numeric integral data. We'll look into cleaning it in the next section.

### Cleaning and Transforming the data

divData <-
  as.data.table(divData) # Storing our data frame as a data.table instead for more efficiency (shallow copying) and better functionality.

divData$year <-
  NULL # Removed year column as data belonged completely to a singular year 2016 (we'll specify all data is from 2016 only)

divData$count <-
  as.numeric(unfactor(divData$count)) # converted the count column to have numeric data instead of factors

divData$gender[divData$gender == ""] <-
  NA # converted the missing values "" in gender to NAs

divData$race <-
  mapvalues(
    divData$race,
    from = c(
      "American_Indian_Alaskan_Native",
      "Asian",
      "Black_or_African_American",
      "Hispanic_or_Latino",
      "Native_Hawaiian_or_Pacific_Islander",
      "Overall_totals",
      "Two_or_more_races",
      "White"
    ),
    to = c(
      "American-Indian/Alaskan Native",
      "Asian",
      "Black/African-American",
      "Hispanic/Latino",
      "Native Hawaiian/Pacific Islander",
      "Overall Totals",
      "Multiracial",
      "White/Caucasian"
    )
  ) # converted the race values to non-underscored strings for brevity

divData <-
  divData[divData$job_category != "Previous_totals"] # remove the rows which have job_category as 'Previous_totals'; not needed as project focuses only on 2016 data: a total of 375 rows are deleted

divData$job_category <-
  droplevels(divData[divData$job_category != "Previous_totals"]$job_category) # remove 'Previous_totals' as a level from the factor data type

divData$job_category <-
  mapvalues(
    divData$job_category,
    from = c(
      "Administrative support",
      "Craft workers",
      "Executives",
      "laborers and helpers",
      "Managers",
      "operatives",
      "Professionals",
      "Sales workers",
      "Service workers",
      "Technicians",
      "Totals"
    ),
    to = c(
      "Administrative Support",
      "Craft Workers",
      "Executives",
      "Laborers/Helpers",
      "Managers",
      "Operatives",
      "Professionals",
      "Sales Workers",
      "Service Workers",
      "Technicians",
      "Totals"
    )
  ) # converted the job_category values for brevity and uniformity

str(divData) # Post cleaning the data, we obtain the data as:
# Classes ‘data.table’ and 'data.frame':	4125 obs. of  5 variables:
# $ company     : Factor w/ 25 levels "23andMe","Adobe",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ race        : Factor w/ 8 levels "American-Indian/Alaskan Native",..: 4 4 4 4 4 4 4 4 4 4 ...
# $ gender      : Factor w/ 3 levels "","female","male": 3 3 3 3 3 3 3 3 3 3 ...
# $ job_category: Factor w/ 11 levels "Administrative Support",..: 3 5 7 10 8 1 2 6 4 9 ...
# $ count       : num  0 1 7 0 0 0 0 0 0 0 ...
# - attr(*, ".internal.selfref")=<externalptr>

### Joining and Filtering the data and using Aggregations

divData_companyCount <-
  aggregate(count ~ company, data = divData, FUN = sum) # create a data.frame to analyse the aggregation of count and company

divData_companyCount$count <-
  0.5 * divData_companyCount$count # halving the count because there were rows initially (now removed) for totals which had doubled the count erroneously

divData_raceCount <-
  aggregate(count ~ race, data = divData, FUN = sum)[c(1:4, 7, 5, 8, 6),] # create a data.frame to analyse the aggregation of count and race (with some order changes)

rownames(divData_raceCount) <-
  seq_len(nrow(divData_raceCount)) # revise the data.frame's row numbering

divData_genderCount <-
  aggregate(count ~ gender, data = divData, FUN = sum) # create a data.frame to analyse the aggregation of count and gender

divData_genderCount <-
  rbind(divData_genderCount, data.frame(
    gender = "total",
    count = sum(divData_genderCount$count)
  )) # add a missing row with the totals for the gender data

divData_jobCount <-
  aggregate(count ~ job_category, data = divData, FUN = sum) # create a data.frame to analyse the aggregation of count and job_category

calcPercent <- function(divData_entity) {
  return(round((divData_entity$count / 752154) * 100, digits = 3))
} # a function to calculate the percent from data.frame objects with respect to the total number of employees

divData_companyCount$percent <-
  calcPercent(divData_companyCount) # calculate the percent of employees for each company

divData_raceCount$percent <-
  calcPercent(divData_raceCount) # calculate the percent of employees for each race

divData_genderCount$percent <-
  calcPercent(divData_genderCount) # calculate the percent of employees for each gender

divData_jobCount$percent <-
  calcPercent(divData_jobCount) # calculate the percent of employees for each job role

makeLabel <- function (divData_entity, entity) {
  return(paste(entity, divData_entity$percent, "%", sep = " "))
} # a function to create string labels for the various data.frame objects

divData_companyCount$labels <-
  makeLabel(divData_companyCount, divData_companyCount$company) # insert the labels column with count and company in the data.frame

divData_raceCount$labels <-
  makeLabel(divData_raceCount, divData_raceCount$race) # insert the labels column with count and race in the data.frame

divData_genderCount$labels <-
  makeLabel(divData_genderCount, divData_genderCount$gender) # insert the labels column with count and gender in the data.frame

divData_jobCount$labels <-
  makeLabel(divData_jobCount, divData_jobCount$job_category) # insert the labels column with count and job_category in the data.frame

### Visualizing the categorical data
plot_ly(
  divData_companyCount,
  type = 'pie',
  labels = ~ labels[seq_len(nrow(divData_companyCount))],
  values = ~ percent[seq_len(nrow(divData_companyCount))],
  textposition = 'outside'
) %>% layout(uniformtext = list(minsize = 20, mode = 'hide')) # plot a pie chart for the company and count data

plot_ly(
  divData_raceCount,
  type = 'pie',
  labels = ~ labels[seq_len(nrow(divData_raceCount)) - 1],
  values = ~ percent[seq_len(nrow(divData_raceCount)) - 1],
  textposition = 'outside'
) %>% layout(uniformtext = list(minsize = 20, mode = 'hide')) # plot a pie chart for the race and count data

plot_ly(
  divData_genderCount,
  type = 'pie',
  labels = ~ labels[seq_len(nrow(divData_genderCount)) - 1],
  values = ~ percent[seq_len(nrow(divData_genderCount)) - 1],
  textposition = 'outside'
) %>% layout(uniformtext = list(minsize = 20, mode = 'hide')) # plot a pie chart for the gender and count data

plot_ly(
  divData_jobCount,
  type = 'pie',
  labels = ~ labels[seq_len(nrow(divData_jobCount)) - 1],
  values = ~ percent[seq_len(nrow(divData_jobCount)) - 1],
  textposition = 'outside'
) %>% layout(uniformtext = list(minsize = 20, mode = 'hide')) # plot a pie chart for the job and count data

ggplot(divData_companyCount, aes(company, count)) + geom_bar(stat = "identity",
                                                             width = 0.5,
                                                             position = 'dodge') + geom_text(aes(label = count), vjust = -0.5) + labs(title = "Employment Diversity in Silicon Valley", subtitle = "Company-wise Distribution") + theme(axis.text.x = element_text(angle = 90, vjust = 1)) # plot a bar chart for the company and count data

ggplot(divData_raceCount, aes(race, count)) + geom_bar(stat = "identity",
                                                       width = 0.5,
                                                       position = 'dodge') + geom_text(aes(label = count), vjust = -0.5) + labs(title = "Employment Diversity in Silicon Valley", subtitle = "Racial Diversity") + theme(axis.text.x = element_text(angle = 90, vjust = 1)) # plot a bar chart for the race and count data

ggplot(divData_genderCount, aes(gender, count)) + geom_bar(stat = "identity",
                                                           width = 0.5,
                                                           position = 'dodge') + geom_text(aes(label = count), vjust = -0.5) + labs(title = "Employment Diversity in Silicon Valley", subtitle = "Gender Diversity") + theme(axis.text.x = element_text(angle = 90, vjust = 1)) # plot a bar chart for the gender and count data

ggplot(divData_jobCount, aes(job_category, count)) + geom_bar(stat = "identity",
                                                              width = 0.5,
                                                              position = 'dodge') + geom_text(aes(label = count), vjust = -0.5) + labs(title = "Employment Diversity in Silicon Valley", subtitle = "Job Role Diversity") + theme(axis.text.x = element_text(angle = 90, vjust = 1)) # plot a bar chart for the job and count data

### Computing statistics

divStats <-
  divData_companyCount # creating a duplicate to add the statistics calculated as columns

# Sex-Ratios in the various companies and enlist in divStats
genderData <-
  aggregate(count ~ company * gender, data = divData, FUN = sum) # store the company and gender data, for counts

divStats$sex_ratio <-
  round(genderData$count[genderData$gender == "female"] / genderData$count[genderData$gender == "male"], digits = 3) # create a column calculating the sex ratios for all companies

# Non-White Ratios in the various companies and enlist in divStats
raceData <-
  aggregate(count ~ company * race, data = divData, FUN = sum) # store the company and race data, for counts

divStats$non_white_ratio <-
  round((raceData$count[raceData$race == "Overall Totals"] -  raceData$count[raceData$race == "White/Caucasian"]) / raceData$count[raceData$race == "Overall Totals"], digits = 3) # create a column calculating the non-white ratios for all companies

# Blue-collar jobs ratio in the various companies and enlist in divStats
jobsData <-
  aggregate(count ~ company * job_category, data = divData, FUN = sum) # store the company and job data, for counts

divStats$blue_collar_ratio <- round(
  (
    jobsData$count[jobsData$job_category == "Craft Workers"] + jobsData$count[jobsData$job_category == "Laborers/Helpers"] +
      jobsData$count[jobsData$job_category == "Operatives"] + jobsData$count[jobsData$job_category == "Service Workers"] +
      jobsData$count[jobsData$job_category == "Technicians"]
  ) / jobsData$count[jobsData$job_category == "Totals"],
  digits = 3
) # create a column calculating the blue-collar jobs ratios for all companies

# Workforce Size statistics among the various companies

mean(divStats$count) # calculate the mean workforce size
# Output:
# 30086.16

median(divStats$count) # calculate the median workforce size
# Output:
# 11822

sd(divStats$count) # calculate the standard deviation of the workforce size
# Output:
# 41788.9

quantile(divStats$count) # calculate the quantile distribution of the workforce size
# Output:
#   0%    25%    50%    75%   100%
# 594   3834  11822  27226 154384

mean(divStats$sex_ratio) # calculate the mean workforce sex-ratio
# Output:
# 0.52844

median(divStats$sex_ratio) # calculate the median workforce sex-ratio
# Output:
# 0.474

sd(divStats$sex_ratio) # calculate the standard deviation of the workforce sex-ratio
# Output:
# 0.1917622

quantile(divStats$sex_ratio) # calculate the quantile distribution of the workforce sex-ratio
# Output:
#     0%   25%   50%   75%  100%
# 0.204 0.418 0.474 0.673 1.007

mean(divStats$non_white_ratio) # calculate the mean workforce non-white ratio
# Output:
# 0.42264

median(divStats$non_white_ratio) # calculate the median workforce non-white ratio
# Output:
# 0.435

sd(divStats$non_white_ratio) # calculate the standard deviation of the workforce non-white ratio
# Output:
# 0.0721254

quantile(divStats$non_white_ratio) # calculate the quantile distribution of the workforce non-white ratio
# Output:
#    0%   25%   50%   75%  100%
# 0.261 0.374 0.435 0.467 0.571

mean(divStats$blue_collar_ratio) # calculate the mean workforce blue-collar ratio
# Output:
# 0.06772

median(divStats$blue_collar_ratio) # calculate the median workforce blue-collar ratio
# Output:
# 0.005

sd(divStats$blue_collar_ratio) # calculate the standard deviation of the workforce blue-collar ratio
# Output:
# 0.1341428

quantile(divStats$blue_collar_ratio) # calculate the quantile distribution of the workforce blue-collar ratio
# Output:
#     0%   25%   50%   75%  100%
# 0.000 0.000 0.005 0.036 0.498

mean(divStats$count * divStats$sex_ratio) # calculate the mean female workforce size
# Output:
# 13484.7

median(divStats$count * divStats$sex_ratio) # calculate the median female workforce size
# Output:
# 6789.576

sd(divStats$count * divStats$sex_ratio) # calculate the standard deviation of the female workforce size
# Output:
# 17670.84

quantile(divStats$count * divStats$sex_ratio) # calculate the quantile distribution of the female workforce size
# Output:
#       0%       25%       50%       75%      100%
# 187.680  2214.072  6789.576 13803.608 68546.496

mean(divStats$count * divStats$non_white_ratio) # calculate the mean non-white workforce size
# Output:
# 12537.99

median(divStats$count * divStats$non_white_ratio) # calculate the median non-white workforce size
# Output:
# 5496.59

sd(divStats$count * divStats$non_white_ratio) # calculate the standard deviation of the non-white workforce size
# Output:
# 18067.25

quantile(divStats$count * divStats$non_white_ratio) # calculate the quantile distribution of the non-white workforce size
# Output:
#       0%       25%       50%       75%      100%
# 222.156  1663.956  5496.590  9830.288 67774.576

mean(divStats$count * divStats$blue_collar_ratio) # calculate the mean blue-collar workforce size
# Output:
# 2923.726

median(divStats$count * divStats$blue_collar_ratio) # calculate the median blue-collar workforce size
# Output:
# 75.052

sd(divStats$count * divStats$blue_collar_ratio) # calculate the standard deviation of the blue-collar workforce size
# Output:
# 7713.895

quantile(divStats$count * divStats$blue_collar_ratio) # calculate the quantile distribution of the blue-collar workforce size
# Output:
#     0%       25%       50%       75%      100%
# 0.000     0.000    75.052   562.050 34890.784

### Visualizing the discrete data

hist(
  divStats$sex_ratio,
  breaks = 19,
  col = '#AAAAAA',
  main = 'Histogram of Sex Ratio',
  xlab = "Sex Ratio",
  ylab = "Number of Companies",
  xlim = c(0.2, 1.2)
) # Histogram of Sex-Ratio from divStats

plot(
  x = sort(divStats$sex_ratio),
  y = 1:25,
  type = 'b',
  main = "Plot of Sex Ratio",
  xlab = "Sex Ratio",
  ylab = "Index of Companies (ordered by increasing sex ratio)"
) # Plot of Sex-Ratio from divStats

hist(
  divStats$non_white_ratio,
  breaks = 15,
  col = '#AAAAAA',
  main = 'Histogram of Non-White Ratio',
  xlab = "Non-White Ratio",
  ylab = "Number of Companies",
  xlim = c(0.2, 0.6)
) # Histogram of Non-White Ratio from divStats

plot(
  x = sort(divStats$non_white_ratio),
  y = 1:25,
  type = 'b',
  main = "Plot of Non-White Ratio",
  xlab = "Non-White Ratio",
  ylab = "Index of Companies (ordered by increasing non-white ratio)"
) # Plot of Non-White Ratio from divStats

hist(
  divStats$blue_collar_ratio,
  breaks = 19,
  col = '#AAAAAA',
  main = 'Histogram of Blue-Collar Jobs Ratio',
  xlab = "Blue-Collar Jobs Ratio",
  ylab = "Number of Companies",
  xlim = c(0, 0.5)
) # Histogram of Blue-Collar Jobs Ratio from divStats

plot(
  x = sort(divStats$blue_collar_ratio),
  y = 1:25,
  type = 'b',
  main = "Plot of Blue-Collar Jobs Ratio",
  xlab = "Blue-Collar Jobs Ratio",
  ylab = "Index of Companies (ordered by increasing blue-collar jobs ratio)"
) # Plot of Blue-Collar Jobs Ratio from divStats

### Building models

sr_nwr_lm <-
  lm(sex_ratio ~ non_white_ratio, data = divStats) # generate a linear model of sex ratio with non-white ratio

sr_bcr_lm <-
  lm(sex_ratio ~ blue_collar_ratio, data = divStats) # generate a linear model of sex ratio with blue-collar jobs ratio

nwr_bcr_lm <-
  lm(non_white_ratio ~ blue_collar_ratio, data = divStats) # generate a linear model of non-white ratio with blue-collar jobs ratio

summary(sr_nwr_lm)
# Output:
# Call:
#   lm(formula = sex_ratio ~ non_white_ratio, data = divStats)
#
# Residuals:
#   Min       1Q   Median       3Q      Max
# -0.32008 -0.11349 -0.06361  0.15951  0.46140
#
# Coefficients:
#                    Estimate Std. Error t value Pr(>|t|)
#   (Intercept)       0.6776     0.2355   2.878   0.0085 **
#   non_white_ratio  -0.3528     0.5495  -0.642   0.5271
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 0.1942 on 23 degrees of freedom
# Multiple R-squared:  0.01761,	Adjusted R-squared:  -0.0251
# F-statistic: 0.4123 on 1 and 23 DF,  p-value: 0.5271

summary(sr_bcr_lm)
# Output:
# Call:
#   lm(formula = sex_ratio ~ blue_collar_ratio, data = divStats)
#
# Residuals:
#   Min       1Q   Median       3Q      Max
# -0.34415 -0.12979 -0.03166  0.18819  0.45585
#
# Coefficients:
#                     Estimate Std. Error t value Pr(>|t|)
#   (Intercept)        0.55115    0.04284  12.864 5.45e-12 ***
#   blue_collar_ratio -0.33528    0.28976  -1.157    0.259
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 0.1904 on 23 degrees of freedom
# Multiple R-squared:  0.05501,	Adjusted R-squared:  0.01392
# F-statistic: 1.339 on 1 and 23 DF,  p-value: 0.2591

summary(nwr_bcr_lm)
#Output:
# Call:
#   lm(formula = non_white_ratio ~ blue_collar_ratio, data = divStats)
#
# Residuals:
#   Min       1Q   Median       3Q      Max
# -0.15947 -0.05045  0.01755  0.04282  0.14655
#
# Coefficients:
#                      Estimate Std. Error t value Pr(>|t|)
#   (Intercept)        0.42445    0.01656  25.638   <2e-16 ***
#   blue_collar_ratio -0.02675    0.11197  -0.239    0.813
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 0.07359 on 23 degrees of freedom
# Multiple R-squared:  0.002475,	Adjusted R-squared:  -0.0409
# F-statistic: 0.05706 on 1 and 23 DF,  p-value: 0.8133

count_ratios_lm <-
  ctree(count ~ sex_ratio + non_white_ratio + blue_collar_ratio, data = divStats) # create a conditional decision tree for count with respect to sex ratio, non-white ratio, and blue-collar jobs ratio

plot(count_ratios_lm) # plot the conditional decision tree

# From this entire exercise generating those 3 linear models and 1 conditional tree, we observe that there is no significant linear correlation between the factors, and therefore, we can conclude that these variables are linearly independent of each other's influence.

### Finishing up and summarizing data

summary(divData)
# Output:
#      company                                   race        gender                     job_category      count
# 23andMe: 165   American-Indian/Alaskan Native  :550         :   0   Administrative Support: 375   Min.   :    0.0
# Adobe  : 165   Asian                           :550   female:1925   Craft Workers         : 375   1st Qu.:    0.0
# Airbnb : 165   Black/African-American          :550   male  :1925   Executives            : 375   Median :    1.0
# Apple  : 165   Hispanic/Latino                 :550   NA's  : 275   Laborers/Helpers      : 375   Mean   :  364.7
# Cisco  : 165   Native Hawaiian/Pacific Islander:550                 Managers              : 375   3rd Qu.:   27.0
# eBay   : 165   Multiracial                     :550                 Operatives            : 375   Max.   :77192.0
# (Other):3135   (Other)                         :825                 (Other)               :1875

summary(divData_companyCount)
# Output:
#    company       count           percent          labels
# 23andMe: 1   Min.   :   594   Min.   : 0.079   Length:25
# Adobe  : 1   1st Qu.:  3834   1st Qu.: 0.510   Class :character
# Airbnb : 1   Median : 11822   Median : 1.572   Mode  :character
# Apple  : 1   Mean   : 30086   Mean   : 4.000
# Cisco  : 1   3rd Qu.: 27226   3rd Qu.: 3.620
# eBay   : 1   Max.   :154384   Max.   :20.526
# (Other):19

summary(divData_genderCount)
# Output:
#   gender      count           percent          labels
#       :0   Min.   :230270   Min.   : 30.61   Length:3
# female:1   1st Qu.:376077   1st Qu.: 50.00   Class :character
# male  :1   Median :521884   Median : 69.39   Mode  :character
# total :1   Mean   :501436   Mean   : 66.67
#            3rd Qu.:637019   3rd Qu.: 84.69
#            Max.   :752154   Max.   :100.00

summary(divData_raceCount)
# Output:
#                               race       count           percent           labels
# American-Indian/Alaskan Native  :1   Min.   :  2388   Min.   :  0.317   Length:8
# Asian                           :1   1st Qu.:  9716   1st Qu.:  1.292   Class :character
# Black/African-American          :1   Median : 46444   Median :  6.175   Mode  :character
# Hispanic/Latino                 :1   Mean   :188038   Mean   : 25.000
# Native Hawaiian/Pacific Islander:1   3rd Qu.:262360   3rd Qu.: 34.881
# Overall Totals                  :1   Max.   :752154   Max.   :100.000
# (Other)                         :2

summary(divData_jobCount)
# Output:
#                 job_category     count           percent           labels
# Administrative Support:1     Min.   :   388   Min.   :  0.052   Length:11
# Craft Workers         :1     1st Qu.:  2887   1st Qu.:  0.384   Class :character
# Executives            :1     Median : 46004   Median :  6.116   Mode  :character
# Laborers/Helpers      :1     Mean   :136755   Mean   : 18.182
# Managers              :1     3rd Qu.: 99265   3rd Qu.: 13.197
# Operatives            :1     Max.   :752154   Max.   :100.000
# (Other)               :5

summary(divStats)
# Output:
#    company       count           percent          labels            sex_ratio      non_white_ratio  blue_collar_ratio
# 23andMe: 1   Min.   :   594   Min.   : 0.079   Length:25          Min.   :0.2040   Min.   :0.2610   Min.   :0.00000
# Adobe  : 1   1st Qu.:  3834   1st Qu.: 0.510   Class :character   1st Qu.:0.4180   1st Qu.:0.3740   1st Qu.:0.00000
# Airbnb : 1   Median : 11822   Median : 1.572   Mode  :character   Median :0.4740   Median :0.4350   Median :0.00500
# Apple  : 1   Mean   : 30086   Mean   : 4.000                      Mean   :0.5284   Mean   :0.4226   Mean   :0.06772
# Cisco  : 1   3rd Qu.: 27226   3rd Qu.: 3.620                      3rd Qu.:0.6730   3rd Qu.:0.4670   3rd Qu.:0.03600
# eBay   : 1   Max.   :154384   Max.   :20.526                      Max.   :1.0070   Max.   :0.5710   Max.   :0.49800
# (Other):19

###---END---###