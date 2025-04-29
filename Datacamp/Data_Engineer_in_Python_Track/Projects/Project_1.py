"""
Cleaning Bank Marketing Campaign Data
-------------------------------------
Subset, clean, and reformat the bank_marketing.csv dataset to create and store three new files based on the requirements detailed in the notebook.

- Split and tidy bank_marketing.csv, storing as three DataFrames called client, campaign, and economics, each containing the columns outlined in the 
notebook and formatted to the data types listed.
- Save the three DataFrames to csv files, without an index, as client.csv, campaign.csv, and economics.csv respectively.
"""
import pandas as pd
import numpy as np

df = pd.read_csv("bank_marketing.csv")

# Clients DataFrame
# 1. job column - Change "." to "_"
df['job'] = df['job'].str.replace(".", "_")

# 2. education column - Change "." to "_" and "unknown" to np.NaN
df['education'] = df['education'].str.replace('.', '_', regex=False).replace('unknown', np.nan)

# 3. credit_default column - Convert to boolean data type: 1 if "yes", otherwise 0
df['credit_default'] = df['credit_default'].replace({"yes": 1, "no": 0}).astype('bool')

# 4. mortgage column - Convert to boolean data type: 1 if "yes", otherwise 0
df['mortgage'] = df['mortgage'].replace({"yes": 1, "no": 0}).astype('bool')

# 5. create client DataFrame
client = df[['client_id', 'age', 'job', 'marital', 'education', 'credit_default', 'mortgage']]
print(client.head())

# 6. save client DataFrame as csv file
client.to_csv('client.csv', index=False)

# Campaign DataFrame
# 1. previous_outcome column - Convert to boolean data type: 1 if "success", otherwise 0.
df['previous_outcome'] = df['previous_outcome'].apply(lambda x: 1 if x == 'success' else 0).astype('bool')

# 2. campaign_outcome column - Convert to boolean data type: 1 if "yes", otherwise 0.
df['campaign_outcome'] = df['campaign_outcome'].apply(lambda x: 1 if x == 'yes' else 0).astype('bool')

# 3. last_contact_date column - Create from a combination of day, month, and a newlycreated year column (whichshould have a value of 2022); Format = "YYYY-MM-DD"
df['year'] = 2022
df['last_contact_date'] = df['day'].astype(str) + '-' + df['month'] + '-' + df['year'].astype(str)
df['last_contact_date'] = pd.to_datetime(df['last_contact_date'], format='%d-%b-%Y')
# df['last_contact_date'] = pd.to_datetime(df[['year', 'month', 'day']])

# 4. create campaign DataFrame
campaign = df[['client_id', 'number_contacts', 'contact_duration', 'previous_campaign_contacts', 'previous_outcome', 'campaign_outcome', 'last_contact_date']]
print(campaign.head())

# 5. save campaign DataFrame as csv file
campaign.to_csv('campaign.csv', index=False)

# Economics DataFrame
# 1. create economics DataFrame
economics = df[['client_id', 'cons_price_idx', 'euribor_three_months']]
print(economics.head())

# 2. save economics DataFrame as csv file
economics.to_csv('economics.csv', index=False)
