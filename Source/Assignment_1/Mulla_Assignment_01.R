# Read the CSV file data into an R data frame
file_name <- paste(getwd(), "/Source/", "/Assignment_1/",
                   "HW1.csv",
                   sep = "")
df1 <- read.csv(file_name)

#### Question 1

# Convert "Start_Time" and "End_Time" columns to a date and time (in hrs & mins)
library(lubridate)
df1$Start_Time <- ymd_hm(df1$Start_Time)
df1$End_Time <- ymd_hm(df1$End_Time)

#' Create a class duration in minutes column by finding the difference
#' between the start time and end time
df1$Class_Duration <- difftime(df1[,6], df1[,5], units= "mins")


#### Question 2 

# Create a function that rounds the class frequency to the nearest week
next_day_of_class <- function(class_frequency) {
  numeric_frequency <- switch(class_frequency, 
                              "M" = 1,
                              "T" = 2,
                              "W" = 3,
                              "R" = 4,
                              "F" = 5,
                              "MWF" = 1,
                              "TR" = 2,
                              "TF" = 2)
  
# Round the class frequency of the semester to the nearest week         
  next_class <- round_date(
    as.Date("2023-01-16"),
    unit = "week",
    week_start = getOption("lubridate.week.start", numeric_frequency)
  )
  next_class 
}

#' Create a loop to add a late start column that contains logical values
#' of whether the classes started late, by comparing the class frequency
#' to the start date
for (i in 1:nrow(df1)) {
  df1[i, "Late_Start"] <- (next_day_of_class(df1[i, "Class_Frequency"])
                             < as.Date(df1[i, "Start_Date"]))
}

#### Question 3 

# Create a function to read the weekday of the class frequency
first_class <- function(class_frequency) { 
  first_day <- switch(class_frequency, 
                      "M" = "Monday",
                      "T" = "Tuesday",
                      "W" = "Wednesday",
                      "R" = "Thursday",
                      "F" = "Friday",
                      "MWF" = "Monday",
                      "TR" = "Tuesday",
                      "TF" = "Tuesday")
  first_day                
}

#' Create a loop to add a mismatching schedule column that contains logical
#' values of whether there are discrepancies between the class start date
#' and the class frequency
for (i in 1:nrow(df1)) {
  if (first_class(df1[i,7]) == weekdays(as.Date(df1[i,"Start_Date"], abbreviate = TRUE))) {
    df1[i,"Mismatching_Schedule"] <- FALSE
  } else {
    df1[i,"Mismatching_Schedule"] <- TRUE
  }
}

#### Question 4

#' Create a function to extract the class day and time based on the user's
#' input and store the output in a new data frame
extract_class_schedule <- function(class_time=0, 
                                   before_after=0,
                                   class_frequency=0, 
                                   class_start_day=0){
  if ((class_time !=0) && (before_after !=0)) {
    if (before_after == "after") {
      df3 <- df1[hour(df1$Start_Time) >= class_time,]
    } else { 
      df3 <- df1[hour(df1$Start_Time) < class_time,]
    }
  } else if (class_frequency != 0) {
    df3 <- df1[df1$Class_Frequency == class_frequency,]
  } else if (class_start_day != 0){
    df3 <- df1[df1$Start_Date == class_start_day,]
  }
  df3
}
#' Extract the class schedule based on the provided class time and whether
#' it's before or after the provided time
df3 <- extract_class_schedule(class_time = 12, before_after = "after")

# Extract the class schedule based on the provided class frequency
df3 <- extract_class_schedule(class_frequency = "M")

# Extract the class schedule based on the provided class start date
df3 <- extract_class_schedule(class_start_day = "2023-01-19")

