import psycopg2
import os
from dotenv import load_dotenv
from datetime import datetime


def delete_old_records(conn, csv_file_path):
    cur = conn.cursor()

    # execute the delete query
    delete_query = "DELETE FROM earthquake WHERE filename=%s"
    cur.execute(delete_query, (csv_file_path,))

    conn.commit()
    cur.close()


def load_csv_to_postgres(conn, csv_file_path):
    cur = conn.cursor()

    sql = "COPY earthquake FROM STDIN DELIMITER ',' CSV HEADER"
    cur.copy_expert(sql, open(csv_file_path, "r"))

    conn.commit()
    cur.close()
    conn.close()


def main():
    # Load environment variables from .env file
    load_dotenv()

    # database connection parameters
    db_params = {
        'dbname': os.getenv('DB_NAME'),
        'user': os.getenv('DB_USER'),
        'password': os.getenv('DB_PASS'),
        'host': os.getenv('DB_HOST'),
        'port': os.getenv('DB_PORT')
    }

    # connect to the PostgreSQL database
    conn = psycopg2.connect(**db_params)

    today_date = datetime.now()
    t_date = today_date.strftime("%Y_%m_%d")

    # path to your csv file
    csv_file_path = f'/Users/new/Downloads/Tutorials/Data_Engineering/DE_Roadmap/Analyst_Builder/Foundation_of_Data_Pipelines/data/earthquake_{t_date}.csv'

    try:
        # delete old records
        delete_old_records(conn, csv_file_path)

        # load csv data into the table
        load_csv_to_postgres(conn, csv_file_path)
        print("Data loaded successfully")

    except Exception as e:
        print(f"An error occured: {str(e)}")

    finally:
        # close the database connection
        conn.close()

if __name__ == "__main__":
    main()