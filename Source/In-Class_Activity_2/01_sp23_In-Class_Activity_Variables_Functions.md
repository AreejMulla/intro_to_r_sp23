01_In-Class_Activity-01
================
Naga Vemprala
2023-01-26

``` r
source("HelperFunctions.R")
```

## First in-class activity on R objects.

#### Question: 1

    ## [1] "Gender variable before calling function"

    ## [1] "----------------------------------------"

    ## [1] Female Male  
    ## Levels: Male Female

    ## [1] "----------------------------------------"

    ## [1] "Gender variable After calling function"

    ## [1] "----------------------------------------"

    ## [1] Female Male   Other 
    ## Levels: Male Female Other

#### Question: 2

``` r
# Vector 1 - Create a numeric vector of length 5 with the course ids 101, 255, 355, 461, 491
vector1 <- c(101, 255, 355, 461, 491)

# Vector 2 - Create a character character vector of length 5 and provide the course titles for these 5 courses as, "Software Applications", "Introduction to OTM", "Decision Modeling and Analytics", "R Programming for Business and Analytics", "Intro to Text Analytics".
vector2 <- c("Software Applications", "Introduction to OTM",
             "Decision Modeling and Analytics",
             "R Programming for Business and Analytics",
             "Intro to Text Analytics")

# Vector 3 - Create a first day of class vector (Make sure that this vector is a date vectors)
vector3 <- c("2023-01-16", "2023-01-17", "2023-01-18", "2023-01-19", "2023-01-20")
vector3 <- as.Date(vector3)#better to do this when I create data frame and then df1$vector3 <- as.Date(df1$vector3)

# Vector 4 - Create a start time vector (Make sure that this vector is a time vectors)
# Include date and time e.g., "2023-01-16 14:10:00"
vector4 <- c("2023-01-16 14:10:00", "2023-01-17 15:10:00", "2023-01-18 15:10:00", "2023-01-19 17:10:00", "2023-01-20 14:10:00")
vector4 <- as.Date(vector4)#better to do this when I create data frame and then df1$vector4 <- as.Date(df1$vector4)

# Vector 5 - Create a end time vector (Make sure that this vector is a time vectors)
vector5 <- c("2023-01-16 16:55:00", "2023-01-17 17:55:00", "2023-01-18 17:55:00", "2023-01-19 19:55:00", "2023-01-20 16:55:00") 
  
# Vector 6 - Create a class frequency vector (a numerical vector, 1 represents the class meets once a week, 2 represents the class meets twice a week, etc.)
vector6 <- c(1L, 2L, 1L, 1L, 2L)
  
# Vector 7 - Create a class frequency character vector (R for Thursday, MWF for Monday-Wednesday-Friday class etc)
vector7 <- c("R", "MWF", "TR", "W", "TR")

# Create a data frame using these above vectors
 df1 <- data.frame(vector1, vector2, vector3, vector4, vector5, vector6, vector7)
```

#### Question: 3

``` r
# Create a function to read the first day of class as string and the class frequency to return the next day of the class in the week. 
# Implement switch case instead of a sequence of if-else statements

next_class <- function (date_as_string, class_frequency) {
  next_date <- switch (class_frequency,
                       "M" = as.Date(date_as_string) + 7,
                       "MWF" = as.Date(date_as_string) + 2,
                       "TR" = as.Date(date_as_string) + 2,
                       "TF" = as.Date(date_as_string) + 3
                       )
                       
next_date
}
next_class("2023-01-16", "MWF")
```

    ## [1] "2023-01-18"
