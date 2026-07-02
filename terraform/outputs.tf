# Exercício 3.1, item 3 — expõe apenas o IP público da VM após o apply.
output "public_ip_address" {
  description = "IP público da VM (uso: terraform output public_ip_address)"
  value       = azurerm_public_ip.pip.ip_address
}
