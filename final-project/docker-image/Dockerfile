FROM bitnami/python:2

ENV CKAN_HOST="http://127.0.0.1" \
    CKAN_PORT="5000" \
    CKAN_INITIALIZE_DB="no" \
    CKAN_SITE_ID="default" \
    CKAN_PLUGINS="datastore" \
    CKAN_STORAGE_PATH="/var/lib/ckan" \
    CKAN_CONF_PATH="/etc/ckan" \
    CKAN_ADMIN="ckan" \
    CKAN_ADMIN_EMAIL="ckan@ckan.com" \
    CKAN_ADMIN_PASSWORD="12345678" \
    POSTGRESQL_HOST=postgresql \
    POSTGRESQL_PORT="5432" \
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

COPY rootfs /

RUN chmod +x /postunpack.sh
RUN chmod +x /run.sh
RUN chmod +x /setup.sh
RUN chmod +x /entrypoint.sh

RUN useradd -r -u 1001 -g root nonroot

RUN /postunpack.sh

RUN install_packages libmagic-dev postgresql-client vim



WORKDIR /usr/lib/ckan/default/src/ckan



EXPOSE ${CKAN_PORT}

# USER www-data
# USER 1001

# RUN useradd -r -u 900 -m -c "ckan account" -d $CKAN_HOME -s /bin/false ckan

# USER 1001


VOLUME ["${CKAN_STORAGE_PATH}", "${CKAN_CONF_PATH}", "/usr/lib/ckan/"]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]
