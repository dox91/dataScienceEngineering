#!/usr/bin/env bash
SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTDIR
source ../../../initialSetup/set_home_variables.sh 

##############################################
### submit spark-job: KafkaProducerApp
##############################################
$SPARK_HOME/bin/spark-submit \
  --class "com.dox91.spark.KafkaProducerApp" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
/home/anh/IdeaProjects/SparkApp/target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar
