library(plotly)
library(dplyr)

murder <- read.csv('processed_data.csv')
murder_count_state <- data.frame(summarise(group_by(murder,State_Code),count_num=n()))

# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)

# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

fig <- plot_geo(murder_count_state, locationmode = 'USA-states')
#fig <- plot_geo(df_trail, locationmode = 'USA-states')
fig <- fig %>% add_trace(
  z = ~count_num, text = ~count_num, locations = ~State_Code,
  color = ~count_num, colors = 'Reds'
)
fig <- fig %>% colorbar(title='')
fig <- fig %>% layout(
  title = 'Homicide Cases Record by State',
  geo = g
)

fig
