#!/usr/bin/env bashio
WAIT_PIDS=()
CONFIG_PATH='/share/frp/frpc.toml'

function stop_frpc() {
    bashio::log.info "Shutdown frpc client"
    kill -15 "${WAIT_PIDS[@]}"
}

if [ ! -f $CONFIG_PATH ]; then
    bashio::log.error "No frpc.toml file"
fi

bashio::log.info "Starting frp client"

cat $CONFIG_PATH

cd /usr/src
./frpc -c $CONFIG_PATH & WAIT_PIDS+=($!)

trap "stop_frpc" SIGTERM SIGHUP
wait "${WAIT_PIDS[@]}"
