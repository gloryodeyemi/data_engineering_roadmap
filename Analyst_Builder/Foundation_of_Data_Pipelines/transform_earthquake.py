import psycopg2
import os
from dotenv import load_dotenv
from datetime import datetime, timedelta

def delete_old_records(conn, start_date, end_date):
    cur = conn.cursor()

    delete_query = "DELETE FROM stage_earthquake WHERE dt BETWEEN %s and %s"
    cur.execute(delete_query, (start_date, end_date))

    conn.commit()
    cur.close()


def transform_earthquake(conn, start_date, end_date):

    cur = conn.cursor()

    sql = """
        INSERT INTO stage_earthquake
        SELECT
            to_timestamp(cast(ts as bigint)/1000) as ts,
            cast(to_timestamp(cast(ts as bigint)/1000) as date) as dt,
            TRIM(SUBSTRING(place FROM POSITION('of ' IN place) + 3)) as place,
            magnitude,
            longitude,
            latitude,
            depth
        FROM earthquake
        WHERE cast(to_timestamp(cast(ts as bigint)/1000) as date) BETWEEN %s and %s;
    """
    cur.execute(sql, (start_date, end_date))

    conn.commit()
    cur.close()


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

    # today_date = datetime.now()
    # start_date = (today_date - timedelta(days=15)).strftime("%Y-%m-%d")
    # end_date = today_date.strftime("%Y-%m-%d")

    start_date = '2025-03-10'
    end_date = '2025-03-15'

    try:
        # delete old records
        delete_old_records(conn, start_date, end_date)

        # load csv data into the table
        transform_earthquake(conn, start_date, end_date)
        print("Data loaded successfully")

    except Exception as e:
        print(f"An error occured: {str(e)}")

    finally:
        # close the database connection
        conn.close()


if __name__ == "__main__":
    main()