#!/bin/bash

directories=$(find "." -type d -not -path "." -maxdepth 1)
for d in ${directories}; do
    cd ${d}
    go test -v --bench . --benchmem
    cd ..
done
