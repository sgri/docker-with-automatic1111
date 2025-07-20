#!/usr/bin/env bash
set -eu

dir=$(dirname $0)
cd "$dir"
docker build -t automatik1111 .
