#!/bin/bash -eux
openapi-generator generate \
-i payjp.yaml \
-g dart \
-t templates \
-Dmodels \
-DmodelDocs=false \
-DmodelTests=false