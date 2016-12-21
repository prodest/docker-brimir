#!/bin/bash
# This script is used by the Dockerfile, when setting up a container. It can
# also be used to easily setup your PostgreSQL database.
#
# Call this script as root, with one argument: the path to your Brimir root.
# create database config file
echo "
production:
  adapter: postgresql
  host: $BRIMIR_HOST
  database: brimir
  user: brimir
  password: $BRIMIR_PASS
" >> /opt/brimir/config/database.yml
