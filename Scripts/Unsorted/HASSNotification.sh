#!/bin/bash
BEARER=''
DEVICE=""
DOMAIN="http://example.com/api/services"


curl -s -X POST \
  -H "Authorization: Bearer $BEARER" \
  -H "Content-Type: application/json" \
  -d '{"title": "Storange", "message": "Script Finished"}' \
  $DOMAIN/$DEVICE
