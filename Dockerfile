# syntax=docker/dockerfile:labs
FROM python:3.12.6-alpine3.20
COPY --from=zoeyvid/curl-quic:414 /usr/local/bin/curl /usr/local/bin/curl

RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini jq build-base libffi-dev && \
    pip install --no-cache-dir parsedmarc && \
    apk del --no-cache build-base libffi-dev && \
    mkdir -vp /etc/parsedmarc && \
    chown -R nobody:nobody /tmp /etc/parsedmarc

COPY start.sh /usr/local/bin/start.sh
COPY config.ini /tmp/config.ini

USER nobody
ENTRYPOINT ["tini", "--", "start.sh"]
