#!/bin/sh

set -u

shutdown() {
  if [ -n "${server_pid:-}" ]; then
    kill -TERM "$server_pid" 2>/dev/null || true
    wait "$server_pid" 2>/dev/null || true
  fi
  exit 0
}

trap shutdown INT TERM

while true; do
  sqlite_wsgi --host 0.0.0.0 --port 8081 "$@" &
  server_pid=$!
  failures=0

  while kill -0 "$server_pid" 2>/dev/null; do
    if wget --spider --quiet --timeout=5 http://127.0.0.1:8081/; then
      failures=0
    else
      failures=$((failures + 1))
      if [ "$failures" -ge 2 ]; then
        kill -KILL "$server_pid" 2>/dev/null || true
        break
      fi
    fi
    sleep 5
  done

  wait "$server_pid" 2>/dev/null || true
  unset server_pid
  sleep 1
done