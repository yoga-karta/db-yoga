#!/bin/bash

# Konfigurasi MySQL
MYSQL_USER="username"
MYSQL_PASSWORD="password"
MYSQL_DATABASE="database_name"

# Konfigurasi PostgreSQL
POSTGRES_USER="username"
POSTGRES_PASSWORD="password"
POSTGRES_DATABASE="database_name"

# Nama file backup dengan tanggal saat ini
DATE=$(date +%d-%m-%Y)
MYSQL_BACKUP_FILENAME="mysql_backup_$DATE.sql"
POSTGRES_BACKUP_FILENAME="postgres_backup_$DATE.sql"

# Backup MySQL
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $MYSQL_BACKUP_FILENAME

# Backup PostgreSQL
PGPASSWORD=$POSTGRES_PASSWORD pg_dump -U $POSTGRES_USER -d $POSTGRES_DATABASE > $POSTGRES_BACKUP_FILENAME

# Pindahkan file backup MySQL ke direktori tertentu
MYSQL_BACKUP_DIR="/home/user/mysql_backup"
mv $MYSQL_BACKUP_FILENAME $MYSQL_BACKUP_DIR

# Pindahkan file backup PostgreSQL ke direktori tertentu
POSTGRES_BACKUP_DIR="/home/user/postgres_backup"
mv $POSTGRES_BACKUP_FILENAME $POSTGRES_BACKUP_DIR

echo "Backup databases selesai"


