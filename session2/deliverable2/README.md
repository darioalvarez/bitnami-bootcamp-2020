# Deliverable 2: Multi-stage build

## Requirements

### Create a Dockerfile with at least the following stages:

* A download/clone source code stage
* A build/compile stage
* A runtime stage

### The resulting Dockerfile should build Hugo from source, generate a static site and serve it using Bitnami Nginx image

### Tips

* ‘bitnami/minideb’ is a good starting point
* You can use `go build –o path/to/hugo/bin` to specify where to create the output binary
* You can get a Hugo sample site here if you don’t want to create a new one

## Solution proposed

1. Created initial stage using bitnami/golang:1.13. In this container occurs the dowloading of hugo sources and compilation using go. Binary generated is exposed in location:

```
/tmp/hugo.binary
```

2. A second container generated from bitnami/minideb:latest image is used to download a hugo website source code from https://github.com/alemorcuq/hugo-sample-site and compilated using hugo binaries generated in previous container. Notice this mini debian distribution needs to dowload git and ca-certificates packages in order to download hugo-sample-site repository. The result static website is exposed in location:

```
/tmp/site
```

3. A final bitnami/nginx container is created to publish the resulting website. It needs to copy static files from previous container and save them in public nginx directory.

### Running solution

In order to create the image in current directory it is needed to run following command:

```
docker build -t <image-name> .
```

Once created (it may take a while downloading and compiling several times) it can be created a container using following command:

```
docker run --name mywebsite -p 8080:8080 -d <image-name>
```

Notice that this image exports the web server in port 8080, and previous command binds it to that same port in host server. If (hopefully) everything have worked correctly, the static website can be visited in the URL: <http://localhost:8080/>
