#!/bin/bash
set -ex -o pipefail


check_deps () {
    docker=`which docker`
}


build_container () {
    $docker build --tag one2blame-cv `pwd`
}

pull_container () {
    $docker pull one2blame/latex:latest
}

format_cv () {
    $docker run --volume `pwd`:/data one2blame/latex:latest latexindent --silent --outputfile=cv.tex cv.tex
}


build_pdf () {
    $docker run --volume `pwd`:/data one2blame/latex:latest pdflatex cv.tex
}


build_html () {
    $docker run -ti --rm -v `pwd`:/pdf bwits/pdf2htmlex-alpine pdf2htmlEX --zoom 1.3 cv.pdf
}


check_deps
# build_container
pull_container
format_cv
build_pdf
build_html

mkdir -p docs
mv cv.pdf docs
mv cv.html docs/index.html
