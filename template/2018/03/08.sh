#!/bin/sh

PYTHON_VERSION="$(python3 -c 'from sys import version_info as v; print("%d.%d" % (v.major, v.minor))')"
PYBIND11_VERSION="$(brew info pybind11 --json | jq -r '.[0].installed[0].version')"

printf "clang sample.cpp -std=c++20 -lc++ -lpython%s -rpath /Library/Developer/CommandLineTools/Library/Frameworks" ${PYTHON_VERSION}
printf " -I/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/%s/Headers" ${PYTHON_VERSION}
printf " -I/opt/homebrew/Cellar/pybind11/%s/include" ${PYBIND11_VERSION}
printf " -L/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/%s/lib" ${PYTHON_VERSION}
printf " -o sample"
