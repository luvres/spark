## Spark 2.4.1
-----

### Pull image
```
docker pull izone/spark
```
### Run
```
docker run --rm --name Spark \
-p 8888:8888 \
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