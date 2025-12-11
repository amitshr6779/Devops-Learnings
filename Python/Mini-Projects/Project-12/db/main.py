import psycopg2
from psycopg2 import sql


def create_connection(dbname='py_db'):
    
    try:
        # Connect to your postgres DB
        conn = psycopg2.connect(
            dbname=dbname,
            user='postgres',
            password='test123',
            host='localhost',
            port='5432'
        )
        print("Database connection established.")
        return conn
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return None

def close_connection(conn):
    if conn:
        conn.close()    
        print("Database connection closed.")
    else:
        print("No connection to close.")


def create_db():
       # Connect to default 'postgres' database first
    connection = create_connection(dbname='postgres')
    
    if not connection:
        print("Failed to connect to PostgreSQL server.")
        return
    
    connection.autocommit = True  # Required for CREATE DATABASE
    cursor = connection.cursor()

    try:
        #cursor.execute("CREATE DATABASE {}".format('py_db'))
        cursor.execute(sql.SQL("CREATE DATABASE {}").format(
        sql.Identifier('py_db')
        ))
        print("Database created successfully.")

    except psycopg2.errors.DuplicateDatabase:
        print("Database already exists.")
    except Exception as e:
        print(f"Error creating database: {e}")
    finally:
        cursor.close()
        close_connection(connection)

def create_table():
    connection = create_connection(dbname='py_db')
    
    if not connection:
        print("Failed to connect to the database.")
        return
    
    cursor = connection.cursor()

    try:
        cursor.execute("""
            CREATE TABLE mytable (
                id SERIAL PRIMARY KEY,
                name VARCHAR(100),
                age INT
            )
        """)
        connection.commit()
        print("Table created successfully.")
    except Exception as e:
        print(f"Error creating table: {e}")
    finally:
        cursor.close()
        close_connection(connection)

def insert_data():
    connection = create_connection(dbname='py_db')
    
    if not connection:
        print("Failed to connect to the database.")
        return
    
    cursor = connection.cursor()

    try:
        cursor.execute("""
            INSERT INTO mytable (name, age) 
            VALUES
            ('Alice', 30),
            ('Bob', 25),
            ('Charlie', 35)
        """)
        connection.commit()
        print("Data inserted successfully.")
    except Exception as e:
        print(f"Error inserting data: {e}")
    finally:
        cursor.close()
        close_connection(connection)

def list_tables():
    connection = create_connection(dbname='py_db')
    
    if not connection:
        print("Failed to connect to the database.")
        return
    
    cursor = connection.cursor()

    try:
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
        """)
        tables = cursor.fetchall()
        print("Tables in the database:")
        for table in tables:
            print(type(table))
    except Exception as e:
        print(f"Error listing tables: {e}")
    finally:
        cursor.close()
        close_connection(connection)

def view_table_data():
    connection = create_connection(dbname='py_db')
    
    if not connection:
        print("Failed to connect to the database.")
        return
    
    cursor = connection.cursor()

    try:
        cursor.execute("SELECT * FROM mytable")
        rows = cursor.fetchall()
        print("Data in 'mytable':")
        for row in rows:
            print(row)
    except Exception as e:
        print(f"Error viewing table data: {e}")
    finally:
        cursor.close()
        close_connection(connection)


if __name__ == "__main__":
    create_db() 
    create_table()
    insert_data() 
    list_tables()  
    view_table_data()


    