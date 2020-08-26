#!/bin/bash

# Move to server root
cd /home/steam/rust

# Make dir for binding
mkdir /home/steam/rust/server
mkdir /home/steam/rust/server/rust
mkdir /home/steam/rust/server/rust/cfg

# Need for rust server
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`dirname $0`/RustDedicated_Data/Plugins/x86_64

# Add admins to file
if [[ ${ADMINS_LIST} != "" ]]; then
	UFILE="/home/steam/rust/server/rust/cfg/users.cfg"
	echo "// admins list" > ${UFILE}
	IFS=','; for i in ${ADMINS_LIST}
	do
		ADMIN_NAME=`echo "${i}" | sed -E 's/:.*?$//g'`
		ADMIN_STEAMID=`echo "${i}" | sed -E 's/^.*?://g'`
		echo "ownerid ${ADMIN_STEAMID} \"${ADMIN_NAME}\" \"no reason\"" >> ${UFILE}
	done
	echo "" >> ${UFILE}
fi

# Server run command
RUN_CMD="-batchmode -nographics"
if [[ ${SERVER_LEVEL} != "" ]]; then
	RUN_CMD="${RUN_CMD} +server.level \"${SERVER_LEVEL}\""
fi
if [[ ${SERVER_LEVEL_URL} != "" ]]; then
	RUN_CMD="${RUN_CMD} +server.levelurl \"${SERVER_LEVEL_URL}\""
fi
RUN_CMD="${RUN_CMD} +server.identity \"rust\""
RUN_CMD="${RUN_CMD} +server.hostname \"${SERVER_HOSTNAME}\""
RUN_CMD="${RUN_CMD} +server.ip ${SERVER_HOST_IP}"
RUN_CMD="${RUN_CMD} +server.port ${SERVER_HOST_PORT}"
RUN_CMD="${RUN_CMD} +rcon.ip ${SERVER_RCON_IP}"
RUN_CMD="${RUN_CMD} +rcon.port ${SERVER_RCON_PORT}"
RUN_CMD="${RUN_CMD} +rcon.password \"${SERVER_RCON_PASS}\""
RUN_CMD="${RUN_CMD} +server.worldsize ${SERVER_WORLD_SIZE}"
RUN_CMD="${RUN_CMD} +server.seed ${SERVER_SEED}"
RUN_CMD="${RUN_CMD} +rcon.web 1"

# Ensure what gamelog.txt exists
if [ ! -f "$LOGFILE" ]; then
	touch /home/steam/rust/gamelog.txt
fi

# Catch Ctrl+C
NSTOP="0"
stop_server() {
	NSTOP="1"
	echo "Stopping server..."
}
trap 'stop_server' SIGINT

while :
do
	# Save and clear logs file
	if [ -f "/home/steam/rust/gamelog.txt" ]; then
		LFNAME="${SERVER_HOST_IP}-${SERVER_HOST_PORT}-$(date '+%FT%T').txt"
		LFNAME=`echo "$LFNAME" | sed "s/-/_/g"`
		LFNAME=`echo "$LFNAME" | sed "s/:/_/g"`
		cat /home/steam/rust/gamelog.txt > /home/steam/rust/logs/$LFNAME
		echo "" > /home/steam/rust/gamelog.txt
	fi

	# Start server
	./RustDedicated ${RUN_CMD} 2>&1 | tee /home/steam/rust/gamelog.txt

	# Break loop
	if [ "${NSTOP}" == "1" ]; then
		break
	fi
done

echo "Server is stopped!"
