# Install the mongo-hadoop project in the mongo-hadoop directory in the root of our project.
echo "Installing the mongo-hadoop project in $PROJECT_HOME/mongo-hadoop ..."
curl -Lko /tmp/mongo-hadoop-r2.0.2.tar.gz https://github.com/mongodb/mongo-hadoop/archive/r2.0.2.tar.gz
mkdir mongo-hadoop
tar -xvzf /tmp/mongo-hadoop-r2.0.2.tar.gz -C mongo-hadoop --strip-components=1

# Now build the mongo-hadoop-spark jars
echo "Building mongo-hadoop..."
cd mongo-hadoop
./gradlew jar
cd ..
cp mongo-hadoop/spark/build/libs/mongo-hadoop-spark-*.jar lib/
cp mongo-hadoop/build/libs/mongo-hadoop-*.jar lib/

# Now build the pymongo_spark package
# pip install py4j # add sudo if needed
# pip install pymongo # add sudo if needed
# pip install pymongo-spark # add sudo if needed
cd mongo-hadoop/spark/src/main/python
python setup.py install
cp $PROJECT_HOME/mongo-hadoop/spark/src/main/python/pymongo_spark.py $PROJECT_HOME/lib/
export PYTHONPATH=$PYTHONPATH:$PROJECT_HOME/lib
echo 'export PYTHONPATH=$PYTHONPATH:$PROJECT_HOME/lib' >> ~/.bash_profile
