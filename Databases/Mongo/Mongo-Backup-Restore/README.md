## Scenarios for Backup and Restore

**Take dump of complete database**

```
docker exec <Container-Name> sh -c 'exec mongodump --db <DB-Name> --port <DB-Port> --authenticationDatabase admin -u <Username> -p <Password> --gzip --archive' > dump_<DB-Name>.gz
```
