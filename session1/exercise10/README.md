# Exercise 10: Access different containers using domain name

## Two running installations: WordPress and Joomla in different networks and using a single mariadb instance. Accesibles both in host server using domain names.

1. Created domain names in host /etc/hosts files, so it will be possible to access both servers through URLs <http://myfirstwp.net> and <http://myjoomla.net>

2. Created a container for wordpress and joomla, each of then in a single and different network and different volumes. Created container of mariadb in both network (wordpress's and joomla's) and with its own volume. Created also a nginx-proxy container that will, somehow, process both volumes, wordpress and joomla's, so it will be able to identify both contents. 

3. Assigned to each web server (wordpress and joomla) an environment variable VIRTUAL_HOST that will be used by nginx-proxy to identify them (somehow similar to the nginx virtualhost mechanism).

4. Exported port 80 of nginx proxy to host server.

Run following command to deploy containers:

```
docker-compose up -d
```

Check logs to confirm all containers are fully deployed using:

```
docker-compose logs -f
```

Finally, open in a browser both URLs <http://myfirstwp.net> and <http://myjoomla.net> where there will be a wordpress site and a joomla site, respectively. Credentials for both sites admin dashboard are created in docker-compose.yml file.
