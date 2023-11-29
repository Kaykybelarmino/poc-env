    FROM mysql:8.0
    ENV MYSQL_ROOT_PASSWORD=segredo
    ENV MYSQL_DATABASE=medconnect

    COPY script.sql /docker-entrypoint-initdb.d/