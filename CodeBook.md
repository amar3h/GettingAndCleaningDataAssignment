### Code Book

### Introduction
This document desribes the code and data sets within run_analysis.R. This package downloads and tidies a Human Activity Recognition Using Smartphones Data Set from the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Abstract from the study: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Much more information surrounding the study may be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The code is split into the following sections:
1) Download zip file
2) Unzip file
3) Prepare file paths for importing
4) Read data into data frames
5) Add column headers
6) Merge the training and the test sets to create one data set
7) Extract only the measurements on the mean and standard deviation for each measurement
8) Uses descriptive activity names to name the activities in the data set
9) Appropriately labels the data set with descriptive variable names. 
10) Creates a second, independent tidy data set with the average of each variable for each activity and each subject
11) Create the text file  

### Download zip file

    Downloads the file locally if the file does not exist locally.
    
    Variables:
        fileUrl             - path of the source file
        fileDir             - path of the destination folder
        zipFileLocation     - path of the destination file   

    Functions:
        file.exists         - determines whether or not the file exists
        download.file       - downloads the file from source to target

### Unzip file

    Unzips the zip file if the zip file has not been already unzipped.
    
    Variables:
        fileLocation        - path of the destination folder for the zipped contents (./UCI HAR Dataset)
        zipFileLocation2    - path of the destination folder
        zipFileLocation     - full path of the destination file  

    Functions:
        file.exists         - determines whether or not the file exists
        unzip               - unzips the file and its contents
        
### Prepare file paths for importing

    Assigns file path names.  Examples below.

    x_test_path             <- file.path(fileLocation,"test/x_test.txt")
    x_train_path            <- file.path(fileLocation,"train/x_train.txt")

    Variables:
        x_test_path             - path of the x_test.txt file
        x_train_path            - path of the x_train.txt file
        features_headers_path   - path of the features.txt file
        y_test_path             - path of the y_test.txt file
        y_train_path            - path of the y_train.txt file
        subject_test_path       - path of the subject_test.txt file
        subject_train_path      - path of the subject_train.txt file
    
    Functions:
        file.path           - combines variables and/or text to a single file path

### Read data into data frames
    Imports the data into data frames for usability later.

    Data frames:
        x_test                  - contains the data of the x_test.txt file
        x_train                 - contains the data of the x_train.txt file
        features_headers        - contains the data of the features.txt file
        y_test                  - contains the data of the y_test.txt file
        y_train                 - contains the data of the y_train.txt file
        subject_test            - contains the data of the subject_test.txt file
        subject_train           - contains the data of the subject_train.txt file
    
    Functions:
       read.table              - imports the contents of a file into a data frame

    Example data - head(features_headers)
    
      V1                V2
1  1 tBodyAcc-mean()-X
2  2 tBodyAcc-mean()-Y
3  3 tBodyAcc-mean()-Z
4  4  tBodyAcc-std()-X
5  5  tBodyAcc-std()-Y
6  6  tBodyAcc-std()-Z

    Example data - head(x_train)
    
 tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
1         0.2885845       -0.02029417        -0.1329051       -0.9952786
2         0.2784188       -0.01641057        -0.1235202       -0.9982453
3         0.2796531       -0.01946716        -0.1134617       -0.9953796
4         0.2791739       -0.02620065        -0.1232826       -0.9960915
5         0.2766288       -0.01656965        -0.1153619       -0.9981386
6         0.2771988       -0.01009785        -0.1051373       -0.9973350
  tBodyAcc-std()-Y tBodyAcc-std()-Z tBodyAcc-mad()-X tBodyAcc-mad()-Y
1       -0.9831106       -0.9135264       -0.9951121       -0.9831846
2       -0.9753002       -0.9603220       -0.9988072       -0.9749144
3       -0.9671870       -0.9789440       -0.9965199       -0.9636684
4       -0.9834027       -0.9906751       -0.9970995       -0.9827498
5       -0.9808173       -0.9904816       -0.9983211       -0.9796719
6       -0.9904868       -0.9954200       -0.9976274       -0.9902177
  tBodyAcc-mad()-Z tBodyAcc-max()-X tBodyAcc-max()-Y tBodyAcc-max()-Z
1       -0.9235270       -0.9347238       -0.5673781       -0.7444125
    
### Add column headers - note: performed portions of step 4 out of order to make step 2 easier.
    Adds column headers for easier understanding of the data

    Name of the subject file column name is "SubjectID"
    Names of the "x" file column name are assigned from the 2nd column of the features_headers data frame
    Name of the "y" file column name is "Activity"

    Functions:
       names                - assigns the column header names to the data frames
       
### Step #1 of project instructions - Merge the training and the test sets to create one data set
    Combines the training and test individual data sets into 2 data sets (training and test)
        and finally into 1 (merged)

    Data frames:
        test                - contains the test data 
        train               - contains the training data
        merged              - contains the combined data from both sets

    Functions:
       cbind                - Take a sequence of vector, matrix or data frames arguments and combine by columns       
       rbind                - Take a sequence of vector, matrix or data frames arguments and combine by rows 

### Step #2 of project - Extract only the measurements on the mean and standard deviation for each measurement
    Extracts only the measurements of the mean and standard deviation for each measurement from the merged data set
        while keeping the StudentID and Activity columns

    Data frames:
        meanStdDev          - logical vector applied to the merged data set to only include the mean and std dev

    Functions:
       grepl                - grepl returns a logical vector (match or not for each element of x).        
       names                - assigns the column header names to the data frames

### Step #3 of project -  Uses descriptive activity names to name the activities in the data set 
    Uses descriptive activity names to name the activities in the data set 

    Functions:
       factor               - The function factor is used to encode a vector as a factor (the terms 'category' and                                    'enumerated type' are also used for factors). If argument ordered is TRUE, the 
                                factor levels are assumed to be ordered. 

    Factor Names = "WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"    
    
### Step #4 of project -  Appropriately labels the data set with descriptive variable names. 
    Renames t an f to Time and Frequency, etc. to make the column names more readable.

    Functions:
       names                - assigns the column header names to the data frames
       gsub                 - similar to grepl except actually does the replacement
    
    Actions taken:                            
    names(merged)   <- gsub("^t", "Time ", names(merged))
    names(merged)   <- gsub("^f", "Frequency ", names(merged))    
    names(merged)   <- gsub("Body", "Body ", names(merged))
    names(merged)   <- gsub("Energy", " Energy ", names(merged))
    names(merged)   <- gsub("std", " StdDev ", names(merged))
    names(merged)   <- gsub("Mean", " Mean ", names(merged))
    names(merged)   <- gsub("mean", " Mean ", names(merged))
    names(merged)   <- gsub("-", "", names(merged))
    
### Step #5 of project - creates a second, independent tidy data set with the average of each variable 
###    for each activity and each subject
    "Tidies"up the data and creates a text file.

    Functions:
        library             - loads the plyr library
        tidy1               - user-defined function to combine the average of each variable
                                for each activity and each subject
        ddply               - For each subset of a data frame, apply function then combine results into a data frame.         names               - assigns the column header names to the data frames
        write.table         - writes the data frame to a file.
        
        header(tidyFinal)
        
         SubjectID           Activity MeanTime Body Acc Mean ()X MeanTime Body Acc Mean ()Y MeanTime Body Acc Mean ()Z
1         1            WALKING                  0.2773308               -0.017383819                 -0.1111481
2         1   WALKING_UPSTAIRS                  0.2554617               -0.023953149                 -0.0973020
3         1 WALKING_DOWNSTAIRS                  0.2891883               -0.009918505                 -0.1075662
4         1            SITTING                  0.2612376               -0.001308288                 -0.1045442
5         1           STANDING                  0.2789176               -0.016137590                 -0.1106018
6         1             LAYING                  0.2215982               -0.040513953                 -0.1132036
  MeanTime Body Acc StdDev ()X MeanTime Body Acc StdDev ()Y MeanTime Body Acc StdDev ()Z MeanTime GravityAcc Mean ()X
1                  -0.28374026                  0.114461337                  -0.26002790                    0.9352232
2                  -0.35470803                 -0.002320265                  -0.01947924                    0.8933511
3                   0.03003534                 -0.031935943                  -0.23043421                    0.9318744
4                  -0.97722901                 -0.922618642                  -0.93958629                    0.8315099
5                  -0.99575990                 -0.973190056                  -0.97977588                    0.9429520
6                  -0.92805647                 -0.836827406                  -0.82606140                   -0.2488818
  MeanTime GravityAcc Mean ()Y MeanTime GravityAcc Mean ()Z MeanTime GravityAcc StdDev ()X MeanTime GravityAcc StdDev ()Y
1                   -0.2821650                  -0.06810286                     -0.9766096                     -0.9713060
2                   -0.3621534                  -0.07540294                     -0.9563670                     -0.9528492
3                   -0.2666103                  -0.06211996                     -0.9505598                     -0.9370187
4                    0.2044116                   0.33204370                     -0.9684571                     -0.9355171
5                   -0.2729838                   0.01349058                     -0.9937630                     -0.9812260
6                    0.7055498                   0.44581772                     -0.8968300                     -0.9077200
  MeanTime GravityAcc StdDev ()Z MeanTime Body AccJerk Mean ()X MeanTime Body AccJerk Mean ()Y MeanTime Body AccJerk Mean ()Z
1                     -0.9477172                     0.07404163                   0.0282721096                   -0.004168406
2
        