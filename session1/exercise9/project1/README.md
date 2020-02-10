# Exercise 9.1

## Create docker-compose project

### WordPress + MariaDB: Use bitnami/wordpress and bitnami/mariadb. It should have

    * Persistence with volumes
    * Isolated in a network

Created a docker-compose.yml file containind declaration of both containers: mariadb and wordpress. Each of them with their own volume and sharing the same isolated network. Wordpress container has implemented a porth binding with host server, so when deployed it will be possible to see wordpress site in a host web browser.

To test for functionality run:

```
docker-compose up -d
```

Check logs to confirm both containers are fully deployed using:

```
docker-compose logs -f
```

And finaly confirm for functionality opening in a web browser: <http://localhost>
