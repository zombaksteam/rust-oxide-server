# rust-oxide-server

Rust Experimental Server Oxide Base

Docker image: [https://hub.docker.com/repository/docker/zombaksteam/rust-oxide-server](https://hub.docker.com/repository/docker/zombaksteam/rust-oxide-server)

## How to test image

```bash
docker run --rm \
 --network host \
 --name rust-oxide-server-test \
 -e SERVER_HOST_IP="127.0.0.1" \
 -e SERVER_HOST_PORT="28015" \
 -e SERVER_WORLD_SIZE="2000" \
 -e ADMINS_LIST="AdminNickName:12345678909876543" \
 -v /etc/timezone:/etc/timezone:ro \
 -it zombaksteam/rust-oxide-server:latest
```

## How to run server

```bash
mkdir /var/docker/rust
mkdir /var/docker/rust/logs
mkdir /var/docker/rust/oxide_config
mkdir /var/docker/rust/oxide_data
mkdir /var/docker/rust/oxide_lang
mkdir /var/docker/rust/oxide_plugins
mkdir /var/docker/rust/server
echo "{}" > /var/docker/rust/oxide.config.json
find /var/docker/rust/ -type d -exec chmod 0777 \{\} \;
chmod 0666 /var/docker/rust/oxide.config.json

docker run -d \
 --network host \
 --restart=always \
 --name rust-oxide-server \
 -e SERVER_HOSTNAME="Rust" \
 -e SERVER_HOST_IP="127.0.0.1" \
 -e SERVER_HOST_PORT="28015" \
 -e SERVER_RCON_IP="127.0.0.1" \
 -e SERVER_RCON_PORT="29015" \
 -e SERVER_RCON_PASS="SECRET" \
 -e SERVER_WORLD_SIZE="4000" \
 -e SERVER_SEED="123456789" \
 -e ADMINS_LIST="AdminNickName:12345678909876543" \
 -v /etc/timezone:/etc/timezone:ro \
 -v /var/docker/rust/logs/:/home/steam/rust/logs/ \
 -v /var/docker/rust/oxide_config/:/home/steam/rust/oxide/config/ \
 -v /var/docker/rust/oxide_data/:/home/steam/rust/oxide/data/ \
 -v /var/docker/rust/oxide_lang/:/home/steam/rust/oxide/lang/ \
 -v /var/docker/rust/oxide_plugins/:/home/steam/rust/oxide/plugins/ \
 -v /var/docker/rust/server/:/home/steam/rust/server/ \
 -v /var/docker/rust/oxide.config.json:/home/steam/rust/oxide/oxide.config.json \
 -it zombaksteam/rust-oxide-server:latest
```

## ENV config variables

```bash
SERVER_HOSTNAME   # Server name
SERVER_HOST_IP    # Public server ip
SERVER_HOST_PORT  # Public server port
SERVER_RCON_IP    # Public rcon ip
SERVER_RCON_PORT  # Public rcon port
SERVER_RCON_PASS  # Rcon password
SERVER_WORLD_SIZE # Server world size
SERVER_SEED       # Server seed number
SERVER_LEVEL      # Empty or "Barren"
SERVER_LEVEL_URL  # Custom map from URL
ADMINS_LIST       # Comma separated Name:SteamID list
```
