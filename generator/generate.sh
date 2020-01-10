#!/bin/bash -eux
openapi-generator generate \
-i openapi/token-api.yaml \
-g dart \
-t templates \
-Dmodels \
-DmodelDocs=false \
-DmodelTests=false