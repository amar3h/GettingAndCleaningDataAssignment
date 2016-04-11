runAnalysis <- function() {
    # Download zip file
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?accessType=DOWNLOAD"
    
    fileDir <- "./data"
    
    zipFileLocation <- file.path(fileDir,"humanActivityRecognition.zip")
    if (!file.exists(zipFileLocation)) {
        download.file (fileUrl, destfile = "./data/humanActivityRecognition.zip",mode="wb")    
    }
    
    # Unzip file
    fileLocation <- "./UCI HAR Dataset"
    zipFileLocation2 <- "./data/humanActivityRecognition.zip"
    
    if(!file.exists(fileLocation)) {
        unzip(zipFileLocation2, exdir = ".")
    }
    
    # Prepare file paths for importing
    x_test_path             <- file.path(fileLocation,"test/x_test.txt")
    x_train_path            <- file.path(fileLocation,"train/x_train.txt")
    features_headers_path   <- file.path(fileLocation,"features.txt")
    y_test_path             <- file.path(fileLocation,"test/y_test.txt")
    y_train_path            <- file.path(fileLocation,"train/y_train.txt")
    subject_test_path       <- file.path(fileLocation,"test/subject_test.txt")
    subject_train_path      <- file.path(fileLocation,"train/subject_train.txt")
    
    # Read data into data frames
    x_test              <- read.table(x_test_path)
    x_train             <- read.table(x_train_path)
    features_headers    <- read.table(features_headers_path)
    y_test              <- read.table(y_test_path)
    y_train             <- read.table(y_train_path)
    subject_test        <- read.table(subject_test_path)
    subject_train       <- read.table(subject_train_path)
    
    # Add column headers - note: performed portions of step 4 out of order to make step 2 easier. 
        # Step #4 - Appropriately labels the data set with descriptive variable names.
    names(subject_train)    <- "SubjectID"
    names(subject_test)     <- "SubjectID"
    
    names(x_train)  <- features_headers$V2 
    names(y_train)  <-"Activity"
    names(x_test)   <- features_headers$V2 
    names(y_test)   <- "Activity"
    
    # Step #1 of project - Merge the training and the test sets to create one data set
    train   <- cbind(subject_train,y_train, x_train)
    test    <- cbind(subject_test,y_test, x_test)
    merged  <- rbind(train, test)
    
    # Step #2 of project - Extract only the measurements on the mean and standard deviation for each measurement
    meanStdDev <- grepl("mean\\(\\)", names(merged)) | grepl("std\\(\\)", names(merged))
    
        # Keep StudentID and  Activity columns
        meanStdDev[1:2] = TRUE
        
        # Extract the rest
        merged <- merged[, meanStdDev]
        
    # Step #3 - Uses descriptive activity names to name the activities in the data set       
        merged$Activity <- factor(merged$Activity, labels = c("WALKING","WALKING_UPSTAIRS",
                                              "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

    # Step #4 - Appropriately labels the data set with descriptive variable names. (the rest)
    names(merged)   <- gsub("^t", "Time ", names(merged))
    names(merged)   <- gsub("^f", "Frequency ", names(merged))    
    names(merged)   <- gsub("Body", "Body ", names(merged))
    names(merged)   <- gsub("Energy", " Energy ", names(merged))
    names(merged)   <- gsub("std", " StdDev ", names(merged))
    names(merged)   <- gsub("Mean", " Mean ", names(merged))
    names(merged)   <- gsub("mean", " Mean ", names(merged))
    names(merged)   <- gsub("-", "", names(merged))
                
    # Step #5 of project - creates a second, independent tidy data set with the average of each variable 
    #    for each activity and each subject
    library("plyr")  

        # Create the data set with the average of each variable for each activity and each subject.
        tidy1 <- function(input) {
            colMeans(input[,-c(1,2)])
        } 
        
        tidyFinal <- ddply(merged,.(SubjectID, Activity), tidy1)    
    
        names(tidyFinal)[-c(1,2)] <- paste0("Mean", names(tidyFinal)[-c(1,2)])
        
    # Create the text file    
    write.table(tidyFinal,"tidy.txt",row.names=FALSE)    
}