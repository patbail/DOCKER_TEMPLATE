#!/bin/sh
set -eu

: "${APACHE_DOCUMENT_ROOT:=/var/www/html}"
: "${ALLOW_OVERRIDE:=None}"

if ! command -v envsubst >/dev/null 2>&1; then
  apt-get update && apt-get install -y --no-install-recommends gettext-base && rm -rf /var/lib/apt/lists/*
fi

envsubst '${APACHE_DOCUMENT_ROOT} ${ALLOW_OVERRIDE}' \
  < /etc/apache2/sites-available/000-default.conf.template \
  > /etc/apache2/sites-available/000-default.conf

exec "$@"
