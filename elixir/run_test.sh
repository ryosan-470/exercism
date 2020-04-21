#!/bin/bash

function run_test() {
    TARGET_PATH=$1

    if [ -f ${TARGET_PATH}/mix.exs ]; then
        cd $TARGET_PATH
        mix deps.get
        mix test
        cd ../
    else
        elixir ${TARGET_PATH}/*_test.exs
    fi
}

function run_tests() {
    directories=$(find "." -type d -not -path "." -maxdepth 1)
    for d in ${directories}; do
        run_test $d;
    done
}

case $1 in
    "all") run_tests ;;
    *) run_test $1 ;;
esac
