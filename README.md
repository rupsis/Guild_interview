# Guild Engineering Project 


# Development Process Overview
A write up of my thought process while developing this solution can be found [here](Process.md).


# Starting the project

## Requirements:
* [Docker](https://docs.docker.com/get-docker/)
* Postgres [docker image](https://hub.docker.com/_/postgres)
* [Ruby](https://www.ruby-lang.org/en/downloads/) & rails
* A good attitude

## Database:
First pull down the postgres docker image:
```
docker pull postgres
```
next, start the container:
```
docker run --name postgres-db -e POSTGRES_PASSWORD=test -d -p 5555:5432 postgres
```
This will start the container (`postgres-db`) on port `5555` and initialize a `postgres` user with the password `test`. From your db connection of choice, connect to the db with the `postgres` user and execute the [db_setup.sql](/db/db_setup.sql) to create a new database. Once the database, in a new db connection, connect to the guild database and run the [table_setup.sql](/db/table_setup.sql) script. 

</br> *Optional*: you can run the [db_seed.rb](/db/db_seed.rb) script to seed the database:
```
> gem install faker

> gem install pg 

> ruby ./db/db_seed.rd
```

**wait**! Installing `pg` didn't work for me!
In order to install pg, you need to have postgres installed locally. Which is a problem if you're just using docker... 
Fortunately, it seems like you can install pg with just the [libpq](https://michaelrigart.be/install-pg-ruby-gem-without-postgresql/) libraries. 

</br>

**Note**: For the sake of simplicity, I'm using the default postgres user and a simple password. This should be a much more secure password, and passed in via an env var.  

---

## Server: 

