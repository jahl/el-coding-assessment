#!/bin/bash -e

# If running the rails server then create or migrate existing database
if [ "${1}" == "./bin/src" ] && [ "${2}" == "server" ]; then
  ./bin/rails db:prepare
fi

exec "${@}"
