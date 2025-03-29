resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
      name = "Multi-Az-VPC"
    }
}

resource "aws_subnet" "Public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "sa-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "Public-subnet"
    }
  
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "sa-east-1b"

    tags = {
      Name = "Private-subnet"
    }
  
}
resource "aws_internet_gateway" "Ig" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "aws-ig"
    }
  
}
resource "aws_security_group" "rds-sg" {
    vpc_id = aws_vpc.main.id
    
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    tags = {
      Name = "RDS-security-Grp"
    }
}
