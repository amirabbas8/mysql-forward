#! /bin/sh

set -e

if [ "${MYSQL_HOST}" == "**None**" ]; then
  echo "You need to set the MYSQL_HOST environment variable."
  exit 1
fi

if [ "${MYSQL_USER}" == "**None**" ]; then
  echo "You need to set the MYSQL_USER environment variable."
  exit 1
fi

if [ "${MYSQL_PASSWORD}" == "**None**" ]; then
  echo "You need to set the MYSQL_PASSWORD environment variable or link to a container named MYSQL."
  exit 1
fi

MYSQL_HOST_OPTS="-h $MYSQL_HOST -P $MYSQL_PORT -u $MYSQL_USER -p $MYSQL_PASSWORD"
MYSQL_DEST_HOST_OPTS="-h $MYSQL_DEST_HOST -P $MYSQL_DEST_PORT -u $MYSQL_DEST_USER -p $MYSQL_DEST_PASSWORD"
DUMP_START_TIME=$(date +"%Y-%m-%dT%H%M%SZ")

if [ "${MYSQLDUMP_DATABASE}" == "--all-databases" ]; then
  DATABASES=$(mysql $MYSQL_HOST_OPTS -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys|innodb)")
else
  DATABASES=$MYSQLDUMP_DATABASE
fi

for DB in $DATABASES; do
  echo "Creating individual dump of ${DB} from ${MYSQL_HOST}..."

  DUMP_FILE="/tmp/${DB}.sql.gz"

  mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS --databases $DB | gzip >$DUMP_FILE

  if [ $? == 0 ]; then
    echo "load $DUMP_FILE"
    gunzip <$DUMP_FILE | mysql $MYSQL_DEST_HOST_OPTS --databases $DB
  else
    echo >&2 "Error creating dump of ${DB}"
  fi
done

echo "SQL forward finished"
