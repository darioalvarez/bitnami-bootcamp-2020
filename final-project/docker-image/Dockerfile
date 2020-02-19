FROM bitnami/minideb:latest as downloader
RUN install_packages ca-certificates git vim
WORKDIR /tmp
RUN git clone https://github.com/ckan/ckan.git

FROM bitnami/python:2
COPY --from=downloader /tmp/ckan /app/ckan
RUN install_packages libmagic-dev postgresql-client
RUN useradd -r -u 1001 -g root nonroot

ENV CKAN_HOST="" \
    CKAN_PORT="5001" \
    CKAN_INITIALIZE_DB="yes" \
    CKAN_SITE_ID="default" \
    CKAN_PLUGINS="datastore" \
    CKAN_STORAGE_PATH="/var/lib/ckan" \
    CKAN_CONF_PATH="/etc/ckan" \
    CKAN_ADMIN="ckan" \
    CKAN_ADMIN_EMAIL="ckan@ckan.com" \
    CKAN_ADMIN_PASSWORD="12345678" \
    POSTGRESQL_HOST=postgresql \
    POSTGRESQL_PORT="5432" \
    POSTGRESQL_PASSWORD="password123" \
    POSTGRESQL_DATABASE_USER="db_user" \
    POSTGRESQL_DATABASE_USER_PASSWORD="password123" \
    POSTGRESQL_DATASTORE_USER_READ="ds_user_reader" \
    POSTGRESQL_DATASTORE_USER_READ_PASSWORD="password123" \
    POSTGRESQL_DATASTORE_USER_WRITE="ds_user_writer" \
    POSTGRESQL_DATASTORE_USER_WRITE_PASSWORD="password123" \
    POSTGRESQL_CKAN_DATABASE="ckan_db" \
    POSTGRESQL_CKAN_DATASTORE="ckan_ds" \
    SOLR_HOST="solr" \
    SOLR_PORT="8983" \
    SOLR_CORE_NAME="ckan-core" \
    REDIS_HOST="redis" \
    REDIS_PORT="6379" \
    REDIS_USER="redis_user" \
    REDIS_PASSWORD="password123"

ENV CKAN_INNER_PORT=${CKAN_PORT}

EXPOSE ${CKAN_INNER_PORT}

COPY rootfs /
RUN /postunpack.sh
VOLUME ["${CKAN_STORAGE_PATH}", "${CKAN_CONF_PATH}", "/usr/lib/ckan/"]

USER 1001

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]
