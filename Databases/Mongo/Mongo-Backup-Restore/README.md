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
