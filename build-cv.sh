#!/bin/bash
set -ex -o pipefail


check_deps () {
    docker=`which docker`
}


build_container () {
    $docker build --tag one2blame-cv `pwd`
}


build_cv () {
    $docker run --volume `pwd`:/data one2blame-cv pdflatex cv.tex
}


check_deps
build_container
build_cv
