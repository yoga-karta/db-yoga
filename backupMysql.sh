#penambahan directory

DATE=$(date +%d-%m-%Y)
BACKUP_DIR="/home/yogakarta/BantuanUINSK-Utama"
MYSQL_USER="root"
MYSQL_PASSWORD="Yoga230499*"
MYSQL="$ mariadb"
DB="bantuan"
echo $DB
mysqldump -u root -p$Yoga230499* $DB | gzip -9 > "$/home/yogakarta/BantuanUINSK-Utama/bantuan-$DATE.sql.gz"
find $/home/yogakarta/BantuanUINSK-Utama/* -mtime +5 -exec rm {} \;

