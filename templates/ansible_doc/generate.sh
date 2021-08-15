#!/bin/bash

tasks=(
    "exportAnsibleRoles"
    "exportMarkdown"
    "exportChangeLog"
    "exportContributorsTable"
    "generateHtml"
    "generatePdf"
#    "publishToConfluence"
)


docker run --rm -it --entrypoint /bin/bash -v $(dirname ${PWD}):/project doctoolchain:dev \
-c "cd /project/doc &&
doctoolchain . ${tasks[*]} &&
exit 0"

cp ./build/pdf/doc/manual.pdf .
