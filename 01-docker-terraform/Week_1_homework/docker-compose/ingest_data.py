import os
import argparse
from sqlalchemy import create_engine
import pandas as pd


def main(params):
    user = params.user
    password = params.password
    host = params.host 
    port = params.port 
    db = params.db
    table_name = params.table_name
    url = params.url
    
    output_name = "greentrip_2021-01.parquet"

    os.system(f"curl -o {output_name} {url}")
    
    df = pd.read_parquet(f'{output_name}', engine='pyarrow')

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()


    #print(pd.io.sql.get_schema(df, name = "yellow_taxi_data", con=engine))


    df.head(n=0).to_sql(con=engine, name=table_name, if_exists="replace")

    df.to_sql(con=engine, name=table_name, if_exists="append")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', required=True, help='user name for postgres')
    parser.add_argument('--password', required=True, help='password for postgres')
    parser.add_argument('--host', required=True, help='host for postgres')
    parser.add_argument('--port', required=True, help='port for postgres')
    parser.add_argument('--db', required=True, help='database name for postgres')
    parser.add_argument('--table_name', required=True, help='name of the table where we will write the results to')
    parser.add_argument('--url', required=True, help='url of the csv file')

    args = parser.parse_args()
    main(args)