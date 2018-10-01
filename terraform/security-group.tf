# Security group for Cluster EKS
resource "aws_security_group" "sg-cluster-task-todo" {
  name        = "sg_cluster_${var.label}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.vpc-task-todo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg-cluster-${var.label}"
  }
}

resource "aws_security_group_rule" "sr-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sg-cluster-task-todo.id}"
  source_security_group_id = "${aws_security_group.sg-worker-task-todo.id}" //node
  to_port                  = 443
  type                     = "ingress"
}

# Security group for Node EKS
resource "aws_security_group" "sg-worker-task-todo" {
  name        = "sg_worker_${var.label}"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.vpc-task-todo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "sg-worker-${var.label}",
     "kubernetes.io/cluster/${var.label}", "owned"
    )
  }"
}

resource "aws_security_group_rule" "sr-worker-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.sg-worker-task-todo.id}"
  source_security_group_id = "${aws_security_group.sg-cluster-task-todo.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "sr-workder-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sg-worker-task-todo.id}"
  source_security_group_id = "${aws_security_group.sg-cluster-task-todo.id}"
  to_port                  = 65535
  type                     = "ingress"
}