import pandas as pd
from sqlalchemy import create_engine, engine

df = pd.read_excel('covid_vax.xlsx')

engine = create_engine('mysql://root:fagamax1@localhost/coviddb')

df.to_sql('covid_vax', con=engine, if_exists='append')