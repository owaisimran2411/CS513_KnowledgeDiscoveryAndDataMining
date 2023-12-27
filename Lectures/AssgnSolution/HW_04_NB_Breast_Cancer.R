#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Apply naive bayes to the breast cancer data 
#                   :  
#  Creation date    : 
dev.off()
rm(list=ls())
file<-file.choose()
bc_raw<-  read.csv(file,
           na.strings = "?",
           colClasses=c("Sample"="character",
                        "F1"="factor","F2"="factor","F3"="factor",
                        "F4"="factor","F5"="factor","F6"="factor",
                        "F7"="factor","F8"="factor","F9"="factor",
                        "Class"="factor"))


#bc_raw<-
#  read.csv("C://AIMS/Stevens_/2019_S_CS513/Raw_data/breast-cancer-wisconsin.data.csv",
#           na.strings = "?",
#           colClasses=c("Sample"="character",
#                        "F1"="factor","F2"="factor","F3"="factor",
#                        "F4"="factor","F5"="factor","F6"="factor",
#                        "F7"="factor","F8"="factor","F9"="factor",
#                        "Class"="factor"))



is.factor(bc_raw$F1)
bc<-na.omit(bc_raw)
set.seed(444)
idx<-sort(sample(nrow(bc),as.integer(.70*nrow(bc))))

training<-bc[idx,]

test<-bc[-idx,]

#install.packages('e1071', dependencies = TRUE)

library(e1071)


nBayes <- naiveBayes(factor(Class)~., data =training[,-1])

## Naive Bayes classification using all variables 

category_all<-predict(nBayes,test[,-1]  )


conf_tbl<-table(Actual=test$Class,NBayes=category_all)
NB_wrong<-sum(category_all!=test$Class )
NB_error_rate<-NB_wrong/length(category_all)
NB_error_rate

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


