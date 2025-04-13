
# 🍷 Wine Quality Analysis using Hadoop, Hive, and Apache Spark

A Data Analytics project leveraging Big Data tools to analyze and compare red and white wine datasets. This project showcases a complete ETL and data analysis pipeline using:

- Hadoop Distributed File System (HDFS)
- Apache Hive for SQL-based querying
- Apache Spark for processing
- Pandas, Matplotlib, and Seaborn for visualizations

---

## 📁 Dataset

Wine Quality datasets from [Kaggle](https://www.kaggle.com/datasets/rajyellow46/wine-quality).  
Contains physicochemical and quality ratings for red and white wines.

| Dataset                |
|------------------------|
| `winequality-red.csv`  | 
| `winequality-white.csv`| 

---

## ⚙️ Tech Stack

| Component     | Purpose                             |
|---------------|-------------------------------------|
| **HDFS**      | Distributed storage for CSV files   |
| **Hive**      | SQL queries + saving intermediate results |
| **Spark**     | Reading Hive results, transformation |
| **Pandas**    | Data cleaning and joining           |
| **Seaborn**   | Correlation heatmaps & feature plots|
| **Matplotlib**| Comparative visualizations          |

---

## 🧪 Step-by-Step Pipeline


### 0. Setup and Configurations

#### Hadoop 3.2.3: 
https://archive.apache.org/dist/hadoop/common/hadoop-3.2.3/hadoop-3.2.3.tar.gz

#### Hive 3.1.3:
https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz

#### Apache Spark 3.5.0:
https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz

-- 

.bashrc file (environment variables):


Verify configurations:
![image](https://github.com/user-attachments/assets/c0b99b97-7c93-4689-9a2b-e35b0b38d0c2)

![image](https://github.com/user-attachments/assets/bb3f21c7-0905-4cac-8dc0-802971410791)

![image](https://github.com/user-attachments/assets/9a024cd1-1838-499c-afe6-acd8d3390943)



### 1. Data Ingestion to HDFS

```bash
hdfs dfs -mkdir -p /user/ved/wine_data/red
hdfs dfs -mkdir -p /user/ved/wine_data/white

hdfs dfs -put winequality-red.csv /user/ved/wine_data/red/
hdfs dfs -put winequality-white.csv /user/ved/wine_data/white/
```


