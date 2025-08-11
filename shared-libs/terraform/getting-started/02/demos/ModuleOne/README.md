# Terraform NGINX EC2 Demo (Free-Tier Safe)


Spin up a single **Amazon Linux 2023** EC2 instance, install **NGINX** via `user_data`, open ports **80/22**, and output the instance’s **public DNS**. No credentials in code.

---

## What this creates

- **Security Group** `tf-nginx-sg`
  - Ingress: TCP **80** (HTTP) from `0.0.0.0/0`
  - Ingress: TCP **22** (SSH) from `0.0.0.0/0`
  - Egress: all
- **EC2 Instance** `aws_instance.nginx`
  - AMI: Latest **Amazon Linux 2023 (x86_64)**
  - Type: **t2.micro** (Free-Tier eligible)
  - `user_data`: installs and starts **NGINX**
- **Output**
  - `public_dns`: the DNS you can open in a browser

---

## File layout

```
providers.tf   # Terraform + AWS provider requirements; uses var.region
variables.tf   # region, instance_type, key_name
ami.tf         # Data source: latest AL2023 x86_64 AMI
network.tf     # Security group allowing 22/80
main.tf        # EC2 instance + user_data to install NGINX
outputs.tf     # public_dns output
README.md      # this file
```

---

## Quick start

From this folder:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

Grab the DNS:

```bash
terraform output -raw public_dns
```

Open `http://<that-dns>` to see the NGINX welcome page.

---

## Inputs

| Variable        | Type   | Default      | Notes                                                      |
|-----------------|--------|--------------|------------------------------------------------------------|
| `region`        | string | `us-east-1`  | Execution region.                                          |
| `instance_type` | string | `t2.micro`   | Free-Tier safe.                                            |
| `key_name`      | string | `PluralsightKeys` | **Optional**. Only needed if you want SSH access.    |

> Don’t need SSH? Remove `key_name` from `main.tf`.

---

## Outputs

- `public_dns` — EC2 public DNS name (use in your browser).

---

## Cost / Free Tier guardrails

- **EC2 `t2.micro`**: ≤ **750 hrs/mo** (one instance 24×7 fits).
- **EBS**: keep root volume small; stay ≤ **30 GB gp2/gp3** total.
- **Data transfer**: inbound free; keep outbound small (< **1 GB/mo** for $0).

Destroy when done:

```bash
terraform destroy -auto-approve
```

---

## Troubleshooting

- **`InvalidKeyPair.NotFound`**  
  You referenced a `key_name` that doesn’t exist in the target region. Either remove `key_name` or create/import that key (same name, same region).

- **Plan shows only the security group**  
  You’re missing `main.tf` or `ami.tf` in this exact directory. Terraform loads files **only** from the working directory.

- **AMI not found**  
  The AL2023 filter in `ami.tf` expects x86_64. If you switch to ARM, update the filter to `al2023-ami-*-arm64` **and** pick a Graviton instance type (e.g., `t4g.micro`).

- **NGINX doesn’t load yet**  
  Give it 30–60 seconds for `user_data` to finish and the service to start, then retry the `public_dns` URL.

---

## Git hygiene

Add a `.gitignore` in this folder to avoid leaking state/secrets:

```
.terraform/
.terraform.lock.hcl
terraform.tfstate
terraform.tfstate.backup
*.tfvars
terraform.tfvars
```

Commit with a clear scope:

```bash
git add .
git commit -m "feat(terraform-lab): Week 1–2 nginx demo (free-tier, us-east-1)"
```
