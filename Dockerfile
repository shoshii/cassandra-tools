FROM shoshii/cassandra-centos:4.0.1

USER root
RUN yum install -y git
RUN pip3 install -U pip
RUN git clone https://github.com/shoshii/fab
RUN pip3 install /fab

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]