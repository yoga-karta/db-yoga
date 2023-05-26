#!/bin/bash
#penambahan directory
DATE=$(date +%d-%m-%Y)
MYSQL_USER="yogakarta"
MYSQL_PASSWORD="Yoga230499*"
MYSQL_DATABASE="DATABASES"

#nama file backup dan tanggal hari ini
DATE=$(date +%d-%m-%Y)
MYSQL_BACKUP_FILENAME=Cadangan_BantuanUINSK_$DATE.sql

mysqldump --all-databases -u yogakarta  -p Yoga230499* bantuan > Cadangan_BantuanUINSK_$DATE.sql

#file tersimpan di
MYSQL_BACKUP_DIR="$home/yogakarta/BantuanUINSK-Utama"
mv $MYSQL_BACKUP_FILENAME $MYSQL_BACKUP_DIR

#Notif
echo "Backup databases selesai"


