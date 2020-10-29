FROM alpine:latest
LABEL maintainer="Amir Abbas <am_882011@live.com>"

ADD install.sh install.sh
RUN sh install.sh && rm install.sh

ENV MYSQLDUMP_OPTIONS --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384
ENV MYSQLDUMP_DATABASE --all-databases
ENV MYSQL_HOST **None**
ENV MYSQL_PORT 3306
ENV MYSQL_USER **None**
ENV MYSQL_PASSWORD **None**
ENV MYSQL_DEST_HOST **None**
ENV MYSQL_DEST_PORT 3306
ENV MYSQL_DEST_USER **None**
ENV MYSQL_DEST_PASSWORD **None**
ENV SCHEDULE **None**

ADD run.sh run.sh
ADD forward.sh forward.sh

CMD ["sh", "run.sh"]
