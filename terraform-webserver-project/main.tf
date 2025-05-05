resource "aws_vpc" "app-vpc" {
  cidr_block = var.vpc-cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.app-vpc.id
  cidr_block        = var.subnet1-cidr
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.app-vpc.id
  cidr_block        = var.subnet2-cidr
  availability_zone = "us-east-1b"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app-vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.app-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt-assoc-sub1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rt-assoc-sub2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "app-sg" {
  vpc_id = aws_vpc.app-vpc.id
  name   = "app-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver1" {
  ami             = var.ami
  instance_type   = var.instance-type
  associate_public_ip_address = true
  security_groups = [aws_security_group.app-sg.id]
  subnet_id       = aws_subnet.subnet1.id
  user_data       = base64encode(file("userdata.sh"))
}

resource "aws_instance" "webserver2" {
  ami             = var.ami
  instance_type   = var.instance-type
  associate_public_ip_address = true
  security_groups = [aws_security_group.app-sg.id]
  subnet_id       = aws_subnet.subnet2.id
  user_data       = base64encode(file("userdata1.sh"))
}

resource "aws_lb" "app-lb" {
  name               = "webapp-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app-sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "app-lb-tg" {
  name     = "ec2-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app-vpc.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "app-lb-tg-attach1" {
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app-lb-tg-attac2" {
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_listener" "app-lb-listner" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}

output "lb-dns" {
  value = aws_lb.app-lb.dns_name
}