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



