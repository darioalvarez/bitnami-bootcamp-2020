FROM bitnami/minideb:latest as downloader
RUN install_packages ca-certificates git

WORKDIR /tmp
RUN git clone https://github.com/gohugoio/hugo.git
RUN git clone https://github.com/alemorcuq/hugo-sample-site.git


###################
FROM bitnami/golang:1.13 AS builder_hugo
COPY --from=downloader /tmp/hugo /go/hugo
COPY --from=downloader /tmp/hugo-sample-site /tmp/hugo-sample-site

WORKDIR /go/hugo
RUN go build -o bin/hugo

WORKDIR /tmp/hugo-sample-site
RUN /go/hugo/bin/hugo -D


######################
FROM bitnami/nginx:latest
LABEL maintainer "Dario Alvarez Arteaga daa.developer@gmail.com"
LABEL version="1.0"
LABEL description="Image created as part of 'Deliverable 2' task \
in Bitnami Bootcamp 2020."

COPY --from=builder_hugo /tmp/hugo-sample-site/public /app
