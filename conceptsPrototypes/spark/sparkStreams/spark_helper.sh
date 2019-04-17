#source ../../../initialSetup/set_home_variables.sh > /dev/null 2>&1

source /home/anh/CodingProjects/dataScienceEngineering/initialSetup/set_home_variables.sh > /dev/null 2>&1
cd $SPARK_HOME
##############################################
### submit spark-job: SimpleApp 
##############################################
./bin/spark-submit \
  --class "com.dox91.spark.SimpleApp" \
  --master local[4] \
/home/anh/IdeaProjects/SparkApp/target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar

##############################################
### submit spark-job: KafkaProducerApp
##############################################
./bin/spark-submit \
  --class "com.dox91.spark.KafkaProducerApp" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
/home/anh/IdeaProjects/SparkApp/target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar

##############################################
### start form spark-shell
##############################################
./bin/spark-shell \
  --class "com.dox91.spark.KafkaProducerApp" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
/home/anh/IdeaProjects/SparkApp/target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar

