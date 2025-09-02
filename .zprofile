#!/usr/bin/env bash

echo "Starting Zsh shell..." 1>/dev/null
if uwsm check may-start 1>/dev/null && uwsm select; then
	exec uwsm start default
fi

