# Grupo Tenho Medo de Grupos - Entrega Aula 01

Documento principal: [`entrega-grupo-TenhoMedoDeGrupos-aula01.md`](./entrega-grupo-TenhoMedoDeGrupos-aula01.md)

Diagrama da arquitetura (Exercício 2.1): [`diagramas/arquitetura-qc-aula01.png`](./diagramas/arquitetura-qc-aula01.png)

## Como rodar o Terraform (Exercício 3.1)

Pré-requisitos: Azure Cloud Shell (ou Terraform + Azure CLI local com `az login` feito), chave SSH em `~/.ssh/id_rsa.pub`.

```bash
cd terraform
terraform init
export TF_VAR_meu_ip=$(curl -s ifconfig.me)
terraform plan
terraform apply
terraform output public_ip_address
# ao final:
terraform destroy
```

## Como rodar o Bicep (Exercício 3.2)

```bash
cd bicep
az group create --name rg-bicep-aula01 --location eastus2
az deployment group create \
  --resource-group rg-bicep-aula01 \
  --template-file main.bicep \
  --parameters adminPublicKey="$(cat ~/.ssh/id_rsa.pub)" meuIp="$(curl -s ifconfig.me)"
# ao final:
az group delete --name rg-bicep-aula01 --yes --no-wait
```

## Observação

`aulas/01-fundamentos-iac/template/template.json` não existe no repositório oficial nesta aula, então o Bicep foi escrito manualmente a partir do `main.tf`, em vez de gerado via `bicep decompile`.

Todo poder emana do código