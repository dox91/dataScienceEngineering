#!/usr/bin/env bash
#http://grosdim.blogspot.com/2013/01/quick-sbt-tutorial.html
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SCALAV=$(scala -version)
# check arguments with flags
#This is the idiom I usually use:
while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo "$package - attempt to capture frames"
                        echo " "
                        echo "$package [options] application [arguments]"
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-a, --action=ACTION       specify an action to use"
                        echo "-o, --output-dir=DIR      specify a directory to store output in"
                        exit 0
                        ;;
                -pn)
                        shift
                        if test $# -gt 0; then
                                PRJNAME=$1
                        else
                                echo "no project-name specified"
                                exit 1
                        fi
                        shift
                        ;;
                --project-name*)
                        shift
                        if test $# -gt 0; then
                                PRJNAME=$1
                        else
                                echo "no project-name specified"
                                exit 1
                        fi
                        shift
                        ;;

        esac
done

cd $SCRIPTDIR
mkdir $PRJNAME
cd $PRJNAME
mkdir -p src/main/java
mkdir -p src/main/scala
mkdir -p src/main/resources
mkdir -p src/test/java
mkdir -p src/test/scala
mkdir -p src/test/resources
touch builder.sbt


tee -a builder.sbt <<< "name := $PRJNAME # project name"
tee -a builder.sbt <<< "version := '0.0.0' #project version"
tee -a builder.sbt <<< "version := '0.0.0' #project version"

scalaVersion := "2.9.2" #the current scala version of the project

#val kafka_streams_scala_version = "0.1.0"
#libraryDependencies ++= Seq("com.lightbend" %%
#  "kafka-streams-scala" % kafka_streams_scala_version)