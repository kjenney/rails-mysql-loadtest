#!/usr/bin/env bash

# It's going to take a little bit to start up the MySQL node. This is to
# prevent the logs from getting to noisy
sleep 10

until nc -zvw3 $MYSQL_HOSTNAME 3306 > /dev/null 2>&1; do
  echo "MySQL server $MYSQL_HOSTNAME is not listening on port 3306, retrying"
  sleep 1
done

echo ""
echo "MySQL server $MYSQL_HOSTNAME is up on port 3306"

until mysql -h $MYSQL_HOSTNAME -u root -p$MYSQL_ROOT_PASSWORD  -e "show databases;" > /dev/null 2>&1; do
  echo "Can't connect to MySQL, retrying"
  sleep 1
done

echo ""
echo "MySQL is now available and we're able to connect!"

echo "Creating the database"
rails db:create
echo "Migrating the database"
rails db:migrate
echo "Seeding the database"
rails db:seed
echo -e "\tDone seeding the database"

echo "Starting Unicorn"
#rails server -b 0.0.0.0
bundle exec unicorn -c unicorn.rb

exec "$@"
