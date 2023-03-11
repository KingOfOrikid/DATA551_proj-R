# Features Implemented
Our dashboard is spread across 2 tabs of content.

## Tab 1
* Shows count of homicides in the US by States, and presents the data according to the gender of the victim and the perpetrator
* Can filter the count of homicides across year values and weapon type values
* By selecting a state, shows line chart and bar chart about counts of homicides by month and by perpetrator race

## Tab 2


# Features To Improve On

## Tab 1
* Beautification of slider and checkbox 
* Add `select all` in checkbox to select all weapon type valus 
* Add a relatively good level of interactivity that selecting different continents in map graph can change all three graphs


## Tab 2


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