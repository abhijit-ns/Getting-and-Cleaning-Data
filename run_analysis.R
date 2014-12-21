## Read the List of Feature
Feature_Vector <- read.table("./UCI HAR Dataset/features.txt")
Feature_List <-Feature_Vector[,2]

## Read the Activity Lables
Activity_Label <- read.table("./UCI HAR Dataset/activity_labels.txt",
                             header = FALSE,
                             col.names = c("Activity_ID","Activity_Name"))

## Read and Merge all the Training Data to create Train_DF

## Read the Training Set with Feature List as Header
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                      header = FALSE, 
                      col.names = Feature_List)

Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", 
                      header = FALSE, 
                      col.names = "Activity_ID")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                      header = FALSE, 
                      col.names = "Subject")

Train_DF <- cbind(subject_train,cbind(Y_train,X_train))

## Read and Merge all the Test Data to create Test_DF

## Read the Test Set with Feature List as Header
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                      header = FALSE, 
                      col.names = Feature_List)

Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", 
                      header = FALSE, 
                      col.names = "Activity_ID")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                            header = FALSE, 
                            col.names = "Subject")

Test_DF <- cbind(subject_test,cbind(Y_test,X_test))

## Append Training and Test files 
Merge_DF <- rbind(Train_DF,Test_DF)

## Select Only the Mean and Standard Deviation columns , along with Activity_ID and Subject 
MeanandSTD <- Merge_DF[,c("Activity_ID","Subject",colnames(Merge_DF)[grep("mean|std",colnames(Merge_DF))])]

## Add the Activity Laben to the data set
mergedData2 = merge(Activity_Label,MeanandSTD,all=TRUE)

## Create the average data of all the measurements for each subject , each activity 
cdata.means <- aggregate(mergedData2[4:69], 
                         by = mergedData2[c("Activity_Name", "Subject")], FUN=mean)

##Write to output file
write.table(cdata.means, "./UCI HAR Dataset/Mean_Subject_Activity.txt", sep="\t",row.name=TRUE)