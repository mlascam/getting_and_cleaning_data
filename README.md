# getting_and_cleaning_data
 Repository that allocates my final work of Getting and Cleaning Data Course\
 from Coursera.
 
## Files
* `CodeBook.md` a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

* `run_analysis.R` performs the data preparation and then followed by the 5 steps required as described in the course project’s definition:

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set.
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and     each subject.

zipped data file was downloaded from the following link: [Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)\

* `FinalData.txt` is the exported final data after going through all the sequences described above.

## Output
The output of the 5th step is called `FinalData.txt`, and uploaded in the course project's form.

## Variables
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
