#!/usr/bin/env bash
SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTDIR
source ../../../initialSetup/helper/set_home_variables.sh 


$SPARK_HOME/bin/spark-submit \
  --class "com.dox91.spark.KafkaProducerAppRight" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
/home/anh/IdeaProjects/SparkApp/target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar

$SPARK_HOME/bin/spark-submit \
  --class "com.dox91.spark.KafkaProducerAppLeft" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
/home/anh/IdeaProjects/SparkApp/target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar

