## What is Mongo Replica set ?

A replica set is a group of mongod instances that host the same data set. In a replica, one node is primary node that receives all write operations. All other instances, such as secondaries, apply operations from the primary so that they have the same data set. Replica set can have only one primary node. <br>
At the time of automatic failover or maintenance, election establishes for primary and a new primary node is elected.
After the recovery of failed node, it again join the replica set and works as a secondary node.

## Setup Replica set with auth in single cluster ?

<summary>export env value for URL</summary>

```
export URL=Host-IP
```
 <br>

<summary> Create a key file for authentication , you can also use x.509 certs </summary>

```
openssl rand -base64 700 > /home/ubuntu/testing/file.key
```

<summary> Write docker compose file  i.e docker-compose-auth.yaml to configure replica set </summary>

```
version: "3.3"
services:
    mongo11:
        restart: always
        depends_on:
          - mongo22
          - mongo33
        image: mongo:4.4
        container_name: mongo11
        #command: ["--replSet", "my-replica-set-test-new",  "--port", "40011"]
        entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "my-replica-set-test-new", "--journal", "--bind_ip_all", "--port", "40011" ]
        volumes:
          - "/home/ubuntu/testing/file.key:/data/file.key"
          - /home/ubuntu/data/mongo11:/data/db
        ports:
          - 40011:40011
        healthcheck:
          test: test $$(echo "rs.initiate({\"_id\":\"my-replica-set-test-new\",\"members\":[{\"_id\":0,\"host\":\"${URL}:40011\"},{\"_id\":1,host:\"${URL}:40022\"},{\"_id\":2,\"host\":\"${URL}:40033\"}]}).ok || rs.status().ok" | mongo --port 40011 --quiet) -eq 1
          interval: 10s
          start_period: 30s
        networks:
          - mynetest
    mongo22:
        restart: always
        image: mongo:4.4
        container_name: mongo22
        #command: ["--replSet", "my-replica-set-test-new",  "--port", "40022"]
        entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "my-replica-set-test-new", "--journal", "--bind_ip_all", "--port", "40022" ]
        volumes:
          - "/home/ubuntu/testing/file.key:/data/file.key"
          - /home/ubuntu/data/mongo22:/data/db
        ports:
          - 40022:40022
        networks:
          - mynetest
    mongo33:
        image: mongo:4.4
        restart: always
        container_name: mongo33
        #command: ["--replSet", "my-replica-set-test-new",  "--port", "40033"]
        entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "my-replica-set-test-new", "--journal", "--bind_ip_all", "--port", "40033" ]
        volumes:
         - "/home/ubuntu/testing/file.key:/data/file.key"
         - /home/ubuntu/data/mongo33:/data/db
        ports:
          - 40033:40033
        networks:
          - mynetest
networks:
  mynetest:
    name: mynetest
    driver: "bridge"
```
<summary> Now, start the docker compose file  </summary>

```
docker-compose -f docker-compose-auth.yaml up -d
```
<summary> Now, check mongo container started or not ! </summary>

OUTPUT:

```
CONTAINER ID   IMAGE       COMMAND                  CREATED              STATUS                        PORTS                                                      NAMES
d31f1295d9c3   mongo:4.4   "/usr/bin/mongod --k…"   About a minute ago   Up About a minute (healthy)   27017/tcp, 0.0.0.0:40011->40011/tcp, :::40011->40011/tcp   mongo11
02649c5913e5   mongo:4.4   "/usr/bin/mongod --k…"   About a minute ago   Up About a minute             27017/tcp, 0.0.0.0:40033->40033/tcp, :::40033->40033/tcp   mongo33
ce64f2604954   mongo:4.4   "/usr/bin/mongod --k…"   About a minute ago   Up About a minute             27017/tcp, 0.0.0.0:40022->40022/tcp, :::40022->40022/tcp   mongo22

```
<summary> Now to enable authentication, exec inside primaray mongo conatiner and create initial user. </summary>

```
docker exec  -it mongo11 mongo --port 40011
use admin
admin = db.getSiblingDB("admin");
admin.createUser({user: "admin", pwd:"password", roles:[{role:"root", db:"admin"}]});
db.auth("admin", "password");
rs.status()
```

<summary> Also, we can verify replica status from secondary mongo conatiner </summary>

```
rs.slaveOk()
rs.secondaryOk()
```
Now, setup is done and replica set is up and running. <br> <br>

### Enable Auth In Already Running Replica Set in single cluster :
<summary> Existing docker-compose of replica set without auth should be up and running </summary> <br>
<summary> Create a key file </summary> <br>
<summary> Add Entrypoint command in docker compose file </summary> 

```
entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "my-replica-set-test-new", "--journal", "--bind_ip_all", "--port", "40022" ]
```
**Note** :  Make sure to provide your existing mongo replica set name under `--replSet` key

<summary>Also add volume mount of key file </summary>

```
volumes:
         - "/home/ubuntu/testing/file.key:/data/file.key"
```
<summary>Restart docker compose file </summary>

```
docker-compose up -d
```
<summary> Go inside primary mongo conatiner and create initial admin user </summary>


# Setup Replica set with auth in multiple cluster ?
<summary> Export some env value </summary>

```
export HOST1=cluster1-ip
export HOST2=cluster2-ip
export HOST3=cluster3-ip
```
<summary> Create a openssl key file </summary>

```
openssl rand -base64 700 > /home/ubuntu/testing/file.key
```

<summary> Tranfer above opnssl key to other server </summary>
<br>
<summary> Run below docker compose file in server 1 </summary>

```
version: "3.3"
services:
    mongoquiz1:
        restart: always
        image: mongo:4.4
        container_name: mongoquiz1
        #command: ["--replSet", "dev-kenko-test", "--port", "40061"]
        entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "rs-key", "--journal", "--bind_ip_all", "--port", "40050" ]
        ports:
          - 40050:40050
        volumes:
          - /home/ubuntu/data/mongoquiz1:/data/db
          - "./scripts/file.key:/data/file.key"
        healthcheck:
          test: test $$(echo "rs.initiate({\"_id\":\"rs-key\",\"members\":[{\"_id\":0,\"host\":\"${HOST1}:40050\"},{\"_id\":1,host:\"$:40051\"},{\"_id\":2,\"host\":\"${HOST3}:40052\"}]}).ok || rs.status().ok" | mongo --port 40050 --quiet) -eq 1
          interval: 10s
          start_period: 30s

```
<summary> Similarly, run below docker compose file in server 2 </summary>

```
version: "3.3"
services:
    mongoquiz2:
        restart: always
        image: mongo:4.4
        container_name: mongoquiz2
        #command: ["--replSet", "dev-kenko-test", "--port", "40062"]
        entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "rs-key", "--journal", "--bind_ip_all", "--port", "40051" ]
        ports:
          - 40051:40051
        volumes:
          - /home/ubuntu/data/mongoquiz2:/data/db
          - "./scripts/file.key:/data/file.key"
```

<summary> Similarly, run below docker compose file in server 3 </summary>

```
version: "3.3"
services:
    mongoquiz3:
        restart: always
        image: mongo:4.4
        container_name: mongoquiz3
        #command: ["--replSet", "dev-kenko-test", "--port", "40062"]
        entrypoint: [ "/usr/bin/mongod", "--keyFile", "/data/file.key", "--replSet", "rs-key", "--journal", "--bind_ip_all", "--port", "40052" ]
        ports:
          - 40052:40052
        volumes:
          - /home/ubuntu/data/mongoquiz2:/data/db
          - "./scripts/file.key:/data/file.key"
```

<summary> Now ,start the docker-compose of server-2 and server-3 , after that start docker-compose of  primary server</summary>
<br>
<summary> Now , exec into mongo shell of primary conatiner and crete initial admin user </summary>

```
admin = db.getSiblingDB("admin");
admin.createUser({user: "admin", pwd:"password", roles:[{role:"root", db:"admin"}]});
db.auth("admin", "password");
show dbs
rs.status()
```

**Refrences** <br>
[Medium Blog](https://prashix.medium.com/setup-mongodb-replicaset-with-authentication-enabled-using-docker-compose-5edd2ad46a90)

