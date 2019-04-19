# Spark Kafka Integration Demos

## Table of content
1. SparkApp1: demo project to read from csv and write to kafka topic
2. SparkApp2: demo project to read from csv,write into 2 kafka topics, which will result in joined topic (KStreamsApp in background) 


### Project SparkApp1: KafkaProducerApp.scala

This demo project shows how to read/stream each line of csv-files inside a given path to Spark streamingDataFrame and then write/stream into a specific Kafka topic

0. Pre-requisites
```
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types._
import org.apache.spark.sql.streaming._
import org.apache.kafka._
import org.apache.spark.streaming._
```

1. Create SparkSession
```
val spark = SparkSession
  .builder
  .appName("Spark-Kafka-Integration-L")
  .getOrCreate()
```

2. Read (Stream) csv-files from given path into streamingDataFrame   
note: In this demo-project DATAPATH=/home/username/data
```
val mySchema = StructType(Array(
      StructField("id", IntegerType),
      StructField("name", StringMy VariableType),
      StructField("year", IntegerType),
      StructField("rating", DoubleType),
      StructField("duration", IntegerType)
    ))

val streamingDataFrame = spark.readStream.schema(mySchema).csv(DATAPATH)
```

3. Write streamingDataFrame while applying spark.sql logic in streaming mode to Kafka topic 
note: In this demo-project KTOPIC="test-stream-csv-topic"
```
val recordToKafka = streamingDataFrame.selectExpr("CAST(id AS STRING) AS key", "to_json(struct(*)) AS value").
  writeStream
  .format("kafka")
  .option("topic", KTOPIC)
  .option("kafka.bootstrap.servers", "localhost:9092")
  .option("checkpointLocation", "/tmp/checkpoint/")
  .queryName("from-csv-stream-to-kafka")
  .start()

recordToKafka.awaitTermination()
```

### Project SparkApp2: KafkaProducerAppLeft.scala, KafkaProducerAppRight.scala

This demo project extends demo project "SparkApp1" by streaming csv files from two different sources(different paths) into two different Kafka topics "input-topic-left" and "input-topic-right" - so far this is nothing new compared to "SparkApp1". However in the background we will start a KStreams Application, that will join based to the keys of the messages in the two mentioned topics. The output of this join will be shown in "join-topic-output". Note: The join logic is inside the KStreams Application and runs independently of "SparkApp2".

In order to start this demo, a script has been prepared: "start_...."

Following steps will be taken
1. Kafka ...
2. KStreams ...
3. Spark Stream ...
