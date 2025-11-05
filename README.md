# Azure IaC for Two‑Tier Web App (App Service + SQL + Storage)

## What this deploys
- Resource Group
- Single‑purpose VNet with two subnets (App Service VNet Integration, Private Endpoints)
- Private DNS Zones for Storage + SQL
- Storage Account (Blob) with private endpoint, public disabled
- Azure SQL Server + Database with public disabled and Entra admin
- (Optional) Key Vault with private endpoint
- App Service Plan (Linux) + two Web Apps (frontend, backend)
- VNet Integration for apps
- Least‑privilege RBAC from apps to Storage

## Why these choices
- **App Service**: managed, fast to operate, supports private data access, scales easily; simpler than AKS/VMSS for this scope.
- **Private Endpoints + Private DNS**: isolate data plane, remove public exposure.
- **Managed Identity + Entra ID**: passwordless DB + Storage access.
- **Two subnets**: clear separation of concerns; avoids mixing PEs with app integration.

## Environments
Two folders under `environments/` (`cde`, `prod`) drive different SKUs, address spaces, and tags. Names are suffixed with `-<env>`.

## How to deploy
```bash
# auth
az login

# create cde
cd environments/cde
terraform init
terraform plan -out out.plan
terraform apply out.plan

# prod
cd ../prod
terraform init
terraform plan -out out.plan
terraform apply out.plan
```

## Post‑deploy SQL grants
Create database users for the two app managed identities and assign roles (reader/writer):

```sql
CREATE USER [<backend-app-mi-name>] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [<backend-app-mi-name>];
ALTER ROLE db_datawriter ADD MEMBER [<backend-app-mi-name>];

CREATE USER [<frontend-app-mi-name>] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [<frontend-app-mi-name>];
```

## Variables to set
See `environments/*/terraform.tfvars` and update:
- `sql_azuread_admin_login`, `sql_azuread_admin_object_id`
- `tenant_id`
- CIDRs/SKUs per your capacity plan

## Notes & known issues
1. Terraform cannot natively manage AAD DB users. Apply the provided T‑SQL once per environment.
2. If you need outbound IP allowlisting, add NAT Gateway + UDRs.
3. Key Vault is optional for this design.
