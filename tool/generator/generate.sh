#!/bin/bash -eux
openapi-generator-cli generate \
-i token-api.yaml \
-g dart-dio-next \
-o project
