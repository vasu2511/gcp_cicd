from pyspark.sql import SparkSession
from pyspark.sql.functions import lit

spark = SparkSession.builder.getOrCreate()

df1 = spark.read.option("header","true").csv("gs://my-bucket-vasu2511/input/StudentData.csv")

df2 = df1.withColumn("vasu_extra_column",lit("extra_data"))

df2.write.option("header","true").mode("overwrite").csv("gs://my-bucket-vasu2511/output/")

print("completed")