# syntax=docker/dockerfile:labs@sha256:7d49dad25a050e14338ba7028b0460243f9d911dedc160a8fe20c34738fef3af
FROM python:3.14.5-alpine3.23@sha256:5a824eb82cc75361f98611f3cfc5091ea33f10a6ccea4d4ebdabbc523b9a1614 AS pip
ENV PYTHONUNBUFFERED=1
COPY requirements.txt /tmp/requirements.txt
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates build-base libffi-dev && \
    python3 -m venv /usr/local && \
    pip install --no-cache-dir -r /tmp/requirements.txt

FROM python:3.14.5-alpine3.23@sha256:5a824eb82cc75361f98611f3cfc5091ea33f10a6ccea4d4ebdabbc523b9a1614
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
