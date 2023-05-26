#!/bin/bash 

# MySQL Configuration
MYSQL_USER="mysql_username"
MYSQL_PASSWORD="mysql_password"
MYSQL_HOST="localhost"
MYSQL_DATABASE="mysql_database_name"
MYSQL_BACKUP_DIR="/path/to/mysql/backup/directory"


# Backup MySQL
MYSQL_FILENAME="$MYSQL_BACKUP_DIR/$MYSQL_DATABASE-$(date +%Y%m%d%H%M%S).sql"
mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $MYSQL_FILENAME
