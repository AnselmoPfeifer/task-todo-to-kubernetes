# task-todo-to-kubernetes

- cd terraform && terraform init
- terraform plan; terraform apply -auto-approve
- terrafor destoy

# Mac enable VirtuallEnv
- virtualenv --python /usr/local/bin/python3 venv
- source venv/bin/active
- pip3 install awscli --upgrade
- kubectl create namespace task-todo

- To create your Amazon EKS service role
```
Open the IAM console at https://console.aws.amazon.com/iam/.
Choose Roles, then Create role.
Choose EKS from the list of services,
then Allows Amazon EKS to manage your clusters on your behalf for your use case, then Next: Permissions.
For Role name, enter a unique name for your role, such as eksServiceRole, then choose Create role.
```
- Create your Amazon EKS Cluster VPC
- https://www.youtube.com/watch?v=PjxJzyP_bdU
- https://github.com/harshitshah65/task-todo-to-kubernetes
- https://github.com/Jobbatical/task-todo-to-kubernetes
- https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
- https://github.com/terraform-providers/terraform-provider-aws/blob/master/examples/eks-getting-started/eks-worker-nodes.tf
- https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html#kubernetes-masters