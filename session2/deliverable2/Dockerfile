FROM bitnami/golang:1.13 as builder_hugo

WORKDIR /tmp
RUN git clone https://github.com/gohugoio/hugo.git
WORKDIR /tmp/hugo
RUN go build -o hugo main.go
RUN mv hugo /tmp/hugo.binary

######################
FROM bitnami/minideb:latest as builder_site
COPY --from=builder_hugo /tmp/hugo.binary /tmp/hugo

RUN install_packages ca-certificates git

WORKDIR /tmp
RUN git clone https://github.com/alemorcuq/hugo-sample-site
WORKDIR /tmp/hugo-sample-site
RUN ../hugo -D
RUN mv public ../site

######################
FROM bitnami/nginx:latest
LABEL maintainer "Dario Alvarez Arteaga daa.developer@gmail.com"
LABEL version="1.0"
LABEL description="Image created as part of 'Deliverable 2' task \
in Bitnami Bootcamp 2020."
COPY --from=builder_site /tmp/site /app
EXPOSE 8080
