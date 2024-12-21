#! /usr/bin/env bash

source .env

# run rails server app
docker run -d -p 3000:3000 \
    --add-host=host.docker.internal:host-gateway \
    -e RAILS_ENV=$RAILS_ENV \
    -e DATABASE_URL=$DATABASE_URL \
    -e REDIS_URL=$REDIS_URL \
    -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
    --name $APP_NAME $IMAGE_NAME

# run sidekiq worker(s)
docker run -d \
    --add-host=host.docker.internal:host-gateway \
    -e RAILS_ENV=$RAILS_ENV \
    -e REDIS_URL=$REDIS_URL \
    -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
    --name $APP_NAME-worker $IMAGE_NAME sidekiq
