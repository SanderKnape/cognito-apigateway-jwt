# AWS HTTP API with Cognito JWT Token Authentication

This repository contains example code to set up an [AWS HTTP API](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html) configured to authenticate with JWT tokens coming from an [Amazon Cognito User Pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html).

Below you can find the minimal instructions to use the code in this repository. More information about this setup can be found in my blog post: [Using Amazon Cognito JWT tokens to authenticate with an Amazon HTTP API](https://sanderknape.com/2020/08/amazon-cognito-jwt-tokens-authenticate-amazon-http-api).

## Usage

Deploy the CloudFormation stack with the following AWS CLI command:

`aws cloudformation create-stack --stack-name "cognito-apigateway" --template-body file://stack.yaml`

Once the stack is succesfully created, find the outputs either in the AWS Console or using the following command:

`aws cloudformation describe-stacks --stack-name "cognito-apigateway" --query 'Stacks[0].Outputs'`

Set these values to the correct variables in the [commands.sh](/commands.sh) file.

Now execute this file:

`./commands.sh`

This will:

1. Execute a non-authenticated request to the API: this will return a 401 Unauthorized
2. Create and confirm a test user. The e-mailadres doesn't have to exist
3. Request a JWT token using the username's e-mail and password
4. Execute an authenticated request to the API using the JWT token: this returns a 200 OK

## Teardown

Simply delete the CloudFormation stack to get rid of all the created resources:

`aws cloudformation delete-stack --stack-name "cognito-apigateway"`
