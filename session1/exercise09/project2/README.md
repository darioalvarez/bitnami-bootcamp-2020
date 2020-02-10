# Exercise 9.2

## Create docker-compose project

### Database Backup: This project is for running a mysqldump in the “WordPress + MariaDB” database. When executing docker-compose up, it should create a backup of the WordPress database and store it in a host path folder

Created a new mariadb container in the same network previously created in exercise 9.1. This container will have a volume linked directly to a host server location. The container will simply run a mysqldump command and make a copy of it, so the actual dump file will be stored in host server location linked with volume.

```
command: bash -c "mysqldump  -h$${MARIADB_HOST} -u$${MARIADB_USER} -P$${MARIADB_PORT_NUMBER}  $${MARIADB_DATABASE} --password=$${MARIADB_PASSWORD}  --single-transaction   > /bitnami/mariadb_backup/backup-`date +%Y%m%d%H%M%S`.sql"
```

The dump will have a timestamp signature, so every new dump will be stored in a new file.

Run following command to deploy containers (Notice that containers from exercise 9.1 should be already running):

```
docker-compose up -d
```

You can check logs to confirm that container started and ended correctly, and if ok, a new file should have been created in backup folder selected in volumes section having the format:

```
backup-yyyymmddHHMMSS.sql
```
