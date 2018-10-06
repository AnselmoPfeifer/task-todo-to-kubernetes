# Task Todo to Kubernetes

## To install dependencies
- MacOS:
```
brew install awscli
```
- Linux:
```pip install awscli```

## To Install Authenticator AWS
- [Linux](https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator)

- [MacOS](https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator)
 mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
```
- To create the new eks cluster
```./start.sh create```

- To execute the build and deploy the app on cluster
```./start.sh deploy```

- To destroy the eks cluster
```./start.sh destroy```

## Time spent
- terraform scripts: 2 hours
- kubernetes build and deploy: 