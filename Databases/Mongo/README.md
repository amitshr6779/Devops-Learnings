
## What is MongoDB ?
<summary> MongoDB is a document-oriented NoSQL database used for high volume data storage. </summary>

<summary> Instead of using tables and rows as in the traditional relational databases, MongoDB makes use of collections and documents. </summary>

<summary> Documents consist of key-value pairs which are the basic unit of data in MongoDB. </summary>

<summary> Collections contain sets of documents and function which is the equivalent of relational database tables. </summary>
</br>

Let's create mongodb conatiner using `docker-compose.yaml` file :

```

version: "3.7"
services:
    mongoservice1:
        restart: always
        image: mongo:4.4
        container_name: mongocontainername
        command: ["--port", "40000"]
        environment:
          MONGO_INITDB_ROOT_USERNAME: user1
          MONGO_INITDB_ROOT_PASSWORD: ndIWQO2J85kjS  
          MONGO_INITDB_DATABASE: admin
        ports:
          - 40000:40000
        volumes:
          - /home/ubuntu/data/mongoservice1:/data/db
```

Now start the conatiner using ` docker-compose up -d `
</br>
</br>

## How To Use the MongoDB Shell ?

#### Get inside mongo conatiner
```docker exec -it mongocontainername bash```
#### Start mongo shell
```mongo --port 40000```

#### Switch to admin database
``` use admin```
#### Login to DB, if DB is Auth Protected
```db.auth("username", "password")```
#### List DBs
```show dbs```
#### List collections
```show collections```
#### Fetch data inside a collection
``` db.your-collection-name.find()```
#### Create user and assign role
```db.createUser( { user: "USERNAME",  pwd: "PASSWORD", roles: [ { role: "read",  db: "DB-NAME" } ] });```

#### To insert some data inside , DB

```
use pets
db.pets.insert({name : 'pet'})
db.pets.insert({age : '2'})
db.pets.insert({breed : 'german'})

use pets
show collections
db.pets.find()
db.pets.find().pretty()
```
