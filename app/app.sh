#!/bin/bash

case "${1:-}" in
     help)
    echo "Usage: ./app.sh <command> [arguments]"
    echo
    echo "Available commands:"
    echo "  system-info              Display system information"
    echo "  check-host <host>        Resolve a hostname"
    echo "  check-port <host> <port> Check TCP connectivity"
    echo "  help                     Display this help message"
     ;;

     system-info)
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
     ;;

     check-host)
     host="$2"
     if [[ -z "$host" ]]; then
        echo "Error: Hostname is required"
        echo "Usage: ./app.sh check-host <host>"
     exit 2
     fi
     if getent ahosts "$host" > /dev/null; then
            echo "SUCCESS: Host '$host' resolved successfully"
            exit 0
        else
            echo "FAILED: Unable to resolve '$host'" >&2
            exit 1
     fi
     ;;

        check-port)
        host="${2:-}"
        port="${3:-}"

        if [[ -z "$host" || -z "$port" ]]; then
            echo "Error: hostname and port are required" >&2
            exit 2
        fi

        if ! [[ "$port" =~ ^[0-9]+$ ]]; then
            echo "Error: port must be numeric" >&2
            exit 2
        fi

        if (( 10#$port < 1 || 10#$port > 65535 )); then
            echo "Error: port must be between 1 and 65535" >&2
            exit 2
        fi

        if nc -z -w 5 "$host" "$port" >/dev/null 2>&1; then
            echo "SUCCESS: TCP connection to $host:$port succeeded"
            exit 0
        else
            echo "FAILED: Cannot connect to $host:$port" >&2
            exit 1
        fi
        ;;
     *)
     echo "invalid command"
     echo "Usage: ./app.sh <command> [arguments]"
    echo
    echo "Available commands:"
    echo "  system-info              Display system information"
    echo "  check-host <host>        Resolve a hostname"
    echo "  check-port <host> <port> Check TCP connectivity"
    echo "  help                     Display this help message"
    exit 2
     ;;
esac     