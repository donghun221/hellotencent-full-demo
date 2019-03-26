#!/bin/bash

# 1: Declare to project root
export PROJECT_NAME=HelloTencent
export APOLLO_ENV=$HOME/apollo/env
export PROJECT_PATH=$APOLLO_ENV/$PROJECT_NAME

echo "exporting environment valuables..."
echo "PROJECT_NAME = $PROJECT_NAME"
echo "APOLLO_ENV = $APOLLO_ENV"
echo "PROJECT_PATH = $PROJECT_PATH"

# 2: Move to project source root folder
cd $GOPATH/src/$PROJECT_NAME

echo "Move to project source root folder..."

# 3: Compile proto file
protoc --go_out=plugins=grpc:. api/*.proto

echo "Compile proto file at api/*.proto ..."

# 4: Build main file
go build -o HelloTencent internal/main.go

go build -o CommonClient examples/common_service_client.go

echo "Build main file at internal/main.go ..."

# 5: Make target package
rm -rf target

mkdir target \
      target/$PROJECT_NAME
mkdir target/$PROJECT_NAME/bin \
      target/$PROJECT_NAME/cmd \
      target/$PROJECT_NAME/tools \
      target/$PROJECT_NAME/env \
      target/$PROJECT_NAME/init \
      target/$PROJECT_NAME/scripts \
      target/$PROJECT_NAME/var \
      target/$PROJECT_NAME/logs \
      target/$PROJECT_NAME/configs \
      target/$PROJECT_NAME/assets

echo "Make target package..."

# 6: Copy related files to target folder
mv $PROJECT_NAME target/$PROJECT_NAME/bin/$PROJECT_NAME
mv CommonClient target/$PROJECT_NAME/bin/CommonClient
cp configs/* target/$PROJECT_NAME/configs/

echo "Copy related files to target folder..."

# 7: Copy to apollo env
cp -r target/ $APOLLO_ENV/

echo "Copy to apollo env..."
