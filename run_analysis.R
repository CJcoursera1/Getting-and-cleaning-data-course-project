########## 
# "Getting and cleaning data" course assignment.
# To work the script must be executed while the 
# working directory is UCI HAR Sataset
# required packages: reshape2, plyr
##########

##########
#1. Merge the training and the test sets to create one data set
##########

# Load the necessary files in R:

# Load the test data:
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/y_test.txt")

# Load the training data:
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
Y_train <- read.table("train/y_train.txt")

# Combine the training and test data
test_data <- cbind(subject_test, Y_test, X_test)
train_data <- cbind(subject_train, Y_train, X_train)

data <- rbind(train_data, test_data)

# Remove the variables the will no longer be needed
rm(subject_test, subject_train, X_test, X_train, Y_test, Y_train, test_data, train_data)

##########
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##########

features <- read.table("features.txt", stringsAsFactors = FALSE)
#features[,2] <- sapply(features[,2], as.character)


good <- grepl("-mean()", features[,2], fixed = TRUE) | grepl("-std()", features[,2], fixed = TRUE)
positions = which(good)
data <- data[c(1,2,positions+2)]

# We remove the positions from the workspace
# Notice that we do not remove features or good as we will need them in step 4.
rm(positions)

##########
# 3. Uses descriptive activity names to name the activities in the data set
##########

# A function that converts the activity labels to a descriptive name
convert <- function(x){
    
    if(x == 1) return("Walking")
    if(x == 2) return("Walking upstairs")
    if(x == 3) return("Walking downstairs")
    if(x == 4) return("Sitting")
    if(x == 5) return("Standing")
    if(x == 6) return("Laying")
    
    print("Error")
    return -1
}

data[,2] = sapply(data[,2], convert)

rm(convert)

##########
# 4. Appropriately labels the data set with descriptive variable names.
##########

# Appropriate column names are extracted directly from the features
colnames(data) <- c("Subject", "Activity", features[,2][good])

# Now we are finished with these variables we can remove them 
rm(features, good)

##########
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
##########

library(reshape2)
meltdata <- melt(data, id=c("Subject", "Activity"))


library(plyr)
tidy_data <- ddply(meltdata, .(Subject, Activity, variable), summarize, mean=mean(value))  

write.table(tidy_data, file = "tidy_output.txt", row.names = FALSE)

rm(meltdata)

   