library(data.table)
setwd("C:/Users/uphilli/Documents/R/coursera")

# read all files needed for analysis
train_set <- as.data.table(read.table("./UCI HAR Dataset/train/X_train.txt"))
test_set <- as.data.table(read.table("./UCI HAR Dataset/test/X_test.txt"))
feature <-  fread("./UCI HAR Dataset/features.txt")
train_labels <- fread("./UCI HAR Dataset/train/Y_train.txt")
test_labels <- fread("./UCI HAR Dataset/test/Y_test.txt")
train_subject <- fread("./UCI HAR Dataset/train/subject_train.txt")
test_subject <- fread("./UCI HAR Dataset/test/subject_test.txt")
activity <- fread("./UCI HAR Dataset/activity_labels.txt")

#keep only mean and STD columns of the train and test data
features_to_keep <- feature[V2 %like% "mean" | V2 %like% "std"]
flist <- as.list(features_to_keep)
train_new <- train_set[,flist$V1,with=FALSE]
test_new <- test_set[,flist$V1,with=FALSE]

#make column names for train and test data from the features list
set_colnames <- function(dataset,colnum) { 
    newname <- features_to_keep[colnum]$V2
    setnames(dataset,colnum,newname)
     }
train_new <- set_colnames(dataset = train_new, colnum = 1:79) 
test_new <- set_colnames(dataset = test_new, colnum = 1:79) 

#Clean up the column names in the Activity data
setnames(activity,1,"Activity_code")
setnames(activity,2,"Activity")

#merge train and test sets with the subject number and activity
train_complete <- cbind(train_subject, train_labels, train_new)
test_complete <- cbind(test_subject, test_labels, test_new)

#combine the train and test sets
complete_set <- as.data.table(rbind(train_complete, test_complete))

#add in activity names
setnames(complete_set,1,"Subject")
setnames(complete_set,2,"Activity_code")
setkey(complete_set, "Activity_code")
setkey(activity,"Activity_code")
complete_2 <- merge(activity, complete_set, all.y = TRUE)

#average by Activity and Subject 
complete_3 <- complete_2[,lapply(.SD, mean), by = c("Subject","Activity")]
complete_3 <- complete_3[order(Subject,Activity_code)]

#output the data
write.table(complete_3,"./coursera/tidy_data.txt",row.name = FALSE)
