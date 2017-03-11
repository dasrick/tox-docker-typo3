#!/usr/bin/env bash

if [ -z ${LOCAL_USER_ID+x} ]; then
    echo "Starting as root"
    exec "$@"
else
  echo "Starting with UID : ${LOCAL_USER_ID}"
  usermod -u ${LOCAL_USER_ID} www-data
  if [ $1 != "php-fpm" ]; then
    exec gosu www-data "$@"
  else
    exec "$@"
  fi
fi
