#!/bin/bash

directories=$(find "." -type d -not -path "." -maxdepth 1)
for d in ${directories}; do
    pushd "${d}"
    go mod download
    go test -v --bench . --benchmem
    popd
done
