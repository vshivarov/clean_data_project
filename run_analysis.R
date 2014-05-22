## Set the work directory, for instance: setwd("C:/Users/x/Desktop/Coursera/UCI HAR Dataset")
## Load the necessary files
features<-read.table("features.txt", sep="", header=T)
features<-read.table("features.txt", sep="", header=F)
activity_lab<-read.table("activity_labels.txt", sep="", header=F)
subj_test<-read.table("./test/subject_test.txt", sep="", header=F)
subj_train<-read.table("./train/subject_train.txt", sep="", header=F)
act_train<-read.table("./train/y_train.txt", sep="", header=F)
meas_train<-read.table("./train/X_train.txt", sep="", header=F)
meas_test<-read.table("./test/X_test.txt", sep="", header=F)
act_test<-read.table("./test/y_test.txt", sep="", header=F)
subj_test<-read.table("./test/subject_test.txt", sep="", header=F)

## Build data frames with train and test data with common column names
colnames(meas_train)<-features[,2]
dfrm_train<-cbind(subj_train[,1], act_train[,1], meas_train)
feat<-features[,2]
colnames(dfrm_train)<-c("subject", "activity", as.character(feat))

dfrm_test<-cbind(subj_test[,1], act_test[,1], meas_test)
colnames(dfrm_test)<-c("subject", "activity", as.character(feat))

## Create a joined data frame with test and train data
dfrm_all<-rbind(dfrm_train,dfrm_test)

## Identify the columns with mean and std data
sel_cols1<-grep(pattern="mean()", colnames(dfrm_all), fixed=T)
sel_cols2<-grep(pattern="std()", colnames(dfrm_all), fixed=T)
sel_cols<-c(sel_cols1,sel_cols2)

## Subset the data frame 

sel_all<-c(1,2,sel_cols)
dfrm_sel<-dfrm_all[,sel_all]
colnames(dfrm_sel)[1:20]
## Create a factor for the activities with the proper labels 
## and replace the activity codes in the data frame
f<-factor(dfrm_sel$activity, levels=1:6, labels=activity_lab[,2])
dfrm_sel$activity<-f

## Melt the data frame
library(reshape)
dfrm_sel_melt<-melt.data.frame(dfrm_sel, id.vars=c("subject","activity"), measure.vars=colnames(dfrm_sel)[3:68])
dim(dfrm_sel_melt)
head(dfrm_sel_melt)

## Creata e clean summary table with the mean values for each variable
library(plyr)
dfrm_avg<-ddply(dfrm_sel_melt, .(subject,activity,variable),summarize, mean=mean(value))

## Save the clean dataset

write.table(dfrm_avg, file="clean_data.txt", sep="\t")
