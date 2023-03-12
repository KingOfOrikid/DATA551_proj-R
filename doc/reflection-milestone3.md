# Features Implemented
Our dashboard is spread across 2 tabs of content.

## Tab 1
* Shows count of homicides in the US by States, and presents the data according to the gender of the victim and the perpetrator
* Can filter the count of homicides across year values and weapon type values
* By selecting a state, shows line chart and bar chart about counts of homicides by month and by perpetrator race

## Tab 2
* Shows counts of homicides across months, filterable by a number of features (e.g. State, type of crime, relationship to victim)


# Features To Improve On

## Tab 1
* Beautification of slider and checkbox 
* Add `select all` in checkbox to select all weapon type valus 
* Add a relatively good level of interactivity that selecting different continents in map graph can change all three graphs


## Tab 2
* Aggregate columns with a large number of row values into smaller groups (example: pistol, rifle --> handgun)
* Encode color channel on rose plot.
* Filter crime and murder channel to something else


## Tab1 & Tab2
* Unify and beautify page style

# Features Not Yet Implemented
* Did not yet add Sankey graph to visualize distribution of attacker-victim relationships.

#  Brief thoughts on implementing the dashboard in R
## Tab 1
In implementing the dashboard for the second time using R I found a few differences between R and Python.        
Firstly, I found it easier to use the dash in R to organise the chart structure. In Python I had to use a lot of effort to get the charts at the right size compared to R. Also using R for groupby seemed easier than using Python.                             
However, when I was deploying the dash using R, I found that some errors in the code were not clearly reported on the page, or even not reported but not displayed the chart, which made me spend a lot of time on debugging.           
But implementing the same thing in both languages allowed me to master both languages, which was good!

## Tab 2
Since we mostly used DashBootstrapComponents for second tab, implementation in R was similar to implementation in Python with relatively minor syntactical changes.

The major thing I learned in R is transformation/mutation operations (such as data %>% summarise(count = n()). This way of operating on dataframes is something I am not familiar with, but aware it is a good skill to learn for data wrangling (in Python, something similar would be df.groupby.apply(function x)).

Second major thing I learned from using R is creating functions to do things (compared to Python, which often relies more on built in functions). Example: purrr:map(function x, list(value = row, label = row).
 