# rails-mysql-loadtest

## Load Testing MySQL with Rails and Unicorn

I'm setting a max connection limit of 10 connections. I'm using Unicorn to spawn multiple Rails processes and connections.

## Docker-Compose

Use the following command to respawn the DB and application:

```
docker-compose stop && docker-compose rm -f && docker-compose build && docker-compose up -d && docker-compose ps
```

Look at Rails logs here:

```
docker-compose logs rails
```
