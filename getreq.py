import time
import requests

import clickhouse_connect

URL = "http://api.open-notify.org/astros.json"


def fetch_data():
    delay = 1

    for attempt in range(5):
        try:
            response = requests.get(URL, timeout=10)

            response.raise_for_status()

            return response.json()

        except requests.RequestException:
            if attempt == 4:
                raise

            time.sleep(delay)
            delay *= 2
            

client = clickhouse_connect.get_client(
    host="localhost",
    port=8123,
    database="de_test",
    username="admin99",
    password="12345f"
)

raw = fetch_data()

client.insert(
    "raw_table",
    [[raw]],                    
    column_names=["raw_json"]
)

