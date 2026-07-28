#### 1. Поднять ClickHouse

```bash
docker compose up -d
```

#### 2. Установить зависимости

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

#### 3. Загрузить данные

```bash
python getreq.py
```

#### 4. Дедупликация

```bash
docker exec -it clickhouse clickhouse-client --user admin99 --password 12345f \
  --queries-file scripts/optimize.sql
```

#### 5. dbt

Если нужен `profiles.yml`:

```yaml
# ~/.dbt/profiles.yml
de_test_dbt:
  target: dev
  outputs:
    dev:
      type: clickhouse
      schema: de_test
      host: localhost
      port: 8123
      user: admin99
      password: 12345f
      secure: False
```

Запуск:

```bash
cd de_test_dbt
dbt run
```
