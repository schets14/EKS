################----security group for jump server-----###########################
resource "aws_security_group" "jump_server_sg" {
  name        = "jump_server_sg"

  vpc_id = var.jump_vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH 
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}
#######################------EC2 CREATION-------################################
resource "aws_instance" "jump-server" {
  ami           = var.jump_ami_id
  instance_type = var.jump_instance_type
  subnet_id     = var.jump_subnet_id  # Use the VPC ID from the output of the VPC module
  key_name      = var.jump_key_name
  security_groups = [aws_security_group.jump_server_sg.id]
  tags = {
    Name = "jump-server"
  }
  # Other EC2 instance configurations
  user_data = <<-EOF
                #!/bin/bash

                # Update package lists
                sudo apt-get update

                # Install kubectl
                echo "Installing kubectl..."
                sudo apt-get install -y kubectl

                # Install Docker
                echo "Installing Docker..."
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

                # Add the current user to the docker group to run Docker without sudo
                sudo usermod -aG docker $USER

                # Install Helm
                echo "Installing Helm..."
                curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
                chmod +x get_helm.sh
                ./get_helm.sh

                # Install unzip
                sudo apt install unzip -y

                # Install awscli
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install

                # Clean up
                rm get_helm.sh

                echo "Installation completed successfully."
                EOF
}