#!/bin/bash
#
# Library for uptime robot api
# https://uptimerobot.com/api

# UPTIME_API_KEY=<your-uptime-api-key>

uptime::curl(){
    local http_method=$1; shift;
    local uptime_method=$1; shift;
    local body=$*

    if [[ -z UPTIME_API_KEY ]]; then
      echo "UPTIME_API_KEY is required but not found."
      exit 1
    fi

    curl -X ${http_method} \
      -H "Cache-Control: no-cache" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -d ${body} "https://api.uptimerobot.com/v2/${uptime_method}"
}

uptime::get_account_details(){
    uptime::curl POST getAccountDetails "api_key=${UPTIME_API_KEY}&format=json"
}

uptime::get_monitors(){
    uptime::curl POST getMonitors "api_key=${UPTIME_API_KEY}&format=json"
}

uptime::get_monitors::aurora_dev(){
    uptime::curl POST getMonitors "api_key=${UPTIME_API_KEY}&search=aurora-dev&format=json"
}

uptime::get_monitors::aurora_staging(){
    uptime::curl POST getMonitors "api_key=${UPTIME_API_KEY}&search=aurora-staging&format=json"
}

uptime::stop_aurora_dev(){
    monitor_id=$(uptime::get_monitors::aurora_dev | jq .monitors[0].id)
    key_values="status=0"
    uptime::curl POST editMonitor "api_key=${UPTIME_API_KEY}&id=${monitor_id}&${key_values}&format=json"
}

uptime::start_aurora_dev(){
    monitor_id=$(uptime::get_monitors::aurora_dev | jq .monitors[0].id)
    key_values="status=1"
    uptime::curl POST editMonitor "api_key=${UPTIME_API_KEY}&id=${monitor_id}&${key_values}&format=json"
}

uptime::stop_aurora_staging(){
    monitor_id=$(uptime::get_monitors::aurora_staging | jq .monitors[0].id)
    key_values="status=0"
    uptime::curl POST editMonitor "api_key=${UPTIME_API_KEY}&id=${monitor_id}&${key_values}&format=json"
}

uptime::start_aurora_staging(){
    monitor_id=$(uptime::get_monitors::aurora_staging | jq .monitors[0].id)
    key_values="status=1"
    uptime::curl POST editMonitor "api_key=${UPTIME_API_KEY}&id=${monitor_id}&${key_values}&format=json"
}
