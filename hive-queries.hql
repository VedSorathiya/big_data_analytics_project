-- Hive Queries: Wine Quality Analysis


-- Step 1: Table Creation for Red Wine

CREATE TABLE winequality_red (
    fixed_acidity DOUBLE,
    volatile_acidity DOUBLE,
    citric_acid DOUBLE,
    residual_sugar DOUBLE,
    chlorides DOUBLE,
    free_sulfur_dioxide DOUBLE,
    total_sulfur_dioxide DOUBLE,
    density DOUBLE,
    pH DOUBLE,
    sulphates DOUBLE,
    alcohol DOUBLE,
    quality INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");


-- Step 2: Table Creation for White Wine

CREATE TABLE winequality_white (
    fixed_acidity DOUBLE,
    volatile_acidity DOUBLE,
    citric_acid DOUBLE,
    residual_sugar DOUBLE,
    chlorides DOUBLE,
    free_sulfur_dioxide DOUBLE,
    total_sulfur_dioxide DOUBLE,
    density DOUBLE,
    pH DOUBLE,
    sulphates DOUBLE,
    alcohol DOUBLE,
    quality INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");


-- Step 3: Load Data from HDFS into Tables

LOAD DATA INPATH '/user/ved/wine_data/red/winequality-red.csv' INTO TABLE winequality_red;
LOAD DATA INPATH '/user/ved/wine_data/white/winequality-white.csv' INTO TABLE winequality_white;


-- Step 4: Query Analysis

-- Query 1: Average Quality of Red Wines
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/avg_quality_red_wine'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT AVG(quality) FROM winequality_red;

-- Query 2: Count of Red Wines with Quality > 7
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/count_quality_above_7_red'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT COUNT(*) FROM winequality_red WHERE quality > 7;

-- Query 3: Quality Distribution of Red Wines
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/quality_distribution_red'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT quality, COUNT(*) FROM winequality_red GROUP BY quality ORDER BY quality;

-- Query 4: Average Alcohol Content of Red Wines
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/avg_alcohol_red'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT AVG(alcohol) FROM winequality_red;

-- Query 5: Average Quality of White Wines
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/avg_quality_white_wine'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT AVG(quality) FROM winequality_white;

-- Query 6: Count of White Wines with Quality > 7
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/count_quality_above_7_white'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT COUNT(*) FROM winequality_white WHERE quality > 7;

-- Query 7: Quality Distribution of White Wines
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/quality_distribution_white'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT quality, COUNT(*) FROM winequality_white GROUP BY quality ORDER BY quality;

-- Query 4: Average Alcohol Content of White Wines
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/avg_alcohol_white'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT AVG(alcohol) FROM winequality_white;