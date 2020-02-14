# Deliverable 3: Hugo/NGINX Bash container

## Requirements

### Modify the “runtime” stage of ex. 2 so you create your own ‘bash” NGINX image (instead of using Bitnami one) based on ‘bitnami/minideb’.

### Use the “bitnami” approach using the scripts:

* postunpack.sh
* entrypoint.sh
* setup.sh
* run.sh

### Include (at least) the following customizations:

* Change the port to serve the website based on environment variable
* Redirect logs to stdout/stderr or log file (default behaviour)
* Add a “docker-compose.yml” to orchestrate volumes

## Solution proposed

It was replaced runtime image nginx and used instead bitnami/minideb. In this case, as minideb is an almost empty distribution of debian, it was needed to perform manually all steps involving web server installation and configuration. Also it was defined www-data as executing user. To allow this it was needed to perform a (painful) set of manual steps to guarrante that www-data would be able to execute nginx server by its own. These steps was included in some predefined scripts as suggested to perform these steps:

* postunpack.sh: Apply all root steps: Added ownership to www-data user to nginx configuration, logs, libs, startup script. Also allowed www-data user to login, since by default it is a no-login user.

* entrypoint.sh: Is the image entrypoint command and simply checks if its parameter is run.sh. If true, apply a setup needed to run nginx server. If not, simply execute the command selected.

* setup.sh: Perform a set of configurations needed to run nginx server: Setting port of the server. Notice it must not be a well-known port (0 <= port < 1024) since the user www-data has not administrative righs, so it is not allowed to run services in those ports. Setup changes also the nginx.pid location, since it has not righs to access the original location in /run directory.

* run.sh: Simply runs nginx as a foreground service, to avoid container to close (not sure if it is a good approach, but **it works!**)

All these scripts were added as executable files (to allow them to be executed).

The port where nginx will runs was declared as an enviromnent variable in Dockerfile as requested.

There was not (still) possible to get correctly working this requirement: 'Redirect logs to stdout/stderr or log file (default behaviour)'.

It was created a docker-compose.yml file for orchestrate a container with a volume.

To build the image with Dockerfile:

```
docker build -t <desired-image-name> .      # format
docker build -t darioalvarez/hugo-site .    # real example
```

To create and run a container:

```
docker run -p <public-port>:<exposed-port> --name <container-name>  -d  -e NGINX_PORT=<exposed-port> <desired-image-name>      # format
docker run -p 8090:8090 --name dario  -d  -e NGINX_PORT=8090 darioalvarez/hugo-site   # real example
```

If (hopefully) everything worked as expected, the sample go website can be shown in the URL: http://localhost:<public-port> (http://localhost:8090)

To create and run the container with a volume, use instead docker-compose.yml file. Notice that this step must be done after build the image:

```
docker-compose up -d
```

And to stop and remove container and volume created:

```
docker-compose down -v
```
