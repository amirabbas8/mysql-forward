# mysql-forward

Forward MySQL to MySQL

## Basic usage

```sh
$ docker run -e MYSQL_USER=user -e MYSQL_PASSWORD=password -e MYSQL_HOST=localhost \
  -e MYSQL_DEST_USER=user -e MYSQL_DEST_PASSWORD=password -e MYSQL_DEST_HOST=localhost amirabbas8/mysql-forward
```

## Environment variables

- `MYSQLDUMP_OPTIONS` mysqldump options (default: --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384)
- `MYSQLDUMP_DATABASE` list of databases you want to forward (default: --all-databases)
- `MYSQL_HOST` the mysql host *required*
- `MYSQL_PORT` the mysql port (default: 3306)
- `MYSQL_USER` the mysql user *required*
- `MYSQL_PASSWORD` the mysql password *required*
- `MYSQL_DEST_HOST` the mysql host dest*required*
- `MYSQL_DEST_PORT` the mysql port dest(default: 3306)
- `MYSQL_DEST_USER` the mysql user dest*required*
- `MYSQL_DEST_PASSWORD` the mysql password dest*required*

### Automatic Periodic Forwards

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the forward automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).
