data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "this" {
  ami                                  = data.aws_ami.amazon_linux.id
  instance_type                        = var.instance_type
  subnet_id                            = var.subnet_id
  vpc_security_group_ids               = [var.security_group_id]
  key_name                             = var.key_name
  instance_initiated_shutdown_behavior = "terminate"

  user_data = <<-EOT
    #!/bin/bash
    set -e
    dnf -y update
    dnf -y install nginx
    systemctl enable --now nginx

    cat >/usr/share/nginx/html/index.html <<'HTML'
    <html>
      <head><title>Blue Team Server</title></head>
      <body style="background-color:#1F778D">
        <p style="text-align:center;">
          <span style="color:#FFFFFF;font-size:28px;">Blue Team</span>
        </p>
      </body>
    </html>
    HTML
  EOT

  tags = { Name = "${var.name_prefix}" }
}
