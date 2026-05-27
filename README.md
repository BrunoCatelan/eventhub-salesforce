# EventHub — Salesforce MVP 🚀



O **EventHub** é um sistema MVP desenvolvido nativamente na plataforma Salesforce para solucionar o gerenciamento corporativo de eventos, automação de inscrições e controle dinâmico de lotação de vagas em tempo real.



O projeto destaca-se por mesclar de forma equilibrada as melhores práticas de desenvolvimento **Declarativo (No-Code)** e **Programático (Pro-Code)**, utilizando o padrão moderno Salesforce DX.



---



## 🛠️ Tecnologias e Arquitetura Utilizadas



| Camada | Tecnologia | Propósito no EventHub |

| :--- | :--- | :--- |

| **Modelagem de Dados** | Custom Objects & Relacionamento Master-Detail | Ligação forte entre `Evento__c` (Pai) e `Inscricao__c` (Filho), garantindo integridade dos dados. |

| **Automação No-Code** | Roll-up Summary | Cálculo em tempo real do campo `Total_Inscritos__c` no objeto pai, otimizando performance. |

| **Lógica Back-End** | Apex Trigger (`before insert`) | Validação síncrona para barrar inscrições quando o limite de vagas é atingido, aplicando padrões de **Bulkificação**. |

| **Garantia de Qualidade** | Classes de Teste Apex | Validação automatizada atingindo **100% de cobertura de código** (Code Coverage). |

| **Camada Front-End** | Lightning Web Components (LWC) | Interface reativa moderna com feedback visual imediato para o usuário final. |



---



## 🧠 Detalhes de Código



### 1. Apex Trigger Bulkificada (`before insert`)

A trigger foi desenhada para processar registros em lote de forma performática, mapeando coleções de dados (`Set` e `Map`) e evitando o consumo indevido de limites governamentais (como queries SOQL dentro de loops).



### 2. Qualidade de Código (Testes Automatizados)

A classe `InscricaoTriggerTest` simula comportamentos do banco de dados, garantindo que o sistema responda com sucesso sob condições normais e lance erros controlados em cenários de superlotação.

* **Taxa de aprovação:** 100%

* **Cobertura de código:** 100%



### 3. Componente Visual Reativo (LWC)

O componente frontend utiliza o decorator `@wire` e o serviço de dados nativo do Salesforce (`lightning/uiRecordApi`) para renderizar badges dinâmicos:

* 🟢 **VAGAS DISPONÍVEIS:** Quando o evento possui margem para novos participantes.

* 🔴 **EVENTO LOTADO:** Quando o limite do Roll-up atinge o teto estipulado.



---



## 📁 Estrutura do Repositório (SFDX)



```text

force-app/main/default/

├── classes/

│   ├── InscricaoTriggerTest.cls

│   └── InscricaoTriggerTest.cls-meta.xml

├── lwc/

│   └── eventStatus/

│       ├── eventStatus.html

│       ├── eventStatus.js

│       ├── eventStatus.css

│       └── eventStatus.js-meta.xml

├── objects/

│   └── Evento__c/

│       └── fields/

│           └── Total_Inscritos__c.field-meta.xml

└── triggers/

    ├── InscricaoTrigger.trigger

    └── InscricaoTrigger.trigger-meta.xml





---

_Desenvolvido por **Bruno Catelan**. Projeto construído com fins de estudo e portfólio para a stack de engenharia Salesforce._