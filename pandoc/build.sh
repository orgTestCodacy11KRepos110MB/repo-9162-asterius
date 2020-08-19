#!/bin/sh

set -eu

mv pandoc.html pandoc.html.old

ahc-link \
  --input-hs pandoc.hs \
  --browser \
  --bundle \
  --yolo


mv pandoc.html.old pandoc.html

rm -f *.mjs
