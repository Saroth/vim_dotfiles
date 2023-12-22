#!/bin/bash
# Usage: .../run_test.sh [some_files]

BASEPATH=$(cd `dirname $0`; cd ..; pwd)
BASEPATH=$BASEPATH nvim -u $BASEPATH/test/vimrc $*

