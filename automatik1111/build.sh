#!/usr/bin/env bash
set -eu

dir=$(dirname $0)
cd "$dir"
docker build -t automatik1111 .
docker tag automatik1111 us-central1-docker.pkg.dev/andromeda-456013/amber/automatik1111
docker tag automatik1111 us-central1-docker.pkg.dev/andromeda-456013/amber/automatik1111:local
