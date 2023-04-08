FROM python:3.11.3-alpine3.17

RUN apk add --no-cache ca-certificates tzdata curl jq build-base libffi-dev && \
    pip install --no-cache-dir parsedmarc && \
    apk del --no-cache build-base libffi-dev

COPY start.sh /usr/local/bin/start.sh
COPY config.ini /tmp/config.ini

ENTRYPOINT ["start.sh"]
