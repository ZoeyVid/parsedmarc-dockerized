FROM python:3.12.1-alpine3.19

RUN apk add --no-cache ca-certificates tzdata tini curl jq build-base libffi-dev && \
    pip install --no-cache-dir parsedmarc && \
    pip install --no-cache-dir "msgraph-core<1.0.0" --force-reinstall && \
    apk del --no-cache build-base libffi-dev

COPY start.sh /usr/local/bin/start.sh
COPY config.ini /tmp/config.ini

ENTRYPOINT ["tini", "--", "start.sh"]
