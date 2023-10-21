library(dplyr)

# paths
xtestpath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/test/X_test.txt"

ytestpath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/test/y_test.txt"

subjecttestpath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/test/subject_test.txt"

xtrainpath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/train/X_train.txt"

ytrainpath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/train/y_train.txt"

subjecttrainpath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/train/subject_train.txt"

featurespath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/features.txt"

activitylabelspath <- "/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project/UCI HAR Dataset/activity_labels.txt"

# tables
features <- read.table(featurespath)
features$V2 <- gsub("\\(|\\)", "", features$V2)
features$V2 <- gsub("-", "_", features$V2)
features$V2 <- gsub(",", "_", features$V2)
features$V2 <- gsub("BodyBody", "Body", features$V2)
features$V2 <- gsub("Body", "Body_", features$V2)
features$V2 <- gsub("Mag", "Magnitude", features$V2)
features$V2 <- gsub("mean", "Mean", features$V2)
features$V2 <- gsub("std", "Std", features$V2)
columnnames <- features[,2]
rm(features)


# test population
xtest <- read.table(xtestpath)
colnames(xtest) <- columnnames

ytest <- read.table(ytestpath)
colnames(ytest) <- "activity_code"
activitylabels <- read.table(activitylabelspath)
colnames(activitylabels) <- c("activity_code", "activity_name")
ytest <- merge(ytest, activitylabels, by = "activity_code")

subjecttest <- read.table(subjecttestpath)
colnames(subjecttest) <- "subject"



xytest <- cbind(xtest, ytest, subjecttest)
rm(xtest, ytest, subjecttest)

# train population
xtrain <- read.table(xtrainpath)
colnames(xtrain) <- columnnames
rm(columnnames)

ytrain <- read.table(ytrainpath)
colnames(ytrain) <- "activity_code"
ytrain <- merge(ytrain, activitylabels, by = "activity_code")
rm(activitylabels)

subjecttrain <- read.table(subjecttrainpath)
colnames(subjecttrain) <- "subject"


xytrain <- cbind(xtrain, ytrain, subjecttrain)
rm(xtrain, ytrain, subjecttrain)

xytable <- rbind(xytest, xytrain)
rm(xytest, xytrain)

xytable_mean_std <- xytable %>% 
  select(matches("mean|std|subject|activity_name"))

rm(xytable)

xytable_mean_std <- xytable_mean_std %>% 
  mutate(activity_name = factor(activity_name, levels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))

xytable_summary <- xytable_mean_std %>%
  group_by(activity_name, subject) %>%
  summarise_all(mean)

setwd("/Users/loschichis/Library/CloudStorage/OneDrive-Personal/Max/Programming/Coursera/R/Getting and Cleaning Data/Final Project")

write.table(xytable_summary, file = "xytable_summary.txt", row.names = FALSE)
write.table(xytable_mean_std, file = "xytable_mean_std.txt", row.names = FALSE)

