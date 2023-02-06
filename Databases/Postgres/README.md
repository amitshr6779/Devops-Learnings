## Setup Postgres DB using docker-compose

```
version: '3.8'
services:
  postgres:
    image: postgres:14.5
    restart: always
    container_name: postgres
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=UaTr0fMt24Jj
    # - POSTGRES_HOST_AUTH_METHOD=md5
    ports:
      - '5432:5432'
    volumes:
      - /home/ubuntu/data/postgres:/var/lib/postgresql/data
volumes:
  db:
    driver: local

```

**Configure Postgres db to use custom port**

```
version: '3.8'
services:
  postgres:
    image: postgres:14.5
    restart: always
    container_name: postgres-data
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=ZaTw0fMt64Jj
      - POSTGRES_HOST_AUTH_METHOD=md5
    ports:
      - '5001:5001'
    volumes:
      - /home/ubuntu/data/postgres-data:/var/lib/postgresql/data
    command: -p 5001
volumes:
  db:
    driver: local
```

**To Enable Auth for all local connection in Postgres db** <br>
Edit `pg_hba.conf` file, located in path `/var/lib/postgresql/data`

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     md5

```
**Note:** Remember that the entries in pg_hba are processed in the order they given.  
`"local all postgres trust"` .should allow me to log in  without password
And it would, if it appeared before the line that forced every local connection to use md5 authentication!

### POSTGRES CHEATSHEET:

- To access psql cli
```
psql -U <USERNAME>
```
- To access psql cli with custom port:
```
psql -U <USERNAME> -p <PORT>
```
- To access psql without password prompt:
```
PGPASSWORD=<YOUR-PASSWORD> psql -U <USERNAME> -p <PORT>
```
- To access psql with connection string
```
psql <Your-DB-Connection-String>
```
- To connect remote postgres db
```
psql -h <hostname or ip address> -p <port number of remote machine> -d <database name which you want to connect> -U <username of the database server>
```
- To connect remote postgres db without password prompt
```
PGPASSWORD=<YOUR-PASSWORD> psql -h <hostname or ip address> -p <port number of remote machine> -d <database name which you want to connect> -U <username of the database server>
```
Some Postgres DB releated commands:
```
\l = list database

\c = check which database

\c test = (switched to test db )

\dt = about relations/tables

\dt schema1.  OR SET schema 'inventory';  =  List tables inside particular schemas. For eg: 'schema1'.
```
- To create DB and Inserting, Updating data
```
CREATE DATABASE <DATABASE-NAME>;

grant all privileges on database <DATABASE-NAME> to <USER>;

\c <DATABASE-NAME>

CREATE TABLE playground (
    equip_id serial PRIMARY KEY,
    type varchar (50) NOT NULL,
    color varchar (25) NOT NULL,
    location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')),
    install_date date
);



INSERT INTO playground (type, color, location, install_date) VALUES ('slide', 'blue', 'south', '2017-04-28');
INSERT INTO playground (type, color, location, install_date) VALUES ('swing', 'yellow', 'northwest', '2018-08-16');
update customers set first_name = 'shelby' where id = 1001;
```

- To List data from table
```
SELECT * FROM playground;
          OR
SELECT * FROM "playground";
````

- To take dump and restore using docker command
```
docker exec -i <conatiner-name> /bin/bash -c "PGPASSWORD=<PASSWORD> pg_dump -U <USER> -p <PORT> <DATABASE-TO-DUMP>" > <DUMP-FILE>.sql

docker exec -i <conatiner-name> /bin/bash -c "PGPASSWORD=<PASSWORD> dropdb -h 0.0.0.0 -p <PORT>  -U <USER> -f <DB-TO-DROP>"

docker exec -i <conatiner-name> /bin/bash -c "PGPASSWORD=<PASSWORD> createdb -h 0.0.0.0 -p <PORT>  -U <USER> -T template0 <DB-to-CREATE>"

docker exec -i <conatiner-name> /bin/bash -c "PGPASSWORD=<PASSWORD> psql -U <USER> -p <PORT> <DATABASE-TO-RESTORE>" < ./<DUMP-FILE>.sql
```
**NOTE**: The drop will fail when there are open connections to the database

- To Drop DB forcefully
```
DROP DATABASE <Database> WITH (FORCE);
```

- To Restore Dump File
```
cat <Dump-File>.sql | psql -U <USER> -p <PORT> -d <DB-NAME>
```
