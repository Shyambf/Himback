from flask import Flask, request, jsonify
import psycopg2
from psycopg2 import extras
from dotenv import load_dotenv
import json
import os

load_dotenv()

app = Flask(__name__)

# Подключение к базе данных PostgreSQL
conn = psycopg2.connect(
    dbname=os.getenv('POSTGRES_DB'),
    user=os.getenv('POSTGRES_USER'),
    password=os.getenv('POSTGRES_PASSWORD'),
    host="db"
)

@app.route('/table_names', methods=['GET'])
def get_table_names():
    cur = conn.cursor()
    cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
    rows = cur.fetchall()
    cur.close()
    data  = {
        "count": len(rows),
        "results": rows
    }

    response = app.response_class(
        response=json.dumps(data),
        status=200,
        mimetype='application/json'
    )
    return response

@app.route('/get_info/<table_name>', methods=['GET'])
def get_table_info(table_name):
    cur = conn.cursor(cursor_factory=extras.RealDictCursor)
    sql_query = f"""
SELECT data_type, column_name, character_maximum_length, is_generated
FROM information_schema.columns 
WHERE table_name = '{table_name}'
"""
    cur.execute(sql_query)
    rows = cur.fetchall()

    ans = dict()
    for row in rows:
        ans[row["column_name"]] = row

    # Добавляем информацию о constraint'ах
    for column_name, column_info in ans.items():
        sql_query = f"""
        SELECT
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE
    tc.constraint_type = 'FOREIGN KEY' AND
    kcu.table_name = '{table_name}' AND
    kcu.column_name = '{column_name}';
"""     
        cur.execute(sql_query)
        column_info['foregin'] = cur.fetchall()

    cur.close()
    data = {
        "count": len(ans),
        "results": ans
    }

    response = app.response_class(
        response=json.dumps(data),
        status=200,
        mimetype='application/json'
    )
    return response

@app.route('/data/<table_name>', methods=['GET'])
def get_data(table_name):
    cur = conn.cursor(cursor_factory=extras.RealDictCursor)
    cur.execute(f"SELECT * FROM {table_name}")
    rows = cur.fetchall()
    cur.close()
    return jsonify(rows)

@app.route('/data/<table_name>', methods=['POST'])
def add_data(table_name):
    data = request.json
    columns = ', '.join(data.keys())
    values = ', '.join([f'%({key})s' for key in data.keys()])
    cur = conn.cursor(cursor_factory=extras.RealDictCursor)
    cur.execute(f"INSERT INTO {table_name} ({columns}) VALUES ({values}) RETURNING *", data)
    conn.commit()
    new_row = cur.fetchone()
    cur.close()
    return jsonify(new_row)

@app.route('/data/<table_name>/<int:id>', methods=['DELETE'])
def delete_data(table_name, id):
    cur = conn.cursor(cursor_factory=extras.RealDictCursor)
    cur.execute(f"DELETE FROM {table_name} WHERE id = %s RETURNING *", (id,))
    conn.commit()
    deleted_row = cur.fetchone()
    cur.close()
    return jsonify(deleted_row)

@app.route('/data/<table_name>/<int:id>', methods=['PATCH'])
def patch_data(table_name, id):
    data = request.json
    set_clause = ', '.join([f"{key} = %({key})s" for key in data.keys()])
    data['id'] = id
    cur = conn.cursor(cursor_factory=extras.RealDictCursor)
    cur.execute(f"UPDATE {table_name} SET {set_clause} WHERE id = %(id)s RETURNING *", data)
    conn.commit()
    updated_row = cur.fetchone()
    cur.close()
    return jsonify(updated_row)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
