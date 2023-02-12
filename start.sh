#!/bin/sh

curl -sL https://raw.githubusercontent.com/domainaware/parsedmarc/master/kibana/export.ndjson -o /tmp/export.ndjson
while ! curl -sf http://kibana:5601 > /dev/null 2>&1; do
    sleep 5
done
curl -X POST http://kibana:5601/api/saved_objects/_import?overwrite=true -H "kbn-xsrf: true" --form file=@/tmp/export.ndjson
curl -X POST http://kibana:5601/api/kibana/settings/defaultRoute -H "kbn-xsrf: true" -H "Content-Type: application/json" -d "{\"value\": \""$(cat /tmp/export.ndjson | jq --arg DBNAME "DMARC Summary" 'select(.attributes.title == $DBNAME) | .id' | tr -d '"')"\"}"

if [ ! -f /etc/parsedmarc/config.ini ]; then
    cp -vp /tmp/config.ini /etc/parsedmarc/config.ini
fi

parsedmarc -c /etc/parsedmarc/config.ini