resource "aws_instance" "my_instance" {
  ami           = var.jump_ami_id # replace with your AMI id
  instance_type = var.jump_instance_type

  subnet_id              = element(module.vpc.public_subnets, 0) # replace with your subnet id
  vpc_security_group_ids = [aws_security_group.jumpsg.id]

  tags      = local.tags
  user_data = <<-EOF
                #!/bin/bash

                # Update package lists
                sudo apt-get update

                # Install kubectl
                echo "Installing kubectl..."
                sudo apt-get install -y kubectl

                # Install Docker
                sudo apt install docker.io
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