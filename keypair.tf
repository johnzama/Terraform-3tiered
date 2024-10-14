# Generate SSH key pair using Terraform
resource "tls_private_key" "web_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Output the private key so you can download it (be careful, it's sensitive)
output "private_key" {
  value     = tls_private_key.web_ssh_key.private_key_pem
  sensitive = true  # This ensures it's hidden in the output
}

# Output the public key, which will be uploaded to AWS
output "public_key" {
  value = tls_private_key.web_ssh_key.public_key_openssh
}

resource "aws_key_pair" "web_key_pair" {
  key_name   = "web-tier-key"  # Name the key pair
  public_key = tls_private_key.web_ssh_key.public_key_openssh  # Use the public key generated above
}
