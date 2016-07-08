#! /bin/bash

uniqx() {
    awk '{ if (!h[$0]) { print $0; h[$0]=1 } }' "$*"
}

