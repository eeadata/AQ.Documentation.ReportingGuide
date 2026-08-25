#!/bin/bash

set -Eeuo pipefail

echo "Building local documentation..."

rm -rf build/html

/usr/bin/python3 -m sphinx \
    --keep-going \
    -E \
    -a \
    -b html \
    source \
    build/html

echo "Build completed successfully."

if command -v open >/dev/null 2>&1; then
    open build/html/index.html
fi

echo "Done!"
