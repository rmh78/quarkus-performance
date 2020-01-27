import json
import psycopg2
from psycopg2 import pool

from flask import Flask
app = Flask(__name__)

import logging
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

# open connection pool to postgres-db
postgreSQL_pool = psycopg2.pool.SimpleConnectionPool(1, 20,user="test",
                                                    password="test",
                                                    host="testdb",
                                                    port="5432",
                                                    database="testdb")

def executeQuery(query):
    try:
        connection = postgreSQL_pool.getconn()
        cursor = connection.cursor()
        cursor.execute(query)
        connection.commit()

    except (Exception, psycopg2.DatabaseError) as error :
        print ("error while executing query", error)
    finally:
        if(connection):
            postgreSQL_pool.putconn(connection)

def getAll():
    try:
        connection = postgreSQL_pool.getconn()
        cursor = connection.cursor()
        postgreSQL_select_Query = "select id, name, age from customer"

        cursor.execute(postgreSQL_select_Query)
        mobile_records = cursor.fetchall() 
        
        columns = ('id', 'name', 'age')
        results = []
        for row in mobile_records:
            results.append(dict(zip(columns, row)))

        return json.dumps(results, indent=2)

    except (Exception, psycopg2.Error) as error :
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        if(connection):
            cursor.close()
            postgreSQL_pool.putconn(connection)

executeQuery('''DROP TABLE CUSTOMER;''')
executeQuery('''CREATE TABLE CUSTOMER (ID INT PRIMARY KEY NOT NULL, NAME TEXT NOT NULL, AGE INT NOT NULL);''')
executeQuery('''insert into customer (id, name, age) values (1, 'Harald', 41);''')
executeQuery('''insert into customer (id, name, age) values (2, 'Paul', 23);''')
executeQuery('''insert into customer (id, name, age) values (3, 'Stefan', 31);''')

@app.route('/hello')
def find_all_customer():
    return getAll()

if __name__ == '__main__':
    app.run(port=8080)
