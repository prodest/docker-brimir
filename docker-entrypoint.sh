#!/bin/bash

set -e

sed -i "s/<%= ENV\[\"SECRET_KEY_BASE\"\] %>/`bin/rake secret`/g" /opt/brimir/config/secrets.yml

echo "
    production:
      adapter: postgresql
      host: $BRIMIR_HOST
      database: brimir
      user: brimir
      password: $BRIMIR_PASS
    " > /opt/brimir/config/database.yml

if [ "$1" = 'migrate' ]; then
    rake db:create
    rake db:schema:load

    if [ -n "$2" ]; then
        sed -i "s/:user/$2/g" /opt/brimir/loadUser.rb
        sed -i "s/:pass/$3/g" /opt/brimir/loadUser.rb
        rails console $RAILS_ENV < loadUser.rb
    fi
else
    rake db:migrate
fi

rake assets:precompile
rails server -b 0.0.0.0
