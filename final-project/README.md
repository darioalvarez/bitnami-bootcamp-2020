# CKAN

CKAN (Comprehensive Knowledge Archive Network) is a web platform, 'like a CMS, but for data'.

It has several dependencies. In this case it is used a PostgreSQL database server, a Redis as in-memory data structure store and Solr as a search engine.

This project creates a docker image for CKAN (version 2.8.2), a docker-compose.yml to deploy the complete environment and a Helm chart to be used with Kubernetes.

## Dockerfile

Dockerfile makes use of an initial stage to download CKAN repository from Github and then a second one where there is deployed the service.

To build image run:

```console
$ docker build -t <image-name>:<image-version> .

$ docker build -t darioalvarez/ckan:latest .
```

## docker-compose.yml

docker-compose.yml orchestrates all ckan dependencies to get a fully functional environment. To run all containers execute:

```console
$ docker-compose up -d

$ docker build -t darioalvarez/ckan:latest .
```

Optional parameter -d runs containers in background (detached). If not provided, container logs will be exported in standard output and shell will be blocked.
And to stop it:

```console
$ docker-compose down -v

```

Optional parameter -v removes also all volumes created.

## Chart

Chart allows to run the CKAN environment in Kubernetes. To install the deployment run following command:

```console
$ helm install <chart-name> [--set key=value[,key=value]] <chart folder location>
$ helm install ckan --set postgresql.postgresPassword=password123 .

$ helm install <chart-name> [-f <values.yaml location>] <chart folder location>
$ helm install ckan -f values.yaml .
```

By default, the site is deployed in http://ckan.local.net, although this value is parametrized. To get the credentials for the default sysadmin of CKAN (these credentials are also parametrized), follow instructions on 'helm install' output.

To check deployed pods and services:

```console
$ kubectl get pods
$ kubectl get services
```


To uninstall/delete the deployment:

```console
$ helm delete <chart-name>
$ helm delete ckan
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
