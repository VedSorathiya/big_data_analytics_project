
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

---

### 1. Data Ingestion to HDFS

```bash
hdfs dfs -mkdir -p /user/ved/wine_data/red
hdfs dfs -mkdir -p /user/ved/wine_data/white

hdfs dfs -put winequality-red.csv /user/ved/wine_data/red/
hdfs dfs -put winequality-white.csv /user/ved/wine_data/white/
```
---
### 2. HIVE table creation

Now that the data is in HDFS, we can create Hive external tables. External tables allow Hive to read data directly from HDFS without copying it into its own storage.

External Table for Red Wine:

```bash
CREATE EXTERNAL TABLE winequality_red(
  fixed_acidity FLOAT,
  volatile_acidity FLOAT,
  citric_acid FLOAT,
  residual_sugar FLOAT,
  chlorides FLOAT,
  free_sulfur_dioxide FLOAT,
  total_sulfur_dioxide FLOAT,
  density FLOAT,
  pH FLOAT,
  sulphates FLOAT,
  alcohol FLOAT,
  quality INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/ved/wine_data/red/'
TBLPROPERTIES ("skip.header.line.count"="1");
```

Explanation:

CREATE EXTERNAL TABLE: Defines the schema of the table, mapping the CSV columns to the table's columns.
FIELDS TERMINATED BY ';': Specifies that the CSV file uses ; as a delimiter.
LOCATION: Points to the directory in HDFS where the dataset is stored.
TBLPROPERTIES ("skip.header.line.count"="1"): Skips the header line in the CSV.

We repeat this process for white wine using the same schema.

---

### 3. HIVE queries + saving results to HDFS

We then run queries in Hive to compute various statistics and results. Here’s a detailed explanation of one of the query:

Query: Average Quality of Red Wines

```bash
INSERT OVERWRITE DIRECTORY '/user/ved/hive_results/avg_quality_red_wine'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT AVG(quality) FROM winequality_red;
```

Explanation:

AVG(quality): Computes the average wine quality from the red wine dataset.
INSERT OVERWRITE DIRECTORY: Saves the result into a specified directory in HDFS as a CSV file. The result will be stored with a .csv extension and can be used later for analysis or visualization.
We run similar queries for other statistics like:
- Count of wines with quality greater than 7.
- Quality distribution (frequency of each quality score).
- Average alcohol content for red wines.
(refer queries.txt)

---

### 4. Spark: Data processing and cleanup

Once the query results are saved in HDFS, we use Apache Spark to process these results and clean the data before visualization.

```bash
df = spark.read.csv("hive_outputs/avg_quality_red.csv")
df = df.withColumnRenamed("_c0", "avg_quality")
```

Explanation:

spark.read.csv(): Reads the CSV file from the HDFS directory into a DataFrame.
withColumnRenamed(): Renames columns for clarity. The CSV output from Hive uses default column names like _c0, so we rename them to something more meaningful, like avg_quality.
This transformation is repeated for each of the CSVs produced by Hive (e.g., avg_alcohol_red, quality_distribution_red).

---

### 5. Data Visualization (Matplotlib + Seaborn)

#### Full Code: []()
After processing and cleaning the data, we use Matplotlib and Seaborn to create visualizations.
Example: Distribution of Wine Quality

```bash
import seaborn as sns
import matplotlib.pyplot as plt

# Plot the quality distribution for red wines
sns.countplot(data=df_quality_dist_red, x="quality", palette="coolwarm")
plt.title('Quality Distribution - Red Wines')
plt.xlabel('Quality')
plt.ylabel('Count')
plt.show()
```

Explanation:

sns.countplot(): Plots a count plot, which is useful for showing the distribution of categorical variables (in this case, wine quality).
plt.title(): Adds a title to the plot.
plt.show(): Displays the plot.
We create various other visualizations:
- Bar plots comparing the average alcohol content between red and white wines.
- Heatmaps showing the correlation between different features (e.g., acidity, alcohol content) and quality.

---

### 6. Data Insights

#### Refer ppt for in depth analysis: [PRESENTATION](https://docs.google.com/presentation/d/18TYw-3SQEVxb8KIZz0kvr0RWwLV3ZIf8VNfJO349NGE/edit?usp=sharing)
From the visualizations and statistics, we can draw meaningful insights about the relationship between various chemical features and wine quality. Some key findings:
White wines generally have higher quality ratings, with most quality scores falling between 6 and 7.
Alcohol content has a positive correlation with wine quality across both red and white wines.
Certain features like citric acid and pH show a strong correlation with quality in red wines.

---

### 7. Future Scope

This project lays a strong foundation for future work in the following areas:
- Machine Learning Models: We can apply machine learning algorithms (like Logistic Regression, Random Forests, and SVM) to predict wine quality based on the chemical properties.
- Principal Component Analysis (PCA): Use PCA to reduce the feature space and identify the most influential variables.
- Real-Time Data Processing: Integrate Apache Kafka to handle real-time streams of wine data and process them in real-time.

---

### Author:
👤 Ved — Final-year IT undergrad, Tech-Lead @ IEEE-VIT, interested in Big Data, Cybersecurity, and DevOps.
Feel free to reach out for collaborations!
