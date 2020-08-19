#!/bin/sh

set -eu

mv WebOrmolu.html WebOrmolu.html.old

ahc-link \
  --input-hs WebOrmolu.hs \
  --input-mjs WebOrmolu.mjs \
  --no-main \
  --export-function=webOrmolu \
  --browser \
  --bundle \
  --yolo


mv WebOrmolu.html.old WebOrmolu.html

rm -f *.hi *.o *.mjs

chown $UID:$GID *

tar -cf ../ormolu.tar \
  *.html \
  *.js \
  *.wasm
