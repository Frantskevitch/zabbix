#!/bin/bash
curl -sL -w "%{http_code} \\n" "$@" -o /dev/null
