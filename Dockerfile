FROM zombaksteam/rust-base-server:latest
MAINTAINER zombaksteam <zombaksteam@gmail.com>

ENV SERVER_HOSTNAME=Rust \
	SERVER_HOST_IP=127.0.0.1 \
	SERVER_HOST_PORT=28015 \
	SERVER_RCON_IP=127.0.0.1 \
	SERVER_RCON_PORT=29015 \
	SERVER_RCON_PASS=SECRET \
	SERVER_WORLD_SIZE=4000 \
	SERVER_SEED=123456789 \
	SERVER_LEVEL= \
	SERVER_LEVEL_URL= \
	ADMIN_STEAMID= \
	ADMIN_NAME=

ARG DEBIAN_FRONTEND=noninteractive
ARG OXIDEMOD_URL=https://umod.org/games/rust/download/develop

RUN su - steam -c "mkdir /home/steam/rust/server" && \
	su - steam -c "mkdir /home/steam/rust/server/rust" && \
	su - steam -c "mkdir /home/steam/rust/server/rust/cfg" && \
	su - steam -c "mkdir /home/steam/rust/oxide" && \
	su - steam -c "mkdir /home/steam/rust/config" && \
	su - steam -c "mkdir /home/steam/rust/lang" && \
	su - steam -c "mkdir /home/steam/rust/plugins" && \
	su - steam -c "mkdir /home/steam/rust/data" && \
	su - steam -c "mkdir /home/steam/rust/logs" && \
	su - steam -c "wget -O /home/steam/rust/oxide.zip ${OXIDEMOD_URL}" && \
	su - steam -c "unzip -o /home/steam/rust/oxide.zip -d /home/steam/rust" && \
	su - steam -c "rm -r /home/steam/rust/oxide.zip"

COPY --chown=steam:steam ./docker/run.sh /home/steam/rust/run.sh

USER steam
CMD /home/steam/rust/run.sh
