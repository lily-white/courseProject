### Course Project Of The Get And Clean Data

   This repository is for the course project of the get and clean data on the coursera.
  
   There is one script for the project : run_analysis.R. This script has six function, but run_analysis is the main function. You will only need to run this main function , it will call other five function which implement the five steps in the instructions. run_analysis function need a parameter which is the directory of "FUCI HAR Data". 
  
   The main function will return a tidy data with the average of each variable for each activity and each subject, and will save this data set as "tidydata.txt". Subject variable represent the volunteers' number, and activities variable represents six activities(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).I have transformed the activities variable's value from integers to labels. The other variables are mean and standard derivation for measurement, and I have changed their names to desciptive names. For example "tBodyAcc.mean.X", this name is the mean value of the body acceleration in time domain at X direction, the prefix "t" represents "time", and the abbreviation "Acc" means "Acceleration".
  
   ps: my English is not good, if anything wrong ,please correct me, thank you~
