FROM python:2.7-alpine
ENV PYTHONUNBUFFERED=1 user=vp vpbasedir=/opt/vpcode/

WORKDIR ${vpbasedir}

RUN addgroup -g 1000 ${user} && \
    adduser -G vp -u 1000 -D -h ${vpbasedir} ${user} && \
    chown ${user}:${user} ${vpbasedir}

ADD requirements/*.txt ${vpbasedir}

RUN apk update && apk add musl-dev mariadb mariadb-libs mariadb-dev gcc && \
    pip install -r dev_mysql.txt && \
    apk del --purge gcc mariadb-dev mariadb musl-dev && \
    /bin/rm -rf /var/cache/apk/*

#RUN apk update && apk add musl-dev postgresql postgresql-dev gcc && \
#    pip install -r dev_postgres.txt && \
#    apk del --purge gcc musl-dev && \
#    /bin/tmp -rf /var/cache/apk/*

USER ${user}
CMD ["/bin/sh"]
