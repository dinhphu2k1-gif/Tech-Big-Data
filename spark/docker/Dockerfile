FROM ubuntu:20.04

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget iputils-ping net-tools telnet

# install hadoop 4.2.3
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz && \
    tar -xzvf hadoop-3.2.4.tar.gz && \
    mv hadoop-3.2.4 /usr/local/hadoop && \
    rm hadoop-3.2.4.tar.gz 

RUN wget https://dlcdn.apache.org/spark/spark-3.4.0/spark-3.4.0-bin-hadoop3.tgz && \
    tar -xzvf spark-3.4.0-bin-hadoop3.tgz && \
    mv spark-3.4.0-bin-hadoop3 /usr/local/spark && \
    rm spark-3.4.0-bin-hadoop3.tgz


# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HADOOP_HOME=/usr/local/hadoop 
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# copy config vào thư mục tmp của container
COPY config-hadoop/* /tmp/config-hadoop
COPY config-spark/* /tmp/config-spark

# chuyển file config
RUN mv /tmp/config-hadoop/ssh_config ~/.ssh/config && \
    mv /tmp/config-hadoop/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/config-hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/config-hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/config-hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/config-hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/config-hadoop/workers $HADOOP_HOME/etc/hadoop/workers && \
    mv /tmp/config-hadoop/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/config-hadoop/run-wordcount.sh ~/run-wordcount.sh && \
    mv /tmp/config-spark/spark-env.sh $SPARK_HOME/conf/spark-env.sh && \
    mv /tmp/config-spark/run-example.sh ~/run-example.sh

# cấp quyenf chạy cho các file sh
RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

# chạy service ssh
CMD [ "sh", "-c", "service ssh start; bash"]

