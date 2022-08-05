#!/bin/bash
set -ex -o pipefail


check_deps () {
    docker=`which docker`
}


build_container () {
    $docker build --tag one2blame-cv `pwd`
}


format_cv () {
    $docker run --volume `pwd`:/data one2blame-cv latexindent --silent --outputfile=cv.tex cv.tex
}


build_cv () {
    $docker run --volume `pwd`:/data one2blame-cv pdflatex cv.tex
}


check_deps
build_container
format_cv
build_cv
