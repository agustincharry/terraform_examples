# Terraform Examples

<aside>
⚠️ To run AWS Examples, you need to set AWS credentials

</aside>

## Set AWS Credentials

Create a `.env` file with AWS credentials

<aside>
✅ Use `.env.example` file as a guide

</aside>

```bash
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_SESSION_TOKEN=""
export AWS_DEFAULT_REGION=""
```

And then run the command

```bash
source .env
```

## Terraform commands

<aside>
⚠️ Run the commands inside an example folder you want

</aside>

### Terraform init

```bash
terraform init
```

### Terraform plan

```bash
terraform plan
```

### Terraform apply

```bash
terraform apply
```

### Terraform destroy

```bash
terraform destroy
```