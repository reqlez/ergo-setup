#!/bin/sh
set -e

EXPLORER_VERSION="9.17.3-M1"


echo "Fetching explorer $EXPLORER_VERSION source"
curl -L 'https://github.com/ergoplatform/explorer-backend/archive/refs/tags/$EXPLORER_VERSION.tar.gz' > 'explorer-backend-$EXPLORER_VERSION.tar.gz'

echo "Extracting explorer source"
rm -rf 'explorer-backend/$EXPLORER_VERSION'
tar -xf 'explorer-backend-$EXPLORER_VERSION.tar.gz'
rm 'explorer-backend-$EXPLORER_VERSION.tar.gz'

echo "Preparing Dockerfiles"
#cp explorer-backend-$EXPLORER_VERSION/modules/chain-grabber/Dockerfile explorer-backend-$EXPLORER_VERSION/chain-grabber.Dockerfile
#cp explorer-backend-$EXPLORER_VERSION/modules/explorer-api/Dockerfile explorer-backend-$EXPLORER_VERSION/explorer-api.Dockerfile
#cp explorer-backend-$EXPLORER_VERSION/modules/utx-broadcaster/Dockerfile explorer-backend-$EXPLORER_VERSION/utx-broadcaster.Dockerfile
#cp explorer-backend-$EXPLORER_VERSION/modules/utx-tracker/Dockerfile explorer-backend-$EXPLORER_VERSION/utx-tracker.Dockerfile
cp 'ex/chain-grabber.Dockerfile' 'explorer-backend-$EXPLORER_VERSION/chain-grabber.Dockerfile'
cp 'ex/explorer-api.Dockerfile' 'explorer-backend-$EXPLORER_VERSION/explorer-api.Dockerfile'
cp 'ex/utx-broadcaster.Dockerfile' 'explorer-backend-$EXPLORER_VERSION/utx-broadcaster.Dockerfile'
cp 'ex/utx-tracker.Dockerfile' 'explorer-backend-$EXPLORER_VERSION/utx-tracker.Dockerfile'

echo "Switching sbt to 1.5.8"
sed -i -e 's/^sbt.version =.*/sbt.version = 1.5.8/' 'explorer-backend-$EXPLORER_VERSION/project/build.properties'
echo "Done."
