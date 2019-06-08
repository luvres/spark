## Spark 2.4.3
### Java 11.0.2
### Python 3.7.3
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
