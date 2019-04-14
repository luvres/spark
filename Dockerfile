FROM ubuntu:bionic
MAINTAINER Leonardo Loures <luvres@hotmail.com>


RUN \
	apt-get update \
	&& apt-get install --no-install-recommends -y \
		curl ca-certificates \
  \
  # Java
	&& JAVA_VERSION="11.0.2" && \
	JAVA_VERSION_BUILD="+9" && \
	JAVA_PACKAGE=jdk && \
	URL=f51449fcd52f4d52b93a989c5c56ed3c && \
  \
	curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}${JAVA_VERSION_BUILD}/${URL}/${JAVA_PACKAGE}-${JAVA_VERSION}_linux-x64_bin.tar.gz \
		| tar xzf - -C /opt && mv /opt/jdk* /opt/jdk \
  \
  # Spark
	&& SPARK_VERSION="2.4.1" \
	&& curl http://mirror.nbtelecom.com.br/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
			| tar xzf - -C /opt && mv /opt/spark* /opt/spark \
	&& mkdir /root/notebooks \
  \
  # Anaconda3
  	&& ANACONDA_VERSION="2019.03" \
	&& curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
												-o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
  \
	&& /bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /usr/local/anaconda3 \
	&& ln -s /usr/local/anaconda3/ /opt/anaconda3 \
	&& rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh



ENV PATH=/opt/anaconda3/bin:$PATH

ENV JAVA_HOME=/opt/jdk 
ENV PATH=${PATH}:${JAVA_HOME}/bin:${JAVA_HOME}/sbin

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=ipython
ENV PYSPARK_DRIVER_PYTHON_OPTS="notebook --allow-root \
										 --no-browser \
										 --ip=0.0.0.0 \
										 --notebook-dir=/root/notebooks \
										 --NotebookApp.token=''"

EXPOSE 8888 4040 8080