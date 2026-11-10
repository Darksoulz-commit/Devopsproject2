# DEFINE ALL YOUR VARIABLES HERE

instance_type = "c7i-flex.large"
ami           = "ami-02eb7a4783e7e9317"   # Ubuntu 24.04
key_name      = "naveen-server-key"                     # Replace with your key-name without .pem extension
volume_size   = 30
region_name   = "ap-south-1"
server_name   = "JENKINS-SERVER"

# Note: 
# a. First create a pem-key manually from the AWS console
# b. Copy it in the same directory as your terraform code
