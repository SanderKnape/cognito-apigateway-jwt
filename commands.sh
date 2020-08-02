#!/bin/bash

EMAIL=fake@example.com
PASSWORD=S3cure!!

CLIENT_ID=<client_id>
POOL_ID=<pool_id>
API_URL=<api_url>

# Missing Authorization header; will return a 401
curl -D - ${API_URL}

# Creating and confirming user
aws cognito-idp sign-up \
  --client-id ${CLIENT_ID} \
  --username ${EMAIL} \
  --password ${PASSWORD}

aws cognito-idp admin-confirm-sign-up \
  --user-pool-id ${POOL_ID} \
  --username ${EMAIL}

# Requesting JWT token
TOKEN=$(aws cognito-idp initiate-auth \
    --client-id ${CLIENT_ID} \
    --auth-flow USER_PASSWORD_AUTH \
    --auth-parameters USERNAME=${EMAIL},PASSWORD=${PASSWORD} \
    --query 'AuthenticationResult.AccessToken' \
    --output text)

# Including Authorization header; will return a 200
curl -s -D - -o /dev/null -H "Authorization: Bearer ${TOKEN}" ${API_URL}
