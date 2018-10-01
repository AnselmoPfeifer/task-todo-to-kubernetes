resource "aws_vpc" "vpc-task-todo" {
  cidr_block = "10.0.0.0/16"
  tags = "${
    map(
     "Name", "vpc-${var.label}",
     "kubernetes.io/cluster/${var.label}", "shared"
    )
  }"
}

resource "aws_subnet" "subnet-task-todo" {
  count = 3
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.vpc-task-todo.id}"
  tags = "${
    map(
     "Name", "subnet-${var.label}-${count.index}",
     "kubernetes.io/cluster/${var.label}", "shared"
    )
  }"
}

resource "aws_internet_gateway" "gateway-task-todo" {
  vpc_id = "${aws_vpc.vpc-task-todo.id}"
  tags {
    Name = "gateway-${var.label}"
  }
}

resource "aws_route_table" "route-table-task-todo" {
  vpc_id = "${aws_vpc.vpc-task-todo.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway-task-todo.id}"
  }
}

resource "aws_route_table_association" "association-task-todo" {
  count = 3
  subnet_id      = "${aws_subnet.subnet-task-todo.*.id[count.index]}"
  route_table_id = "${aws_route_table.route-table-task-todo.id}"
}