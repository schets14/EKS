resource "aws_instance" "jump-server" {
  ami           = var.jump_ami_id
  instance_type = var.jump_instance_type
  subnet_id     = var.subnet_id  # Use the VPC ID from the output of the VPC module
  key_name      = var.jump_key_name
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
                sudo apt-get install -y docker.io

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