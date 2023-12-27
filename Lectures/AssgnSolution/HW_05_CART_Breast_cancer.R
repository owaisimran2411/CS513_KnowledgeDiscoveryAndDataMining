#########################################################
##  Purpose: Create CART classification tree
##  Developer: KD         
##
#########################################################

#########################################################
##  Step 0: Clear the environment
##           
##
#########################################################
rm(list=ls())


#########################################################
##  Step 1: Load the relavent packages
##           
##
#########################################################

 
file<-file.choose()
bc <-  read.csv(file,
                   na.strings = "?",
                   colClasses=c("Sample"="character",
                                "F1"="factor","F2"="factor","F3"="factor",
                                "F4"="factor","F5"="factor","F6"="factor",
                                "F7"="factor","F8"="factor","F9"="factor",
                                "Class"="factor"))







#install.packages("rpart")
#install.packages("rpart.plot")     # Enhanced tree plots
#install.packages("rattle")         # Fancy tree plot
#install.packages("RColorBrewer")   # colors needed for rattle
library(rpart)
library(rpart.plot)  			# Enhanced tree plots
library(rattle)           # Fancy tree plot
library(RColorBrewer)     # colors needed for rattle
set.seed(555)
#dsn2<-data.frame(lapply(dsn[,-1],as.factor))
index<-sort(sample(nrow(bc),round(.30*nrow(bc ))))
training<-bc[-index,]
test<-bc[index,]

?rpart()
#Grow the tree 


CART_class<-rpart( Class~.,data=training[,-1])
rpart.plot(CART_class)
CART_predict2<-predict(CART_class,test, type="class")
df<-as.data.frame(cbind(test,CART_predict2))
conf_tbl<-table(Actual=test[,"Class"],CART=CART_predict2)


CART_wrong<-sum(test[,"Class"]!=CART_predict2)

error_rate1=CART_wrong/length(test$Class)
accuracy=1-error_rate1;

dev.off()

conf_tbl_M<-as.matrix(conf_tbl)
TP=conf_tbl_M[2,2]
TN=conf_tbl_M[1,1]
FP=conf_tbl_M[1,2]
FN=conf_tbl_M[2,1]

#most_frequent  accuracy
most_frequent_accuracy<-max((TP+FN)/(TP+TN+FP+FN),(TN+FP)/(TP+TN+FP+FN)); print(most_frequent_accuracy)

#	Accuracy:(true positives + true negatives)
#       / (true positives + false positives + true negatives + false negatives).
accuracy<-(TP+TN)/(TP+TN+FP+FN);   print(accuracy)
error_rate<-(FP+FN)/(TP+TN+FP+FN); print(error_rate)
#Precision:true positives / (true positives + false positives).
precision<- TP/(TP+FP);             print(precision)
#Specificity: true negatives / (true negatives + false positives)
specificity<- TN/(TN+FP); print(specificity)
#Recall: true positives / (true positives + false negatives)
recall<-TP/(TP+FN); print(recall)
#F1 score: 2 * (precision * recall) / (precision + recall).
f1<- 2*(precision*recall)/(precision+recall); print(f1)



