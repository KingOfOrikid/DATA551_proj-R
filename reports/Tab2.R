library(plotly)
library(devtools)
library(dash)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(tidyverse)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)
murder <- read.csv("homicides.csv")

app$layout(
  dbcContainer(
  list(
    htmlH1("Dashboard of Murder Cases by Months"),
    htmlP("Please select features to do filtering on"),
    dbcRow(
      list(
        # Dropdown
        dbcCol(
          list(
            htmlBr(),
            
            htmlLabel("Crime Type: "),
            dccDropdown(
              id = "input_crime_type",
              value= "Murder or Manslaughter",
              multi = FALSE,
              clearable = FALSE,
              style = list("font-size" = "smaller"),
              options = c(distinct(murder, Crime.Type))$Crime.Type %>% purrr::map(function(row) list(label = row, value = row)) 
                       ),
            htmlBr(),
            
            htmlLabel("State: "),
            dccDropdown(
              id = "input_state",
              value = "Alaska",
              multi = FALSE,
              style = list("font-size" = "smaller"),
              options = c(distinct(murder, State))$State %>% purrr::map(function(row) list(label = row, value = row)) 
                       ),
            
            htmlBr(),
            htmlLabel("Weapon Type: "),
            dccDropdown(
              id = "input_weapon",
              value = "Blunt Object",
              multi = FALSE,
              clearable = TRUE,
              style = list("font-size" = "smaller"),
              options = c(distinct(murder, Weapon))$Weapon %>% purrr::map(function(row) list(label = row, value = row)) 
                       ),
            
            htmlBr(),
            htmlLabel("Relationship with Victim: "),
            dccDropdown(
              id = "input_relationship",
              value = "Acquaintance",
              multi = FALSE,
              clearable = TRUE,
              style = list("font-size" = "smaller"),
              options = c(distinct(murder, Relationship))$Relationship %>% purrr::map(function(row) list(label = row, value = row)) 
                       )
            ),
          md=4
            ),                                           
        
        #Major Rose Graph
        dbcCol(
          dccGraph(id = "rose_plot"
                   )      
              )
        
      
        
        )
      )            
    )
  )
)
    





#### Callback 
app$callback(
  output("rose_plot", "figure"),
  list(
    input("input_crime_type", "value"),
    input("input_state", "value"),
    input("input_weapon", "value"),
    input("input_relationship", "value")
      ),
  function(input_crime_type, input_state, input_weapon, input_relationship) {
    filter_murder <- filter(murder, 
                            Crime.Type == input_crime_type
                            & State == input_state
                            & Weapon == input_weapon
                            & Relationship == input_relationship)
    
    grouped_df <- (filter_murder %>% group_by(Month) %>% summarise(total_count = n()) 
                   %>% as.data.frame() %>% mutate(Month = factor(Month, levels = month.name))
                   %>% arrange(Month)
                   )
    
    fig <- plot_ly() %>% add_trace(data = grouped_df,
                                   r = ~total_count,
                                   theta = ~Month,
                                   type = "barpolar")
    
    return(fig)
    
  }
  
)



app$run_server(debug=TRUE)
