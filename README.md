## Apache Spark 2.4.4
### OpenJDK 11.0.4 and Python 3.7.4 (Anaconda3 2019.07)
-----

### Pull image
```
docker pull izone/spark
```
### Run
```
docker run --rm --name Spark \
-p 8888:8888 \
-p 4040:4040 \
-v $HOME/notebooks:/root/notebooks \
-ti izone/spark pyspark
```

### Access Browser
```
http://localhost:8888/
```

-----
### Build
```
docker build -t izone/spark .
```
