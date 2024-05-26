# parsedmarc-dockerized

This docker image contains https://github.com/domainaware/parsedmarc, which should be used with the compose file, which also contains elasticsearch, kibana and maxmindinc/geoipupdate.

## How to use:
1. Download the compose.yaml and edit it:
```console
wget https://raw.githubusercontent.com/ZoeyVid/parsedmarc-dockerized/develop/compose.yml
nano compose.yaml
```
2. now adjust the value `GEOIPUPDATE_ACCOUNT_ID` and `GEOIPUPDATE_LICENSE_KEY` from your [MaxMind account](https://maxmind.com) and edit `server.publicBaseUrl`
3. Now deploy the stack
```console
docker compose up -d
```
4. now you can edit the config.ini
```console
nano /opt/parsedmarc/conf/config.ini
```
5. now restart your container:
```console
docker restart parsedmarc
```
6. configure your reverse proxy to `http://127.0.0.1:5601`
