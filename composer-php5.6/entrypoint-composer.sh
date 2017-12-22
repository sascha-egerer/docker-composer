#!/usr/bin/env bash

isCommand() {
  for cmd in \
    "about" \
    "archive" \
    "browse" \
    "clear-cache" \
    "clearcache" \
    "config" \
    "create-project" \
    "depends" \
    "diagnose" \
    "dump-autoload" \
    "dumpautoload" \
    "exec" \
    "global" \
    "help" \
    "home" \
    "info" \
    "init" \
    "install" \
    "licenses" \
    "list" \
    "outdated" \
    "prohibits" \
    "remove" \
    "require" \
    "run-script" \
    "search" \
    "self-update" \
    "selfupdate" \
    "show" \
    "status" \
    "suggests" \
    "update" \
    "validate" \
    "why" \
    "why-not"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

# Check if ssh keys or settings are mounted and move them to the user folder and fix permissions
find /overwrite-ssh/ -maxdepth 1 -type f -exec sh -c 'cp {} ~/.ssh/ && chmod 600 ~/.ssh/$(basename {})' \;

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- composer "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'composer' ]; then
  set -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- composer "$@"
fi

exec "$@"
