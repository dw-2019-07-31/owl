#!/bin/sh
PROJECT_HOME=/home/rails/owl_rails
PUMA_PID=`cat $PROJECT_HOME/tmp/pids/puma.pid`

cd $PROJECT_HOME

/home/rails/owl_rails/script/stop_puma.sh

echo "Update Contents..."
git pull

echo "Update Gems..."
bundle install

echo "Migrate Database..."
rails db:migrate

echo "Compile Static Files..."
rails assets:precompile

/home/rails/owl_rails/script/start_puma.sh