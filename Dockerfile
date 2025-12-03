# syntax=docker/dockerfile:labs
FROM python:3.14.1-alpine3.22 AS pip
ENV PYTHONUNBUFFERED=1
COPY requirements.txt /tmp/requirements.txt
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates build-base libffi-dev && \
    python3 -m venv /usr/local && \
    pip install --no-cache-dir -r /tmp/requirements.txt

FROM python:3.14.1-alpine3.22
ENV PYTHONUNBUFFERED=1
COPY --from=pip /usr/local /usr/local
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini curl jq && \
    mkdir -vp /etc/parsedmarc && \
    chown -R nobody:nobody /tmp /etc/parsedmarc
COPY start.sh /usr/local/bin/start.sh
COPY config.ini /tmp/config.ini
USER nobody
ENTRYPOINT ["tini", "--", "start.sh"]
