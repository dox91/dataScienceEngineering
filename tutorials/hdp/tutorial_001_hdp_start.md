# Tutorial 001 - Getting Started

### 1. Preparation
```bash
# set Project HOME path
export DSE_HOME=~/CodingProjects/dataScienceEngineering
cd $DSE_HOME

# start HDP VM
bash initialSetup/setup_start_hdp_vb.sh

# ssh to hdp-node (docker) inside VM
ssh root@sandbox-hdp.hortonworks.com -p 2222
```

### 2. First steps with HDFS (Hadoop Distributed File System)
```bash
#https://www.cloudera.com/tutorials/manage-files-on-hdfs-via-cli-ambari-files-view/1.html

# Download geolocation.csv, trucks.csv
wget https://github.com/hortonworks/data-tutorials/raw/master/tutorials/hdp/manage-files-on-hdfs-via-cli-ambari-files-view/assets/drivers-datasets/geolocation.csv
wget https://github.com/hortonworks/data-tutorials/raw/master/tutorials/hdp/manage-files-on-hdfs-via-cli-ambari-files-view/assets/drivers-datasets/trucks.csv

#Login under hdfs user
su hdfs
cd

#1. We will give root access to read and write to the user directory. 
#Later we will perform an operation in which we send a file from our local filesystem to hdfs.
hdfs dfs -chmod -R 777 /user

#2. Type the following command, so we can switch back to the root user. 
#We can perform the remaining file operations under the user folder since the permissions were changed.
exit


#1. Let's create the directory for the driver dataset 
#by entering the following commands into your terminal:

#Creates a directory called hadoop under users
hdfs dfs -mkdir /user/hadoop
#Creates two directories geolocation.csv and trucks.csv under the directory hadoop
hdfs dfs -mkdir /user/hadoop/geolocation /user/hadoop/trucks


#Check what we have done
#List the content of the hadoop directory
hdfs dfs -ls /user/hadoop


#1. Now let's copy both source files from your local file system 
#to the Hadoop Distributed File System by entering the following commands into your terminal:

#Copy the geolocation.csv file to HDFS
hdfs dfs -put geolocation.csv /user/hadoop/geolocation
#Copy the trucks.csv file to HDFS
hdfs dfs -put trucks.csv /user/hadoop/trucks


#List the content of the geolocation directory
hdfs dfs -ls /user/hadoop/geolocation
##List the content of the trucks directory
hdfs dfs -ls /user/hadoop/trucks

#See first lines of csv file in hdfs
hdfs dfs -cat '/user/hadoop/geolocation/geolocation.csv' | head -10
```

### 3. First steps with Hive
```bash
#http://www.javachain.com/load-data-into-hive-table-from-hdfs/
#https://community.cloudera.com/t5/Support-Questions/Create-Hive-Table-from-HDFS-files/m-p/53057
#https://community.cloudera.com/t5/Support-Questions/beeline-no-current-connection/td-p/147659

# in HDP: enter supported Hive CLI commands by invoking Beeline using the hive keyword
hive

# show databases
show databases;
# show tables
show tables;

# Load data from hdfs to hive - 2 methods
# A) managed table (using only load data)
#	-> moves file from hdfs to /user/hive/warehouse 
# B) external table (using external keyword)
#	-> leaves file where it is, but creates table definition in hive metastore 


# Method B - create external table
create external table geolocation(
truckid int,
driverid int,
event string,
latitude double,
longitude double, 
city string,
state string,
velocity int,
event_ind int,
idling_ind int)
row format delimited
fields terminated by ',' 
stored as textfile
location '/user/hadoop/geolocation'
;

# see table
show tables;

# Load data from HDFS path into Hive
#load data inpath '/user/hadoop/geolocation/geolocation.csv' into table geolocation;

# Select values in hive table
select * from geolocation limit 5;


```