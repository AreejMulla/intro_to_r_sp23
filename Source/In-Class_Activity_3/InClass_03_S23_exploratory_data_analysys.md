
## Exploratory Data Analysis

<style>
p.blue_box {
  background-color: #4955a1;
  color: #FFFFFF;
  padding: 10px;
  border: 1px solid blue;
  margin-left: 25px;
  border-radius: 5px;
  font-style: normal;
}

p.heading {
  background-color: #a19549;
  margin: auto;
  width: 80%;
  padding: 5px;
  font-style: bold;
}

p.regular {
  margin: auto;
  padding: 5px;
}

</style>
<p class="blue_box">
Data Science projects begin with the problem at hand, and then we
examine the available data. The available data should now assist us in
addressing the problem. If the data itself is incorrect or insufficient,
we must take a pause and either begin collecting additional data, new
and relevant data, or an entirely new dataset in order to solve the
problem. To determine if the data at hand is accurate, we will begin
with descriptive statistics to determine the range of data values, mean,
median, etc., followed by exploratory data analysis to determine the
relationship between variables. Various techniques are employed during
this analysis, beginning with the creation of visualizations, data
cleansing to remove missing values, imputation of missing data with
meaningful and close estimates, etc.
</p>

<br>

<p class="heading">
<b>Problem statement: Who are the prospective customers from the
available dataset who do not have health insurance and who should be
contacted by our marketing team?</b>
</p>

</br>

<p class="regular">

For this analysis, the data is assumed to be stored in a single data
frame. But, generally, the data is spread across multiple tables in a
normalized fashion (We are talking about the database normalization).

The original dataset used for this exploratory analysis is available at
the “Practical Data Science with R” author’s primary [github
repository](https://github.com/WinVector/PDSwR2)
</p>

``` r
getwd()
```

    ## [1] "C:/Users/areej/Desktop/Spring 2023/R Programming for Business & Analytics/intro_to_r_sp23/Source/In-Class_Activity_3"

-   Pay special attention to the missing values in the summary

``` r
#I can see how many missing values (NA's) through the summary and max and min
summary(customer_data)
```

    ##     custid              sex        is_employed         income       
    ##  Length:73262       Female:37837   Mode :logical   Min.   :  -6900  
    ##  Class :character   Male  :35425   FALSE:2351      1st Qu.:  10700  
    ##  Mode  :character                  TRUE :45137     Median :  26200  
    ##                                    NA's :25774     Mean   :  41764  
    ##                                                    3rd Qu.:  51700  
    ##                                                    Max.   :1257000  
    ##                                                                     
    ##             marital_status  health_ins     
    ##  Divorced/Separated:10693   Mode :logical  
    ##  Married           :38400   FALSE:7307     
    ##  Never married     :19407   TRUE :65955    
    ##  Widowed           : 4762                  
    ##                                            
    ##                                            
    ##                                            
    ##                        housing_type   recent_move      num_vehicles  
    ##  Homeowner free and clear    :16763   Mode :logical   Min.   :0.000  
    ##  Homeowner with mortgage/loan:31387   FALSE:62418     1st Qu.:1.000  
    ##  Occupied with no rent       : 1138   TRUE :9123      Median :2.000  
    ##  Rented                      :22254   NA's :1721      Mean   :2.066  
    ##  NA's                        : 1720                   3rd Qu.:3.000  
    ##                                                       Max.   :6.000  
    ##                                                       NA's   :1720   
    ##       age               state_of_res     gas_usage     
    ##  Min.   :  0.00   California  : 8962   Min.   :  1.00  
    ##  1st Qu.: 34.00   Texas       : 6026   1st Qu.:  3.00  
    ##  Median : 48.00   Florida     : 4979   Median : 10.00  
    ##  Mean   : 49.16   New York    : 4431   Mean   : 41.17  
    ##  3rd Qu.: 62.00   Pennsylvania: 2997   3rd Qu.: 60.00  
    ##  Max.   :120.00   Illinois    : 2925   Max.   :570.00  
    ##                   (Other)     :42942   NA's   :1720

``` r
#To check if a vector contains an NA 
temp <- c(1, NA, -3, 5)
is.na(temp)
```

    ## [1] FALSE  TRUE FALSE FALSE

-   Now looking at the columns (from customer_data) that have huge
    variation, can we explore these columns for outliers?
-   For example, the mean value of gas_usage is 41 and the 3rd quartile
    has 60. However, there is a max value of 570. Do you think there are
    any outliers in the data?
-   Plot a boxplot and see the outliers?

``` r
#a boxplot will help identify outliers (displays descriptive stats)

#simple graph
#boxplot(customer_data$gas_usage)

library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 4.1.3

``` r
ggplot( data = customer_data) +
  geom_boxplot(mapping = aes(x = gas_usage))
```

    ## Warning: Removed 1720 rows containing non-finite values (`stat_boxplot()`).

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/boxplot1-1.png)<!-- -->

``` r
#1720 rows containing non-finite values were removed (outliers)
```

-   What is the spread of income? Is it normally spread? Draw a
    histogram.
-   set a limit on the income and see if the histogram looks better
-   You can include an income range from 0 to \$200,000
-   Use scales::dollar_format() to include the labels in dollars

``` r
#histogram plots frequency (to see if data is normally distributed)
#normal distribution: maximum numbers of samples are aligned at the mean (center point). Remaining observations are equally distribution to either side of the mean

#scale is used for formatting axes
# lims is part of scale layer so scale will override it
layer1 <- ggplot(data = customer_data)
layer1 + 
  geom_histogram(aes(x=income)) + 
  lims(x = c(0, 200000)) +
  scale_x_continuous(labels = scales::dollar_format(),
                    limits = c(0, 200000))
```

    ## 

    ## Scale for x is already present.
    ## Adding another scale for x, which will replace the existing scale.
    ## 
    ## 
    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 1471 rows containing non-finite values (`stat_bin()`).

    ## Warning: Removed 2 rows containing missing values (`geom_bar()`).

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/histogram-1.png)<!-- -->

``` r
# scale_x_continuous overrides lims, so we have to specify the limits again in scale_x_continuous
```

-   Density plots are another method for analyzing the distribution of
    univariate data  
-   Use the density plot to examine the age range of the customers.

``` r
#density plot helps us analyze  proportions
#we only analyze with > and < not =
#maximum # of customer are within the age 25 to 75

layer1 +
  geom_density(aes(x = age))
```

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/density_plot-1.png)<!-- -->

… Might help sometimes

``` r
#if we have a very large scale then we need to change the scale
#log scale minimizes the variation
#scale_x_continuous only scales the values and changes the curve, so instead we use scale_x_log10

layer1 +
  geom_density(aes(x = age)) +
  scale_x_log10()
```

    ## Warning: Transformation introduced infinite values in continuous x-axis

    ## Warning: Removed 77 rows containing non-finite values (`stat_density()`).

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/density_plot_log10-1.png)<!-- -->

-   Create a bar chart to present the count values of various
    marital_statuses  
-   Compare a stacked bar_plot against a side-by-side bar plot
-   It would have been nice if there are proportion values to present
    the bar plots. This can be easily done with the dplyr and tidyr
    functions

``` r
layer1 +
  geom_bar(aes(x = marital_status, fill = health_ins)) +
  geom_text(aes(x = marital_status, label = ..count..),
            stat = "count")
```

    ## Warning: The dot-dot notation (`..count..`) was deprecated in ggplot2 3.4.0.
    ## i Please use `after_stat(count)` instead.

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/bar_chart-1.png)<!-- -->

``` r
ggplot(customer_data) + 
  geom_bar(aes(x = marital_status, fill=health_ins), position="dodge") +
  
#if I want to add label (but then we need the aggregate function to create count separatly for Tue & False health_ins)
  geom_text(aes(x = marital_status, label = ..count..), stat = "count")
```

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/bar_chart_dodge-1.png)<!-- -->

-   We need count of each combination

``` r
health_ins_count_by_marital_status <- aggregate(sex~marital_status+as.factor(health_ins), 
                                                data = customer_data, length)
names(health_ins_count_by_marital_status) <- c("marital_status","health_ins", "ct")
```

-   Use the “ct” variable generated above to show the values as labels
    for the bar graph

``` r
#identity is to use exactly the numbers we have
#ggplot(health_ins_count_by_marital_status) + 
  #geom_bar(aes(x = marital_status, y = ct,
               #fill = health_ins), stat = "identity")

ggplot(health_ins_count_by_marital_status, aes(x=marital_status, y = ct)) +
  geom_bar(aes(fill=health_ins), stat = "identity") +
  geom_text(aes(label = ct), vjust = -1)
```

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/bar_graph_counts-1.png)<!-- -->

``` r
ggplot(health_ins_count_by_marital_status) + 
  geom_bar(aes(x = marital_status, y = ct, fill=health_ins),
           position="dodge", stat = "identity") +
  geom_text(aes(x = marital_status, y = ct, label = ct))
```

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/bar_graph_douge_counts-1.png)<!-- -->

``` r
#to adjust the position use vjust & hjust
```

-   Create a bar chart to present the count values of various
    marital_statuses

``` r
layer1 +
  geom_bar(aes(x = reorder (state_of_res,state_of_res, FUN = function(x) length(x)))) +
  scale_x_discrete(name = "state of residence")+
  coord_flip()
```

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/bar_chart_desc-1.png)<!-- -->

-   Compare marital status against housing type: Categorical
    vs. Categorical comparison
-   Facet plots with bar charts

``` r
ggplot(customer_data[!is.na(customer_data$housing_type),]) +
  geom_bar(aes(x = reorder(marital_status, marital_status,
                           function(x) {length(x)})))+ 
  facet_wrap(~housing_type, scale = "free_x") +
  scale_x_discrete(name = "Marital Status") +
  coord_flip()
```

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/facet_bar_plots-1.png)<!-- -->

``` r
#free_x makes each of the categories scales different
```

-   Compare population densities across categories

``` r
#to compare density of different marital statuses
#it's scewed to the right
ggplot(data = customer_data) +
  geom_density(aes(x = age, color = marital_status, linetype = marital_status, position="fill")) + 
  scale_color_brewer(palette="Dark2")
```

    ## Warning in geom_density(aes(x = age, color = marital_status, linetype =
    ## marital_status, : Ignoring unknown aesthetics: position

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/density_comparison-1.png)<!-- -->

``` r
#i can also add scale_x_continuous(limits = c(0,100000))
```

-   Scatter plots to identify relationships between two continuos
    variables.
-   Create a scatter plot between age and income to see if there is any
    relationship between them or they are just independent variables

``` r
#continuous variables: age, income, num_vehicles..
#to see if there's a relationship between two variables
#there's a slight increase between age group 25 and 60

ggplot(customer_data) + 
  geom_point(aes(x = age, y = income)) + 
  ggtitle(label = "Correlation analysis between Age and Income") + 
  geom_smooth(aes(x = age, y = income), method = "auto") + 
  lims(y = c(0, 200000))
```

    ## 

    ## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 1471 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 1471 rows containing missing values (`geom_point()`).

![](InClass_03_S23_exploratory_data_analysys_files/figure-gfm/scatter-plot1-1.png)<!-- -->

<p class="blue_box">
In summary, the two dimensional visualizations provide a great starting
point for exploratory data analysis. The below table summarizes
</p>

-   There are so many customers with an income range of 0 - \$100,000.  
-   Plot a histogram to highlight customers with an income range
    -   -7000-20,000 (includes the min value)
    -   20,000 - 40,000
    -   40,000 - 60,000
    -   60,000 - 80,000
    -   80,000 - 100,000
    -   100,000 - 200,000
    -   200,000 - 300,000
    -   300,000 - 400,000
    -   400,000 - 1,300,000 (It includes a max value of 1,257,000)
-   HINT: Use the “cut” function to get the custom breaks

``` r
#cut(1:20, breaks = c(0, 5, 20))
customer_data$income_ranges <- cut(customer_data$income, breaks = c(-7000, 20000, 40000, 60000, 80000, 100000, 200000, 300000, 400000, 1300000))

table(customer_data$income_ranges)
```

    ## 
    ##  (-7e+03,2e+04]   (2e+04,4e+04]   (4e+04,6e+04]   (6e+04,8e+04]   (8e+04,1e+05] 
    ##           30494           18059           10343            5541            3188 
    ##   (1e+05,2e+05]   (2e+05,3e+05]   (3e+05,4e+05] (4e+05,1.3e+06] 
    ##            4211             674             282             470

-   More into modeling stuff later …
