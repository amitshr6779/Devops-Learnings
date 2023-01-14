## Scenarios for Backup and Restore

**Take dump of a complete database**

```
docker exec <Container-Name> sh -c 'exec mongodump --db <DB-Name> --port <DB-Port> --authenticationDatabase admin -u <Username> -p <Password> --gzip --archive' > dump_<DB-Name>.gz
```
<br>

**To restore dump of a complete database**

```
docker exec -i <conatiner-name> mongorestore --port <db-port> --authenticationDatabase admin -u <username> -p <password>  --drop  --nsInclude=<DB-NAME>.*  --gzip --archive < /path/of/dump/file.gz
```

```
docker exec -i <conatiner-name> mongorestore --port <db-port> --authenticationDatabase admin -u <username> -p <password>  --drop  --nsInclude=<DB-NAME>.*  --gzip --archive=/path/of/dump/file.gz
```
**To restore dump to diffrent database**

```
docker exec -i <container-name> mongorestore --port <db-port> --authenticationDatabase admin -u <username> -p <password>  --nsFrom "<DB_NAME>.*" --nsTo "<DB_NAME_RESTORE>.*"  --gzip --archive=dump_file.gz
```
**To take collection dump as json**

```
docker exec -i <Contsiner-Name>  mongoexport --db $DB_NAME --port 27017  --username $user --password $password --authenticationDatabase admin --collection $COLLECTION_NAME --type=json > ./$COLLECTION_NAME.json
```
**To restore collection**

```
docker exec -i $CONTAINER_NAME mongoimport --host $HOST:$PORT --username $user --password $password --authenticationDatabase admin --drop --db $DB_NAME --drop --collection $COLLECTION_NAME < $COLLECTION_NAME.json
```
