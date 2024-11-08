#!/bin/sh

# If running the rails server then check the gems and create or migrate existing database
if [ "${1}" == "rails" ] && [ "${2}" == "server" ]; then
  bundle check || bundle install

  ./bin/rails db:prepare
fi

exec "${@}"
