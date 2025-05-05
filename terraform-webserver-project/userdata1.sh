#!/bin/bash
# Update the package index
yum update -y

# Install Apache (httpd on Amazon Linux)
yum install -y httpd

# Install AWS CLI
yum install -y aws-cli

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Start Apache and enable it on boot
systemctl start httpd
systemctl enable httpd

# Create index.html with expanded variable
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 2</h1>
  <p>Welcome to Aravindhan's terraform project</p>
</body>
</html>
EOF
