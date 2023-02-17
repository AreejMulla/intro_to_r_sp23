Logistic Regression
================

## Logistic Regression

In statistics, the logistic model (or logit model) is used to model the
probability of a certain class or event existing such as pass/fail,
win/lose, alive/dead or healthy/sick. This can be extended to model
several classes of events such as determining whether an image contains
a cat, dog, lion, etc. Each object being detected in the image would be
assigned a probability between 0 and 1, with a sum of one.

The equation for Logistic Regression can be written as:

$$
output = log{_e}(\frac{p}{1-p}) = \beta_0 + \beta_1 x + \beta_2 x^2 + ... + \beta_n x^n \
$$ The “output” is also called logit. Another name for “output” is the
log odds ratio. p is the probability of an event occuring or not. So the
odds ratio is: (Probability of an event occurring divided by probability
of an event not occurring)

$$
\frac{p}{1-p}
$$ Suppose: $$
\begin{aligned}
        Y = \beta_0 + \beta_1 x + \beta_2 x^2 + ... + \beta_n x^n  \\   
\end{aligned}
$$

Then

$$
log{_e}(\frac{p}{1-p}) = Y \\
$$ Taking log on both the sides

$$
\\
\frac{p}{1-p} = e^Y \\
$$

Solving for p, we will get

$$
p = \frac{e^Y}{1+e^Y} \\
$$ As Y increases positively p approaches 1 and as Y increases
negatively, then p approaches to zero

``` r
library(readr)
```

    ## Warning: package 'readr' was built under R version 4.1.3

``` r
# Use read_csv() to read the file 
```

``` r
library(tibble) 
```

    ## Warning: package 'tibble' was built under R version 4.1.3

``` r
# Include your code to select train and test samples 
# use the seed 100 for selecting the random samples for reproducibility 
# Use 80% of your data to create a training sample 
# Use 20% of your data to create a test sample 
```

``` r
# Include your code to run the Generalized Linear Regression (GLM) model of "binomial" family
# Print the summary of the model 
# The model returns coefficients that impact the outcome variable admit 
# Interpret the results in terms of log odds 
```

``` r
# Make predictions for the train sample
# Create a confusion matrix using the train sample and calculate the accuracy of the model using training sample  
```

``` r
# Make predictions for the test sample
# Create a confusion matrix using the train sample and calculate the accuracy of the model using training sample  
```
