#this is main function.run this function, it will follow the instructions of 
#course project: load the test and train data set and return the tidy data and
#create tidydata.txt
run_analysis <- function(directory) {
    dataset <- merge_data(directory)
    dataset <- extract_measurements(directory, dataset)
    dataset <- name_activities(directory, dataset)
    dataset <- name_variables(directory, dataset)
    create_data(dataset)
}

#load and merge data
merge_data <- function(directory) {
    #load data from test and train directory
    test <- read.table(file.path(directory, "test/X_test.txt"))
    train <- read.table(file.path(directory, "train/X_train.txt"))
    
    subject_test <- read.table(file.path(directory, "test/subject_test.txt"))
    y_test <- read.table(file.path(directory, "test/y_test.txt"))
    
    subject_train <- read.table(file.path(directory, "train/subject_train.txt"))
    y_train <- read.table(file.path(directory, "train/y_train.txt"))
    #add subject and activities to test and train set
    test <- cbind(subject_test, y_test, test)
    train <- cbind(subject_train, y_train, train)
    #merge the training and test set to one data set
    dataset <- rbind(test, train)
    names(dataset)[1:2] <- c("subject", "activities")
    return(dataset)
}
#extract measurements on mean and std
extract_measurements <- function(directory, dataset) {
    #load features
    features <- read.table(file.path(directory, "features.txt"))
    #get logical set match mean or std 
    logicalset <- grepl("(mean|std)\\(", features$V2)
    #include the subject and activities colunms
    logicalset <- c(TRUE, TRUE, logicalset)
    #extract measurements
    dataset <- dataset[, logicalset]
    return(dataset)
}
#use descriptive activity name to name the activities in the dataset
name_activities <- function(directory, dataset) {
    #first order the dataset on subject and activities 
    dataset <- arrange(dataset, dataset$subject, dataset$activities)
    #load labels
    labels <- read.table(file.path(directory, "activity_labels.txt"))
    #covert activities value to descriptive names
    dataset$activities <- labels$V2[dataset$activities]
    return(dataset)
}
#label the dataset variables with desciptive name
name_variables <- function(directory, dataset) {
    #remove subject and activities
    vnames <- colnames(dataset)
    vnames <- vnames[-c(1, 2)]
    #conert colnames of dataset to numeric vector
    vnames <- gsub("V", "", vnames)
    vnames <- as.numeric(vnames)
    #get feature names
    features <- read.table(file.path(directory, "features.txt"))
    fnames <- features$V2[vnames]
    #make fnames descriptive
    fnames <- gsub("\\(\\)", "", fnames)
    fnames <- make.names(fnames)
    names(dataset)[-c(1, 2)] <- fnames 
    return(dataset)
}
#create tidy data set with the average of each variable for each activity 
#and each subject. 
create_data <- function(dataset) {
    tidydata <- aggregate(dataset[, -c(1, 2)], by=list(dataset$activities, dataset$subject),
                          FUN=mean)
    names(tidydata)[1:2] <- c("activities", "subject")
    write.table(tidydata, file="tidydata.txt")
    return(tidydata)
}