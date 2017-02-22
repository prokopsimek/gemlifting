#!/bin/bash

echo "Restoring database from Heroku server..."
echo " "
echo "Please choose Heroku app:"
read heroku_env
echo "You entered: $heroku_env"

echo ""
bckp_url=$(heroku pg:backups public-url --app $heroku_env)
echo "$bckp_url"
curl -o latest.dump "$bckp_url"
rake db:drop db:create
pg_restore latest.dump -cOxv -d gemlifting_development
rm -rf latest.dump
rake db:migrate

echo ""
echo "Database restored!"
