df_text_generate<-function(df,var,var_col){
  index <- c()
  text <- c()
  count <- 0
  for(idx in 1:nrow(df)){
    if(df[idx,]$State_Code %in% index){
      #pass
    }
    else{
      count<-count+1
      index[count]<-df[idx,]$State_Code
      temp_text <- gsub('_',' ',var)
      temp_text <- paste(temp_text,'<br>',sep='')
      text[count]<-temp_text
      
      sub<-subset(df,State_Code==df[idx,]$State_Code)
      for(jdx in 1:nrow(sub)){
        temp_text <-paste(temp_text,sub[jdx,var_col],': ',sub[jdx,]$count_num,'<br>',sep='')
        
      }
      text[count]<-temp_text
    }
  }
  return(list(index,text))
}


plot_text_generate<-function(df){
  df_group1 <- data.frame(summarise(group_by(df,State_Code,Victim_Sex),count_num=n()))
  res1 <- df_text_generate(df_group1,'Victim_Sex',2)
  sta_idx <- res1[[1]]
  text1 <- res1[[2]]
  df_group2 <- data.frame(summarise(group_by(df,State_Code,Perpetrator_Sex),count_num=n()))
  res2 <- df_text_generate(df_group2,'Perpetrator_Sex',2)
  text2 <- res2[[2]]
  
  df_trail <- data.frame(summarise(group_by(df,State, State_Code),count_num=n()))
  plot_text_lst <- c()
  for(i in 1:nrow(df_trail)){
    temp_text <- paste(text1[i],text2[i],sep='')
    plot_text_lst[i] <- paste('State: ',df_trail[i,]$State,'<br>',temp_text,sep='')
  }
  df_trail['plot_text']<-plot_text_lst
  return(df_trail)
}


Month_sort = c('January','February','March','April','May','June','July','August','September','October','November','December')
gender = c('Female','Male','Unknown')

line_graph_sta <- function(df){
  df_group <- data.frame(summarise(group_by(df,Month,Perpetrator_Sex),count_num=n()))
  text <- c()
  new_df <- df_group[1,]
  for(idx in 1:length(Month_sort)){
    if(Month_sort[idx] %in% df_group$Month){
      sub<-subset(df_group,Month==Month_sort[idx])
      for(jdx in 1:length(gender)){
        if(gender[jdx] %in% sub$Perpetrator_Sex){
          #pass
          new_df <- rbind(new_df,subset(sub,Perpetrator_Sex==gender[jdx]))
        }
        else{
          vec <- list(Month_sort[idx],gender[jdx],0)
          new_df <- rbind(new_df,vec)
        }
      }
    }
  }
  
  return(new_df[-1,])
}

df_g<-subset(murder,Year==2010 & Weapon=='Gun')
df_new<-line_graph_sta(df_g)
df_1 <- subset(df_new,Perpetrator_Sex=='Female')
df_2 <- subset(df_new,Perpetrator_Sex=='Male')
df_3 <- subset(df_new,Perpetrator_Sex=='Unknown')
fig<-plot_ly(df_1,x=~Month)
fig<-fig %>% add_lines(y=~df_1$count_num,name='Female',mode='lines',
                       line = list(color = 'rgb(255, 0, 0)', width = 2))
fig<-fig %>% add_lines(y=~df_2$count_num,name='Male',mode='lines',
                       line = list(color = 'rgb(60, 179, 113)', width = 2))
fig<-fig %>% add_lines(y=~df_3$count_num,name='Unknown',mode='lines',
                       line = list(color = 'rgb(0, 0, 255)', width = 2))
fig

