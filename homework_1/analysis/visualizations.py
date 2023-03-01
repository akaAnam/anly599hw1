import matplotlib.pyplot as plt
import seaborn as sns 
import pandas as pd 

sns.set_theme(style="ticks")

data = pd.read_csv('./data/cleaned.csv')

for i in ['GPA', 'WorkExp', 'TestScore', 'WritingScore', 'VolunteerLevel']:

    sns.boxplot(x=i, y="Decision", data=data, whis=[0, 100], width=.6, palette="vlag")
    plt.savefig('./output/boxplt_' + i.lower() + '.png')
    plt.close()

# g = sns.FacetGrid(data, col="Gender", height=4, aspect=.5)
# g.map(sns.barplot, "sex", "total_bill")
# plt.show()