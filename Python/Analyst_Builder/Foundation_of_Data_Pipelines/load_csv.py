import psycopg2
import os


def delete_old_records(conn, csv_file_path):
    cur = conn.cursor()

    # execute the delete query
    delete_query = "DELETE FROM earthquate WHERE filename=%s"
    cur.execute(delete_query, (csv_file_path,))

    conn.commit()
    cur.close()


def load_csv_to_postgres(conn, csv_file_path):
    cur = conn.cursor()

    sql = "COPY earthquake FROM STDIN DELIMETER ',' CSV HEADER"
    cur.copy_expert(sql, open(csv_file_path, "r"))

    conn.commit()
    cur.close()
    conn.close()


def main():
    print(-1)


if __name__ == "__main__":
    main()