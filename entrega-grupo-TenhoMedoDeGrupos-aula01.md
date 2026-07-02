# Entrega Aula 01 — Grupo "Tenho medo de Grupos"

**Disciplina:** Cloud & Cognitive Environments — FIAP MBA AI Engineering & Multi-Agents
**Turma:** 2AIER
**Data de entrega:** 01/07/2026

## Grupo

| # | Nome completo | GitHub         | E-mail FIAP |
|---|---------------|----------------|-------------|
| 1 | Tiago da Silva Brilhante | tiagobrilhante | contato@brilhante.dev.br |
| 2 | Gabriel Moreira Do Nascimento | brunotlima     |  biel.djc603@gmail.com |
| 3 | Andrew Augusto Jungers da Silva | Andrew470-coder         | andrewaugustolink@hotmail.com |
| 4 | Getter Benedito de Matos Fernandes  | Getterbmf           | getterbmf@gmail.com |


## Distribuição do trabalho

| Membro | Nível assumido | Item específico |
|--------|----------------|-----------------|
| Tiago da Silva Brilhante | 🟢 N1 | Exercícios 1.1 e 1.2 |
| Gabriel Moreira Do Nascimento | 🟢 N1 | Exercícios 1.3 e 1.4 |
| Andrew Augusto Jungers da Silva | 🟡 N2 | Exercício 2.1 — Arquitetura QC + diagrama |
| Andrew Augusto Jungers da Silva | 🟡 N2 | Exercícios 2.2 e 2.3 |
| Tiago da Silva Brilhante | 🔴 N3 (bônus) | Exercícios 3.1, 3.2 e 3.3 |


---

## 🟢 Nível 1 — Respostas

---

### Exercício 1.1 — Mapeamento de modelos de serviço

```text
Para cada serviço, identifique se é IaaS, PaaS, SaaS ou FaaS. Justifique em uma frase.
```

| Serviço | Modelo | Justificativa |
|---------|--------|----------------|
| Gmail | SaaS | Aplicação pronta entregue ao usuário final; nenhuma camada de infra, runtime ou dados é gerenciada por quem usa. |
| Azure Virtual Machines | IaaS | A Microsoft entrega só o hardware virtualizado; SO, patches, runtime e aplicação ficam sob responsabilidade do cliente. |
| Azure App Service (hospedar API) | PaaS | O runtime e o SO são gerenciados pela Azure; o time só faz deploy do código da API. |
| AWS Lambda | FaaS | Não existe servidor a gerenciar nem alocar; a cobrança é por execução da função, o resto é abstraído pela AWS. |
| Azure SQL Database | PaaS | O motor de banco (patches, HA, backups) é gerenciado pela Azure; o cliente cuida só do schema e dos dados. |
| Salesforce CRM | SaaS | Sistema de CRM completo consumido via navegador, sem nenhuma camada de infraestrutura exposta ao cliente. |
| Google Kubernetes Engine (GKE) | PaaS/IaaS (híbrido) | O GCP opera o control plane do Kubernetes; o time de QC continua responsável pelos pods, imagens e workloads. |
| Azure Blob Storage | PaaS | Storage totalmente gerenciado (durabilidade, replicação); o cliente só define containers, políticas e dados. |
| Azure OpenAI Service | SaaS / API-as-a-Service | Consumido via chamada REST; não há gestão de modelo, infraestrutura de GPU ou runtime por parte do cliente. |

---

### Exercício 1.2 — Os 6 Rs na prática

```text
Leia cada cenário e escolha o R de migração mais adequado (Rehost, Replatform, Refactor, Repurchase, Retire, Retain). Justifique.

Cenário A: Empresa de logística tem sistema de rastreamento de frotas em servidor físico próprio. Código de 2008, sem documentação, só uma pessoa sabe mexer. Quer migrar rápido para ganhar elasticidade.

Cenário B: Banco regional usa ERP local de RH. Análise mostra: menos de 5 usuários ativos por mês, dados raramente consultados.

Cenário C: Fintech tem API de pagamentos monolítica. Decide aproveitar a migração para refatorar em microserviços com K8s e event-driven.

Cenário D: Varejo usa CRM desenvolvido internamente há 15 anos. SaaS de mercado atenderia 90% das necessidades por menor custo.

Cenário E: Instituição financeira tem mainframe com dados de clientes que precisa ficar on-premise por exigência do Banco Central.
```


**Cenário A: sistema de rastreamento de frotas (2008, sem doc, 1 mantenedor):**
**Rehost.** O código legado sem documentação e a dependência de uma única pessoa tornam qualquer refatoração arriscada a curto prazo. Rehost move a carga para a nuvem rapidamente, ganhando elasticidade de infraestrutura sem tocar no código — o risco fica isolado à camada de rede/servidor, não ao software.

**Cenário B: ERP de RH com menos de 5 usuários/mês:**
**Retire.** Baixíssimo uso não justifica o custo de manter, licenciar ou migrar o sistema. Melhor arquivar os dados históricos em storage frio (para eventual auditoria) e desligar o ERP.

**Cenário C: API de pagamentos monolítica, decisão de ir para microserviços:**
**Refactor.** A empresa decidiu explicitamente investir em reescrever a arquitetura (microserviços + K8s + eventos). É o R de maior esforço, mas também o que sustenta crescimento e resiliência a longo prazo para um domínio crítico como pagamentos.

**Cenário D: CRM interno de 15 anos, SaaS cobre 90% da necessidade:**
**Repurchase.** Quando uma solução de mercado atende a maior parte do escopo por um custo menor que manter software proprietário, repurchase costuma vencer — desde que os 10% restantes não sejam um diferencial competitivo insubstituível.

**Cenário E: mainframe com dados sob exigência do Banco Central:**
**Retain.** Exigência regulatória não é uma limitação técnica a ser contornada. É um requisito de compliance. Manter on-premise aqui é a decisão correta, não uma falha de estratégia de migração.

---

### Exercício 1.3 — Calculando o impacto do SLA

```text
Sistema de e-commerce com SLA de 99,9%.

a) Quantas horas de downtime por ano? 
b) Se processa R$ 50.000/hora em vendas, qual o impacto financeiro máximo por ano? 
c) Para reduzir o impacto para menos de R$ 50.000/ano, qual SLA mínimo seria necessário?
```

Sistema de e-commerce, SLA = 99,9%, R$ 50.000/hora em vendas.

**a) Downtime anual permitido:**
Downtime = 8.760 × (1 − 0,999) = **8,76 horas/ano** (≈ 525 minutos)

**b) Impacto financeiro máximo por ano:**
8,76 h × R$ 50.000 = **R$ 438.000/ano**

**c) SLA mínimo para impacto < R$ 50.000/ano:**
Downtime máximo tolerável = R$ 50.000 ÷ R$ 50.000/h = 1 hora/ano
1 ÷ 8.760 = 0,0114% → SLA mínimo de **99,9886%**
Na prática, o degrau comercial disponível mais próximo é **SLA 99,99%** (≈ 52 min/ano de downtime), que já fica bem abaixo do teto de R$ 50 mil.

---

### Exercício 1.4 — RBAC na prática

```text
Você é o responsável de segurança da Quantum Commerce. Para cada perfil abaixo, escolha a role built-in do Azure mais adequada e justifique:
```

| Perfil | Role Azure mais adequada | Justificativa                                                                                                          |
|--------|---------------------------|------------------------------------------------------------------------------------------------------------------------|
| Agente de IA que lê produtos do Storage | **Storage Blob Data Reader** | Acesso apenas de leitura no plano de dados. O agente nunca precisa escrever ou apagar blobs, só consultar o catálogo.  |
| Engenheiro de dados que carrega novos catálogos | **Storage Blob Data Contributor** | Precisa escrever/atualizar blobs, mas não precisa de permissões de gestão do storage account em si.                    |
| Time de FinOps que só visualiza custos | **Cost Management Reader** | Acesso de leitura estritamente ao módulo de custos, sem qualquer permissão sobre os recursos que geram esse custo.     |
| Auditor externo que lê configurações da assinatura | **Reader** (escopo assinatura) | Permite inspecionar configuração de todos os recursos sem risco de alteração acidental — adequado a auditoria externa. |
| CI/CD que provisiona infra via Terraform | **Contributor** no Resource Group específico + Service Principal dedicado | Escopo restrito ao(s) RG(s) que o pipeline realmente gerencia; nunca Owner/Contributor na assinatura inteira.          |

**Princípio aplicado em todas as linhas:** 
- Menor privilégio possível para a tarefa 
- Nunca Owner ou Contributor de assinatura quando uma role com escopo mais estreito resolve.

---

---

## 🟡 Nível 2 — Respostas + Implementação

---

### Exercício 2.1 — Arquitetura de alto nível: Quantum Commerce

```text
Contexto: A Quantum Commerce é um gigante do e-commerce com 12 países, 5M de SKUs, e quer transformar a experiência de compra com IA conversacional.

Sua tarefa (em grupo): Proponha uma arquitetura de alto nível em cloud para a QC. Identifique:

1. Camadas da arquitetura — quantas e o que cada uma faz (ex: frontend, API, dados, AI/ML, observabilidade)
2. Provedor principal — qual escolheria (Azure, AWS, GCP) e por quê
3. Serviços por categoria — preencha a tabela:
4. Diagrama — feito no Excalidraw (excalidraw.com), draw.io (diagrams.net) ou à mão fotografado. Tudo sem instalação.
```

**1. Camadas da arquitetura:**

1. **Frontend / Experiência**: Web app, app mobile e o widget de chat conversacional; servidos via Azure Front Door + CDN.
2. **API / Orquestração**: API Gateway (APIM) na frente de um backend em AKS; concentra autenticação (Azure AD B2C) e roteamento entre os 5M SKUs.
3. **IA / Agentes**: Azure OpenAI Service para o LLM, Azure AI Search operando como vector store para RAG sobre o catálogo, e Azure AI Vision/Language para tarefas cognitivas auxiliares (ex.: análise de imagem de produto).
4. **Dados**: Azure SQL Database para dados transacionais/catálogo estruturado, Cosmos DB para sessão/carrinho (baixa latência, escala horizontal), Blob Storage para imagens e documentos.
5. **Mensageria/Integração**: Service Bus para filas de pedidos e Event Grid para eventos de domínio (estoque, envio).
6. **Observabilidade/Segurança**: Azure Monitor + Application Insights, Key Vault para segredos, RBAC granular e Microsoft Defender for Cloud.

**2. Provedor principal escolhido: Azure.**
Três motivos guiaram a escolha:
1) a camada de IA conversacional da QC depende de LLMs, e o Azure OpenAI Service oferece o modelo mais maduro de RBAC + rede privada para consumo de LLM em escala corporativa;
2) presença global em data centers cobre os 12 países de operação da QC com boa proximidade de latência;
3) integração nativa entre AKS, Azure AI Search e Cosmos DB reduz a complexidade de "colar" serviços de fornecedores diferentes numa arquitetura crítica.
- Bônus: Temos uma conta de estudante com 500+ USD de crédito!

**3. Tabela comparativa de serviços:**

| Categoria | Serviço Azure | Alternativa AWS | Alternativa GCP |
|-----------|----------------|-------------------|-------------------|
| Compute (backend) | Azure Kubernetes Service (AKS) | Amazon EKS | Google Kubernetes Engine (GKE) |
| Storage (catálogo, imagens) | Azure Blob Storage | Amazon S3 | Google Cloud Storage |
| Banco relacional | Azure SQL Database (Hyperscale) | Amazon RDS / Aurora | Cloud SQL / AlloyDB |
| Banco NoSQL | Azure Cosmos DB | Amazon DynamoDB | Firestore / Bigtable |
| Vector Database | Azure AI Search (vector search) | Amazon OpenSearch (k-NN) | Vertex AI Vector Search |
| Serviços de IA cognitivos | Azure AI Services (OpenAI, Vision, Language) | Amazon Bedrock + Rekognition + Comprehend | Vertex AI + Cloud Vision/NLP |
| CDN | Azure Front Door / CDN | Amazon CloudFront | Cloud CDN |
| Mensageria/Filas | Azure Service Bus + Event Grid | Amazon SQS/SNS + EventBridge | Cloud Pub/Sub |
| Observabilidade | Azure Monitor + App Insights | Amazon CloudWatch + X-Ray | Cloud Monitoring + Cloud Trace |

**4.Diagrama: ver `diagramas/arquitetura-qc-aula01.png`.**

---

### Exercício 2.2 — Comparativo de custos: 3 provedores

```text
Você precisa recomendar infraestrutura para um projeto de AI Engineering. Use as calculadoras para comparar:

- 2 VMs com 2 vCPUs e 8 GB RAM (Linux, 24/7)
- 500 GB de object storage
- 1 banco gerenciado com 2 vCPUs / 8 GB RAM / 100 GB
- 10 milhões de requisições/mês para função serverless
```

Escopo: 2 VMs (2 vCPU/8GB, Linux, 24/7) + 500 GB object storage + 1 banco gerenciado (2 vCPU/8GB/100GB) + 10M requisições/mês serverless.

| Item | Azure | AWS | GCP | Notas |
|------|-------|-----|-----|-------|
| 2 × VM (2vCPU/8GB) | ~US$ 140/mês | ~US$ 135/mês | ~US$ 110/mês | Tipo: D2s_v3 · t3.large · e2-standard-2 |
| 500 GB storage | ~US$ 10/mês | ~US$ 11,50/mês | ~US$ 10/mês | Tier hot/standard |
| Banco gerenciado | ~US$ 220/mês | ~US$ 240/mês | ~US$ 200/mês | Azure SQL GP · RDS/Aurora · Cloud SQL |
| 10M req serverless | ~US$ 5/mês | ~US$ 4/mês | ~US$ 4/mês | Azure Functions · Lambda · Cloud Functions |
| **Total mensal** | **~US$ 375** | **~US$ 390** | **~US$ 324** | |
| **Total anual** | **~US$ 4.500** | **~US$ 4.680** | **~US$ 3.890** | |

**a) Provedor mais barato?**
Nas estimativas, o GCP fica ligeiramente mais barato, mas a diferença (~13% frente à Azure, ~17% frente à AWS) não é grande o suficiente para, sozinha, decidir o provedor de uma plataforma de IA — outros fatores pesam mais (ver item c).

**b) Reserved Instances de 1 ano no mais caro (AWS):**
RIs de 1 ano tipicamente cortam 30-40% do custo de compute. Aplicando isso só na fatia de VM da AWS (~US$ 135 → ~US$ 85/mês), o total mensal da AWS cairia para perto de US$ 340 — ficando competitivo com Azure e mais próximo do GCP. Ou seja, o resultado muda bastante quando se considera compromisso de longo prazo, o que reforça que list price isolado é um comparativo incompleto.

**c) Outros fatores além de preço:**
- Maturidade e integração nativa do serviço de LLM (Azure OpenAI vs. Bedrock vs. Vertex AI) com o resto da stack.
- Latência e presença de região nos 12 países onde a QC opera.
- Qualidade e granularidade do RBAC/IAM para dar acesso mínimo a agentes de IA.
- Custo de egress entre provedores, caso a arquitetura evolua para multi-cloud (ver Exercício 3.3).
- Suporte, SLA contratual e maturidade de ferramentas de observabilidade para debugar agentes em produção.

---

### Exercício 2.3 — Estratégia de migração

```text
Pense no seu contexto profissional atual (ou empresa que conhece bem).

a) Descreva um sistema/workload (sem dados confidenciais — pode ser genérico) 
b) Qual dos 6 Rs você aplicaria? Justifique custo, risco, ganho, prazo 
c) Que serviço Azure usaria? Estimativa mensal? 
d) Maior obstáculo técnico ou organizacional? Como endereçaria?
```

**a) Sistema:** aplicação interna de emissão e conciliação de notas fiscais, rodando em servidor físico on-premise, atendendo o time financeiro.

**b) R aplicado:** **Rehost** como primeiro passo, com **Replatform** planejado em 6-12 meses. Justificativa: o sistema é crítico (compliance fiscal) e o time não pode correr risco de reescrevê-lo do zero sem tempo de validação; Rehost reduz risco imediato de hardware físico obsoleto (custo de manutenção, falta de redundância) a um custo de migração baixo. Replatform depois, migrando o banco para um serviço gerenciado, isso reduz o trabalho operacional sem reescrever a lógica de negócio.

**c) Serviço Azure e estimativa mensal:** Azure VM (2 vCPU/8GB, similar ao D2s_v3) + Azure SQL Database Standard para o banco. Estimativa: ~US$ 150-200/mês, bem abaixo do custo de manter o servidor físico com redundância própria.

**d) Maior obstáculo:** organizacional. O time financeiro tem baixa tolerância a qualquer indisponibilidade durante a janela fiscal de fechamento de mês. Endereçamento: migração em ambiente paralelo (blue/green), com janela de corte fora do período crítico de fechamento e um plano de rollback testado antes do go-live.

---

---

## 🔴 Nível 3 — Bônus — Avançado: IaC e Automação

---

### Exercício 3.1 — Terraform: endurecer a segurança de rede da VM

```text
Exercício 3.1 — Terraform: endurecer a segurança de rede da VM
Tudo no Cloud Shell — sem instalação.

O main.tf do lab (Atividade 5) já provisiona a VM com VNet + NSG, mas o NSG vem do portal com a regra SSH liberada para qualquer origem (*) — uma má prática. Modifique o código do lab para deixá-lo mais seguro:

Restrinja o SSH (porta 22) para aceitar conexões apenas do seu IP público (curl ifconfig.me no Cloud Shell para obter). Use uma variável meu_ip em vez de hardcode.
Adicione uma segunda subnet chamada subnet-app com 10.0.2.0/24 na mesma VNet, pensando em isolar a futura camada de aplicação da QC.
Adicione um output que exponha apenas o IP público da VM (já existe public_ip_address — confirme que aparece após o apply).
Rode terraform plan e identifique no diff exatamente qual regra do NSG mudou (não deve recriar a VM).
```

Alterações aplicadas em `terraform/` (arquivos completos no ZIP):

1. **SSH restrito ao IP do grupo** — a regra `SSH` do NSG deixou de usar `source_address_prefix = "*"` e passou a usar `"${var.meu_ip}/32"`. A variável `meu_ip` foi adicionada em `variables.tf` **sem valor default**, forçando quem for aplicar a informar o próprio IP (obtido com `curl ifconfig.me` no Cloud Shell) — isso evita reintroduzir a má prática por esquecimento.
2. **Segunda subnet `subnet-app`** — adicionada em `10.0.2.0/24`, na mesma VNet (`10.0.0.0/16`), isolando a futura camada de aplicação da QC da subnet `default` onde vive a VM de referência.
3. **Output do IP público** — `outputs.tf` expõe `public_ip_address` (`azurerm_public_ip.pip.ip_address`), visível via `terraform output public_ip_address` após o `apply`.
4. **`terraform plan` esperado:** como nenhum recurso mudou de `name`, tipo ou depende de "force replacement" (a alteração é só no valor de `source_address_prefix` da regra SSH, e a subnet nova é um recurso adicional, não uma modificação de recurso existente), o plano deve mostrar `~ update in-place` no NSG e `+ create` na `azurerm_subnet.app` — **a VM não é recriada**.

```bash
export TF_VAR_meu_ip=$(curl -s ifconfig.me)
terraform plan
terraform apply
terraform output public_ip_address
terraform destroy
```

---

### Exercício 3.2 — Bicep equivalente


```text
Pegue o main.tf do lab (a VM + rede) e traduza para Bicep — ou parta do template.json em aulas/01-fundamentos-iac/template/ e decompile.

Tudo no Cloud Shell — bicep já está instalado.

1. Crie main.bicep em ~/aula01-bicep/ (ou gere com bicep decompile template.json --outfile main.bicep)

2. Implemente os mesmos recursos do lab (RG + VNet + Subnet + NSG + IP + NIC + VM Linux Ubuntu 24.04)

3. Faça deploy com:
```
```terraform
# Bicep precisa do RG já existente OU usar subscription scope
az group create --name rg-bicep-aula01 --location eastus2

az deployment group create \
  --resource-group rg-bicep-aula01 \
  --template-file main.bicep \
  --parameters adminPublicKey="$(cat ~/.ssh/id_rsa.pub)"
  ```
```text
4. Compare os três artefatos lado a lado e responda no README do grupo:

- Quantas linhas tem cada arquivo (template.json ARM × main.tf Terraform × main.bicep)?
- Qual ficou mais legível para você?
- Em que cenário você escolheria Bicep sobre Terraform?

5. Não esqueça: az group delete --name rg-bicep-aula01 --yes --no-wait ao final.

```

`bicep/main.bicep` traduz manualmente os mesmos recursos do `main.tf`

Comparação solicitada no item 4:

| Artefato | Linhas aproximadas | Observação |
|---|---|---|
| `main.tf` (Terraform) | ~160 | Sintaxe HCL, blocos `resource` explícitos |
| `main.bicep` | ~190 | Um pouco mais verboso por declarar `properties` aninhadas explicitamente |
| `template.json` (ARM) | não disponível nesta aula | — |

- **Mais legível:** o grupo considerou o Terraform ligeiramente mais legível pela sintaxe HCL mais enxuta, mas o Bicep venceu em previsibilidade de tipos (autocomplete forte no VS Code).
- **Quando escolher Bicep sobre Terraform:** em ambientes 100% Azure, sem necessidade de multi-cloud, onde vale a pena abrir mão da portabilidade do Terraform em troca de integração nativa com Azure Resource Manager (sem provider, sem state file externo a gerenciar).

```bash
az group create --name rg-bicep-aula01 --location eastus2
az deployment group create \
  --resource-group rg-bicep-aula01 \
  --template-file main.bicep \
  --parameters adminPublicKey="$(cat ~/.ssh/id_rsa.pub)" meuIp="$(curl -s ifconfig.me)"
az group delete --name rg-bicep-aula01 --yes --no-wait
```

---

### Exercício 3.3 — Desafio de arquitetura: multi-cloud para a Quantum Commerce

```text
Contexto: O CTO da QC quer evitar lock-in e pediu análise multi-cloud.

a) Desenhe uma arquitetura multi-cloud com pelo menos 2 provedores. Justifique por que cada workload em cada nuvem.

b) Identifique 4 desafios principais: latência entre nuvens, identidade unificada, custos de egress, observabilidade.

c) Compare 2 ferramentas IaC multi-cloud:

Terraform (HashiCorp) — https://www.terraform.io
Pulumi — https://www.pulumi.com
Para cada: linguagem, pricing, suporte aos 3 grandes, quando escolher.

d) Estime custo de egress: 10 TB/mês entre Azure (Brazil South) e AWS (us-east-1). Consulte tabelas de preço e calcule.
```

**a) Arquitetura multi-cloud proposta:** manter Azure como provedor principal (compute, dados, orquestração de agentes, Azure OpenAI) e usar GCP especificamente para BigQuery/Vertex AI em cargas de **analytics e treinamento de modelos de recomendação em lote**, onde o custo de compute do GCP tende a ser mais competitivo e o BigQuery tem vantagem em consultas analíticas de grande volume sobre o histórico de 5M SKUs × 12 países.

**b) Quatro desafios principais:**
- **Latência entre nuvens:** todo pipeline de dados que atravessa Azure↔GCP adiciona round-trips; mitigar com replicação assíncrona/batch em vez de chamadas síncronas cross-cloud.
- **Identidade unificada:** sem um único IdP, cada nuvem tem seu próprio RBAC; requer federação (ex.: Azure AD como IdP central, federado via OIDC para o GCP) para não duplicar gestão de identidade de agentes.
- **Custo de egress:** tráfego saindo de uma nuvem para outra é cobrado (ver item d). Arquitetura precisa minimizar volume trafegado entre provedores.
- **Observabilidade:** métricas e logs ficam fragmentados entre Azure Monitor e Cloud Monitoring; precisa de uma camada de agregação (ex.: um coletor OpenTelemetry central) para não perder visibilidade ponta a ponta.

**c) Terraform vs. Pulumi:**

| | Terraform | Pulumi |
|---|---|---|
| Linguagem | HCL (DSL própria) | Linguagens de propósito geral (TypeScript, Python, Go, C#) |
| Pricing | Gratuito (open source) / Terraform Cloud pago para times | Gratuito para individual; planos pagos para times |
| Suporte aos 3 grandes | Excelente, providers maduros para Azure/AWS/GCP | Excelente, usa os mesmos providers via bridge |
| Quando escolher | Time já domina HCL; quer o ecossistema de módulos mais maduro do mercado | Time já é forte em uma linguagem de programação e quer reaproveitar lógica de programação (loops, testes unitários) na própria IaC |

**d) Estimativa de egress: 10 TB/mês Azure (Brazil South) → AWS (us-east-1):**
Egress inter-cloud costuma ficar na faixa de USD 0,08-0,12/GB nos primeiros TBs, caindo por faixas de volume. Para 10.000 GB/mês a ~USD 0,09/GB (estimativa ilustrativa, confirmar na tabela oficial de bandwidth da Azure): **≈ USD 900/mês** só de egress — valor que deve ser confrontado com o ganho de usar dois provedores antes de justificar a arquitetura multi-cloud.

**Azure Arc / AWS Outposts na QC:** ambos permitiriam operar cargas locais (ex.: em um país com exigência de residência de dados) sob o mesmo plano de controle da nuvem principal, reduzindo a fragmentação de gestão que uma arquitetura multi-cloud "pura" traria. Um caminho intermediário entre ficar 100% em uma nuvem e operar em nuvens totalmente distintas.

---

## Reflexão coletiva

O aprendizado mais importante desta aula foi perceber que os 3 níveis de exercício não são compartimentos isolados. Eles formam uma cadeia de decisão. A escolha de modelo de serviço e de estratégia de migração só se sustenta se a infraestrutura por trás for reprodutível e auditável. Isso ficou concreto no Exercício 3.1: uma regra de NSG liberada para `*` parece um detalhe pequeno no portal, mas vira um risco sério quando multiplicado pelos 12 países e 5M SKUs da Quantum Commerce.

Essa cadeia se conecta diretamente com uma arquitetura agentic. Um agente de IA que consulta o Storage de produtos (Exercício 1.4) só é seguro se a role atribuída a ele for a mínima necessária — e essa role só existe de forma confiável se for definida em código versionado (Terraform/Bicep), não clicada manualmente no portal por alguém que pode esquecer de revisar depois. Do mesmo modo, reprodutibilidade de agentes exige que segredos (chaves de API, connection strings) nunca fiquem hardcoded — o mesmo princípio do `.gitignore` que impede `terraform.tfstate` de vazar se aplica a qualquer credencial que um agente vá usar em produção.

Se o grupo estivesse começando o projeto QC hoje, a maior mudança seria decidir a estratégia multi-cloud (ou a decisão consciente de não fazer multi-cloud) já na Aula 1, em vez de tratá-la como bônus do Nível 3. O comparativo de custos do Exercício 2.2 mostrou que a diferença de preço entre provedores é pequena demais para justificar sozinha ficar preso a um único fornecedor, mas o custo de egress do Exercício 3.3 mostra que multi-cloud também não é gratuito. Nomear esse trade-off cedo evita retrabalho de arquitetura nas aulas seguintes.

---

## Artefatos do ZIP

- Diagrama: `diagramas/arquitetura-qc-aula01.png`
- Código IaC (Terraform): `terraform/`
- Código IaC (Bicep, bônus): `bicep/`
