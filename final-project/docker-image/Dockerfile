# FROM bitnami/minideb:latest as downloader
# RUN install_packages ca-certificates git

# WORKDIR /tmp
# RUN git clone https://github.com/gohugoio/hugo.git
# RUN git clone https://github.com/alemorcuq/hugo-sample-site.git


###################
# FROM bitnami/golang:1.13 AS builder_hugo
# COPY --from=downloader /tmp/hugo /go/hugo
# COPY --from=downloader /tmp/hugo-sample-site /tmp/hugo-sample-site

# WORKDIR /go/hugo
# RUN go build -o bin/hugo

# WORKDIR /tmp/hugo-sample-site
# RUN /go/hugo/bin/hugo -D


######################
FROM bitnami/python:2
# COPY --from=builder_hugo /tmp/hugo-sample-site/public /var/www/html

# RUN install_packages nginx

COPY rootfs /

ENV CKAN_PORT=5000

RUN chmod +x /postunpack.sh
RUN chmod +x /run.sh
RUN chmod +x /setup.sh
RUN chmod +x /entrypoint.sh

RUN /postunpack.sh

WORKDIR /usr/lib/ckan/default/src/ckan

EXPOSE ${CKAN_PORT}

# USER www-data
# USER 1001

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]
