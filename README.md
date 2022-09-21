# Deploy, Manage, and Scale a NodeJS Application on Heroku

This is a companion repository to the "Deploy, Manage, and Scale a NodeJS Application on Heroku" tutorial
on [HashiCorp Learn](https://learn.hashicorp.com/tutorials/terraform/heroku-provider).

```bash
terraform init
```

```bash
terraform apply -auto-approve -var-file=".env.tfvars"
```

```bash
terraform destroy -auto-approve -var-file=".env.tfvars"
```
