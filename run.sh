#!/usr/bin/env bashio
CONFIG_PATH='/share/frp/frpc.ini'
WAIT_PIDS={}

function stop_frpc() {
    bashio::log.info "Shutdown frpc client"
    kill -15 "${WAIT_PIDS[@]}"
    wait "${WAIT_PIDS[@]}"
}

if [ ! -f $CONFIG_PATH ]; then
    bashio::log.error "No frpc.ini file"
fi

bashio::log.info "Starting frp client"

cat $CONFIG_PATH

cd /usr/src
./frpc -c $CONFIG_PATH & WAIT_PIDS+=($!)

trap "stop_frpc" SIGTERM SIGHUP
wait "$(WAIT_PIDS[@]}"
