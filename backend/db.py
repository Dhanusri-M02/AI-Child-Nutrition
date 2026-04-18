import mysql.connector
import os

def get_db_connection():
    return mysql.connector.connect(
        host=os.environ.get('MYSQL_ADDON_HOST'),
        port=int(os.environ.get('MYSQL_ADDON_PORT', 3306)),
        database=os.environ.get('MYSQL_ADDON_DB'),
        user=os.environ.get('MYSQL_ADDON_USER'),
        password=os.environ.get('MYSQL_ADDON_PASSWORD')
    )