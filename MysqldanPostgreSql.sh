#!/bin/bash

# Cek apakah MySQL terpasang
if command -v mysql &> /dev/null; then
    echo "MySQL terdeteksi."
    
    # Konfigurasi MySQL
    MYSQL_USER="username"
    MYSQL_PASSWORD="password"
    MYSQL_DATABASE="database_name"

    # Nama file backup dengan tanggal saat ini
    DATE=$(date +%d-%m-%Y)
    MYSQL_BACKUP_FILENAME="mysql_backup_$DATE.sql"
    
    # Backup MySQL
    mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $MYSQL_BACKUP_FILENAME
    
    # Pindahkan file backup MySQL ke direktori tertentu
    MYSQL_BACKUP_DIR="/path/to/mysql/backup/directory"
    mv $MYSQL_BACKUP_FILENAME $MYSQL_BACKUP_DIR
    
    echo "Backup MySQL selesai."
    echo "Proses backup database selesai."
    exit 0
fi

# Cek apakah PostgreSQL terpasang
if command -v psql &> /dev/null; then
    echo "PostgreSQL terdeteksi."
    
    # Konfigurasi PostgreSQL
    POSTGRES_USER="username"
    POSTGRES_PASSWORD="password"
    POSTGRES_DATABASE="database_name"

    # Nama file backup dengan tanggal saat ini
    DATE=$(date +%d-%m-%Y)
    POSTGRES_BACKUP_FILENAME="postgres_backup_$DATE.sql"
    
    # Backup PostgreSQL
    PGPASSWORD=$POSTGRES_PASSWORD pg_dump -U $POSTGRES_USER -d $POSTGRES_DATABASE > $POSTGRES_BACKUP_FILENAME
    
    # Pindahkan file backup PostgreSQL ke direktori tertentu
    POSTGRES_BACKUP_DIR="/path/to/postgres/backup/directory"
    mv $POSTGRES_BACKUP_FILENAME $POSTGRES_BACKUP_DIR
    
    echo "Backup PostgreSQL selesai."
    echo "Proses backup database selesai."
    exit 0
fi

echo "Tidak ada MySQL atau PostgreSQL yang terdeteksi."
echo "Proses backup database tidak berjalan."
exit 1
