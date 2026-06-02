# Meu Portfólio de Desenvolvimento Salesforce 🚀

Bem-vindo ao meu repositório de soluções e engenharia na plataforma Salesforce. Este espaço reúne projetos práticos focados em arquitetura robusta, automações performáticas (Apex/Triggers), integrações modernas e interfaces reativas (LWC), seguindo as melhores práticas do mercado.

---

## 📁 Projetos Contidos Neste Repositório

### 1. [EventHub — Gerenciador Corporativo de Eventos 📅](#-projeto-1-eventhub-salesforce-mvp-)
* Sistema de gerenciamento de eventos com controle dinâmico de lotação em tempo real. Mescla automações declarativas com validações programáticas (Triggers) bulkificadas e interface reativa em LWC.
* ✨ **Módulo Adicional:** [FinTrack — Integração Financeira Internacional](./FinTrack/)

### 2. [LeadGenius — Distribuidor Inteligente de Leads 🎯](./LeadGenius/)
* Solução de distribuição de leads por fila (Round-Robin) utilizando Apex Triggers e o padrão de arquitetura *Trigger Handler Pattern*. Garantia de distribuição justa e uniforme para equipes de vendas.
* 👉 [Acessar documentação completa do LeadGenius](./LeadGenius/)

---

## 📦 Projeto 1: EventHub — Salesforce MVP 🚀

O **EventHub** é um sistema MVP desenvolvido nativamente na plataforma Salesforce para solucionar o gerenciamento corporativo de eventos, automação de inscrições e controle dinâmico de lotação de vagas em tempo real.

O projeto destaca-se por mesclar de forma equilibrada as melhores práticas de desenvolvimento **Declarativo (No-Code)** e **Programático (Pro-Code)**, utilizando o padrão moderno Salesforce DX.

### 🛠️ Tecnologias e Arquitetura Utilizadas

| Camada | Tecnologia | Propósito no EventHub |
| :--- | :--- | :--- |
| **Modelagem de Dados** | Objetos Personalizados e Relacionamento Master-Detail | Ligação forte entre `Evento__c` (Pai) e `Inscricao__c` (Filho), garantindo integridade referencial. |
| **Automação Sem Código** | Campo de Resumo Acumulado (Roll-up Summary) | Cálculo em tempo real do campo `Total_Inscritos__c` no objeto pai, otimizando a performance. |
| **Lógica Back-End** | Gatilho Apex (`before insert`) | Validação síncrona para barrar inscrições quando o limite de vagas for atingido, aplicando padrões de **Bulkificação**. |
| **Garantia de Qualidade** | Classes de Teste Apex | Validação de cenários positivos e negativos, atingindo 100% de cobertura de código (*Code Coverage*). |
| **Camada Front-End** | Lightning Web Components (LWC) | Interface reativa moderna com feedback visual imediato para o usuário final sobre o status das vagas. |
| **Extensão Financeira** | Record-Triggered Flow & Invocable Apex | Módulo **FinTrack**: Processamento assíncrono para conversão de moedas estrangeiras. |

### 🧠 Detalhes do Código e Implementação

#### 1. Gatilho Apex Bulkificado (`before insert`)
O gatilho foi projetado para analisar registros em lote de forma performática, mapeando coleções de dados (`Set` e `Map`) e evitando o consumo indevido de limites governamentais (como queries SOQL ou comandos DML dentro de loops).

#### 2. Qualidade de Código (Testes Automatizados)
A classe `InscricaoTriggerTest` simula comportamentos do banco de dados, garantindo que o sistema responda com sucesso sob condições normais e lance erros controlados em cenários de superlotação de eventos.
* **Taxa de aprovação:** 100%
* **Cobertura de código:** 100%

#### 3. Componente Visual Reativo (LWC)
O componente de frontend utiliza o decorador `@wire` e o serviço de dados nativo do Salesforce (`lightning/uiRecordApi`) para renderizar badges visuais com base no status do evento:
* 🟢 **VAGAS DISPONÍVEIS:** Quando o evento possui margem para novos participantes.
* 🔴 **EVENTO LOTADO:** Quando o limite do Roll-up atinge o teto estipulado.

#### 4. 🔥 Módulo FinTrack (Extensão de Moedas)
Para habilitar o suporte a eventos internacionais no EventHub, foi implementado o módulo **FinTrack**, que intercepta registros criados com moedas estrangeiras e injeta as cotações via Apex de maneira assíncrona, protegendo os limites de execução da Org.
* 👉 [Acessar documentação completa do FinTrack](./FinTrack/)

### 📁 Estrutura do Repositório (SFDX)

    force-app/main/default/
    ├── classes/
    │   ├── InscricaoTriggerTest.cls
    │   ├── InscricaoTriggerTest.cls-meta.xml
    │   ├── FinTrackService.cls
    │   └── FinTrackService.cls-meta.xml
    ├── lwc/
    │   └── eventStatus/
    │       ├── eventStatus.html
    │       ├── eventStatus.js
    │       ├── eventStatus.css
    │       └── eventStatus.js-meta.xml
    ├── objects/
    │   └── Evento__c/
    │       └── fields/
    │           ├── Total_Inscritos__c.field-meta.xml
    │           ├── Moeda__c.field-meta.xml
    │           └── Cotacao_Aplicada__c.field-meta.xml
    └── triggers/
        ├── InscricaoTrigger.trigger
        └── InscricaoTrigger.trigger-meta.xml

---

_Desenvolvido por **Bruno Catelan**. Repositório construído com fins de estudo, evolução técnica e portfólio para a stack de engenharia Salesforce._