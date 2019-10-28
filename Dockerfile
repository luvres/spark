FROM openjdk:11.0.5-jdk-slim
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN \
	apt-get update \
	&& apt-get install --no-install-recommends -y \
		curl ca-certificates bzip2 \
  \
  # Spark
    #http://mirror.nbtelecom.com.br/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz
	&& SPARK_VERSION="2.4.4" \
	&& curl -L http://mirror.nbtelecom.com.br/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
			| tar xzf - -C /opt && mv /opt/spark* /opt/spark \
	&& mkdir /root/notebooks \
  \
  # jdbc
    && URL_JDBC="https://github.com/luvres/jdbc/raw/master" \
    && MYSQL_CONN_J_VERSION="8.0.18" \
    && curl -L ${URL_JDBC}/mysql-connector-java-${MYSQL_CONN_J_VERSION}.jar \
                                                -o /opt/spark/jars/mysql-connector-java-${MYSQL_CONN_J_VERSION}.jar \
  \
  # Anaconda3
	&& ANACONDA_VERSION="2019.10" \
	&& curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
												-o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
  \
	&& /bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /usr/local/anaconda3 \
	&& ln -s /usr/local/anaconda3/ /opt/anaconda3 \
	&& rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
  \
	&& /opt/anaconda3/bin/conda upgrade -y conda \
	&& /opt/anaconda3/bin/conda upgrade -y --all \
  \
	&& /opt/anaconda3/bin/pip install --upgrade pip \
	&& /opt/anaconda3/bin/pip install \
		unidecode \
		xgboost \
		mlxtend \
		tensorflow


ENV PATH=/opt/anaconda3/bin:$PATH
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS="notebook --allow-root \
										 --no-browser \
										 --ip=0.0.0.0 \
										 --notebook-dir=/root/notebooks \
										 --NotebookApp.token=''"

EXPOSE 8888 4040 8080
