#!/bin/bash

function run_test() {
    TARGET_PATH=$1

    if [ -f ${TARGET_PATH}/mix.exs ]; then
        mix test
    else
        elixir ${TARGET_PATH}/*_test.exs
    fi
}

function run_tests() {
    directories=$(find elixir -type d)
    for d in ${directories}; do
        run_test $d;
    done
}

case $1 in
    "all") run_tests ;;
    "*") run_test $1 ;;
esac
