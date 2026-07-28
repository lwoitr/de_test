
CREATE TABLE IF NOT EXISTS de_test.raw_table
(
    raw_json JSON,
    _inserted_at DateTime DEFAULT now()
)
ENGINE = MergeTree
ORDER BY _inserted_at;


CREATE TABLE IF NOT EXISTS de_test.people
(
    craft String,
    name String,
    _inserted_at DateTime
)
ENGINE = ReplacingMergeTree(_inserted_at)
ORDER BY (name, craft);


CREATE MATERIALIZED VIEW IF NOT EXISTS de_test.mv_people
TO de_test.people
AS
SELECT
    JSONExtractString(person, 'craft') AS craft,
    JSONExtractString(person, 'name')  AS name,
    _inserted_at
FROM de_test.raw_table
ARRAY JOIN JSONExtractArrayRaw(toString(raw_json), 'people') AS person;