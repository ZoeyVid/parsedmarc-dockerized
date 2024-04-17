# parsedmarc-dockerized

## Setup:
1. Download the compose.yaml and edit it:
```
wget https://raw.githubusercontent.com/ZoeyVid/parsedmarc-dockerized/develop/compose.yml
nano compose.yaml
```

2. now adjust the value `GEOIPUPDATE_ACCOUNT_ID` and `GEOIPUPDATE_LICENSE_KEY` from your [MaxMind account](https://maxmind.com)

3. Now depoly the stack
```
docker compose up -d
```

4. now you can edit the config.ini
```
nano /opt/parsedmarc/conf/config.ini
```

5. now restart your container:
```
docker restart parsedmarc
```

6. configure your reverse proxy to `http://127.0.0.1:5601`
