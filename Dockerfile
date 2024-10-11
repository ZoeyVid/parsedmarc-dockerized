# syntax=docker/dockerfile:labs
FROM python:3.13.0-alpine3.20 AS pip
ENV PYTHONUNBUFFERED=1
COPY requirements.txt /tmp/requirements.txt
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates build-base libffi-dev && \
    pip install --no-cache-dir -r /tmp/requirements.txt

FROM python:3.13.0-alpine3.20
ENV PYTHONUNBUFFERED=1
COPY --from=zoeyvid/curl-quic:419 /usr/local/bin/curl /usr/local/bin/curl
COPY --from=pip /usr/local /usr/local
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini jq && \
    mkdir -vp /etc/parsedmarc && \
    chown -R nobody:nobody /tmp /etc/parsedmarc
COPY start.sh /usr/local/bin/start.sh
COPY config.ini /tmp/config.ini
USER nobody
ENTRYPOINT ["tini", "--", "start.sh"]
