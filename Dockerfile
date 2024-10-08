# syntax=docker/dockerfile:labs
FROM python:3.13.0-alpine3.20
COPY --from=zoeyvid/curl-quic:419 /usr/local/bin/curl /usr/local/bin/curl
COPY requirements.txt /tmp/requirements.txt

RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini jq build-base libffi-dev && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    apk del --no-cache build-base libffi-dev && \
    mkdir -vp /etc/parsedmarc && \
    chown -R nobody:nobody /tmp /etc/parsedmarc

COPY start.sh /usr/local/bin/start.sh
COPY config.ini /tmp/config.ini

USER nobody
ENTRYPOINT ["tini", "--", "start.sh"]
