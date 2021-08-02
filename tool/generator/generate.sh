#!/bin/bash -eux
openapi-generator-cli generate \
-i openapi/token-api.yaml \
-g dart-dio-next \
-o project
