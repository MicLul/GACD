# Unzipping data
unzip("getdata-projectfiles-UCI HAR Dataset.zip", files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)
 
# Merging test and training sets into one data set
df0 <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
df1 <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
df2 <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
df3 <- cbind(df0, df1, df2)
df4 <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
df5 <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
df6 <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
df7 <- cbind(df4, df5, df6)
df8 <- rbind(df3, df7)
 
# Assigning variable names to data set
df9 <- read.table("UCI HAR Dataset/features.txt")
df10 <- rbind(df9, cbind(562, "activity"), cbind(563, "subject"))
df11 <- t(df10)
names(df8) <- df11[2,1:563]
 
# Extracting only measurement on the mean and standard deviation
df12 <-df8[,grep("mean|Mean|std|activity|subject", colnames(df8))]
 
# Assigning descriptive activity names to activities
df12$activity[df12$activity==1] <- "WALKING"
df12$activity[df12$activity==2] <- "WALKING_UPSTAIRS"
df12$activity[df12$activity==3] <- "WALKING_DOWNSTAIRS"
df12$activity[df12$activity==4] <- "SITTING"
df12$activity[df12$activity==5] <- "STANDING"
df12$activity[df12$activity==6] <- "LAYING"

# Creating second, independent tidy data set with the average of each variable for each activity and each subject
df12melt <- melt(df12,id=c("activity","subject"))
df12cast <- dcast(df12melt, activity + subject ~ variable, mean)

# Writing tidy data sets to files
write.table(df12, file = "tidy1.txt")
write.table(df12cast, file = "tidy2.txt")