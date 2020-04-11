#!/bin/bash

if [ ! -f composer.json ]; then
    echo "Please make sure to run this script from the root directory of this repo."
    exit 1
fi

#composer install
docker run --rm -v $PWD:/app composer install
cp .env.example .env
#php artisan key:generate
docker run --rm -v $PWD:/app laraws/php php artisan key:generate
source "$(dirname "$0")/checkout_latest_docs.sh"
#npm install
docker run --rm -v $PWD:/app node -w /app npm install
#npm run dev
docker run --rm -v $PWD:/app node npm -w/app run dev
