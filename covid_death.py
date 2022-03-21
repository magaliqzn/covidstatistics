import pandas as pd
from sqlalchemy import create_engine, engine

df = pd.read_excel('covid_death.xlsx')

engine = create_engine('mysql://root:fagamax1@localhost/coviddb')

df.to_sql('covid_death', con=engine, if_exists='append')