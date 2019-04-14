package com.dox91.spark

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types._
import org.apache.spark.sql.streaming._
import org.apache.kafka._


object KafkaProducerApp {
  def main(args: Array[String]) {
    //val logFile = "/home/anh/spark/spark-2.4.0-bin-hadoop2.7/README.md" // Should be some file on your system
    //val spark = SparkSession.builder.appName("Simple Application").getOrCreate()

    val spark = SparkSession
      .builder
      .appName("Spark-Kafka-Integration")
      .getOrCreate()

    //println(s"START KAFKA PRODUCER")

    //spark.sparkContext.setLogLevel("ERROR")

    val mySchema = StructType(Array(
      StructField("id", IntegerType),
      StructField("name", StringType),
      StructField("year", IntegerType),
      StructField("rating", DoubleType),
      StructField("duration", IntegerType)
    ))

    val streamingDataFrame = spark.readStream.schema(mySchema).csv("/home/anh/data/")


    streamingDataFrame.selectExpr("CAST(id AS STRING) AS key", "to_json(struct(*)) AS value").
      writeStream
      .format("kafka")
      .option("topic", "join-topic-output")
      .option("kafka.bootstrap.servers", "localhost:9092")
      .option("checkpointLocation", "/home/anh/data/")
      .start()

    spark.stop()
  }
}
