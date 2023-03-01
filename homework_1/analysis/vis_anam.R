library(dplyr)

data <- read.csv("homework_1/data/cleaned.csv")

table(data$Decision, data$State)


data_prep <- data %>% group_by(State, Decision) %>% summarise(avg_workexp = mean(WorkExp), 
                                                 avg_volunteer = mean(VolunteerLevel),
                                                 avg_test = mean(TestScore),
                                                 avg_writing = mean(WritingScore),
                                                 avg_gpa = mean(GPA)) %>%
  filter(Decision == 'Admit')


tot_applicants = data %>% group_by(State) %>% summarise(total_apps = n())

data_prep <- data_prep %>% left_join(tot_applicants, by = 'State')


df <- data.frame(State = c('Alabama', 'Mississippi', 'New York', 'Oregon', 'Vermont', 'Virginia'), 
                   Decision  = c('Waitlist', 'Decline', 'Waitlist', 'Decline', 'Waitlist', 'Decline'),
                   avg_workexp = c('No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students'),
                   avg_volunteer = c('No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students'),
                   avg_test = c('No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students'),
                   avg_writing = c('No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students'),
                   avg_gpa = c('No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students', 'No Admitted Students')
                   )
  
df <- df %>% left_join(tot_applicants, by = 'State')

data_prep[3:7] <- round(data_prep[3:7],2)
data_prep[3:7] <- sapply(data_prep[3:7], as.character)


df_new<- rbind(data_prep, df)

write.csv(df_new, '../data/data_for_plotly_map.csv')
