package com.dox91.spark

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types._
import org.apache.spark.sql.streaming._
import org.apache.kafka._
import org.apache.spark.streaming._


object KafkaProducerApp {
  def main(args: Array[String]): Unit = {
    val KTOPIC = "test-stream-csv-topic"
    val DATAPATH = "/home/anh/data/moviedata/"

    val spark = SparkSession
      .builder
      .appName("Spark-Kafka-Integration-L")
      .getOrCreate()

    val mySchema = StructType(Array(
      StructField("id", IntegerType),
      StructField("name", StringType),
      StructField("year", IntegerType),
      StructField("rating", DoubleType),
      StructField("duration", IntegerType)
    ))

    val streamingDataFrame = spark.readStream.schema(mySchema).csv(DATAPATH)

    val recordToKafka = streamingDataFrame.selectExpr("CAST(id AS STRING) AS key", "to_json(struct(*)) AS value").
      writeStream
      .format("kafka")
      .option("topic", KTOPIC)
      .option("kafka.bootstrap.servers", "localhost:9092")
      .option("checkpointLocation", "/tmp/checkpoint/")
      .queryName("from-csv-stream-to-kafka")
      .start()

    recordToKafka.awaitTermination()


  }
}
