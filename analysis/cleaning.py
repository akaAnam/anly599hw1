import pandas as pd
import numpy as np

# reading in raw data 
data = pd.read_csv('./data/SummerStudentAdmissions2.csv')

###### CLEANING #######

# removing any decisions that are not admit, decline, or waitlist
data = data.loc[(data['Decision'] == 'Admit') | (data['Decision'] == 'Decline') | (data['Decision'] == 'Waitlist')]

# capitalizing all states
data['State'] = data['State'].str.title()

# removing work experience anomalies (100 years exp)
data['WorkExp'] = np.where(data['WorkExp'] > 10, np.nan, data['WorkExp'])

# removing gender anomalies (gender of -1)
data['Gender'] = np.where((data['Gender'] == -1), np.nan, data['Gender'])

# removing GPA anomalies (GPA of 6) - ** assumption is that GPAs are on a 4.0 scale **
data['GPA'] = np.where(data['GPA'] > 4, np.nan, data['GPA'])

# dropping all null values 
data = data.dropna()

data.to_csv('./data/cleaned.csv')