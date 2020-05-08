FROM zombaksteam/rust-base-server:latest
MAINTAINER zombaksteam <zombaksteam@gmail.com>

# ENV SERVER_HOSTNAME=Rust \
# 	SERVER_HOST_IP=127.0.0.1 \
# 	SERVER_HOST_PORT=28015 \
# 	SERVER_RCON_IP=127.0.0.1 \
# 	SERVER_RCON_PORT=29015 \
# 	SERVER_RCON_PASS=SECRET \
# 	SERVER_WORLD_SIZE=4000 \
# 	SERVER_SEED=123456789 \
# 	SERVER_LEVEL= \
# 	SERVER_LEVEL_URL= \
# 	ADMIN_STEAMID= \
# 	ADMIN_NAME=

ARG DEBIAN_FRONTEND=noninteractive

# TODO: Add Oxide here...
# Create all folders for oxide

# RUN su - steam -c "mkdir /home/steam/rust" && \
# 	su - steam -c "/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/rust +app_update 258550 validate +quit"

COPY --chown=steam:steam ./docker/run.sh /home/steam/rust/run.sh

USER steam
CMD /home/steam/rust/run.sh
