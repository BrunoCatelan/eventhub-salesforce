# LeadGenius 🚀

O **LeadGenius** é uma solução inteligente e automatizada de distribuição de Leads desenvolvida para a plataforma Salesforce. Utilizando uma arquitetura orientada a gatilhos (Triggers) e o banco de dados da plataforma, o sistema implementa um algoritmo de **Round-Robin (Fila da Vez)** para garantir que os Leads entrantes sejam distribuídos de forma justa e uniforme entre os vendedores ativos.

## 🛠️ Arquitetura e Componentes

O projeto foi construído seguindo as melhores práticas de desenvolvimento Apex, separando a execução do gatilho da lógica de negócio (*Trigger Handler Pattern*):

*   **`Configuracao_Equipe__c` (Custom Object):** Tabela que gerencia os vendedores aptos a receberem leads, controlando quem está ativo e registrando o carimbo de data/hora da última atribuição.
*   **`LeadTrigger` (Apex Trigger):** Atua como um sensor no evento `before insert` do objeto Lead, interceptando novos registros antes de serem salvos no banco de dados.
*   **`LeadTriggerHandler` (Apex Class):** Classe responsável pela inteligência do negócio. Realiza consultas SOQL otimizadas para identificar o vendedor ideal e atualiza a fila dinamicamente.

## ⚙️ Funcionamento da Lógica (Round-Robin)

1. Um novo Lead é inserido no Salesforce.
2. A `LeadTrigger` é disparada e delega a lista de registros para o método `distribuirLeads`.
3. O sistema executa uma query SOQL buscando o vendedor que possui o menor valor (ou valor nulo) no campo `Ultima_Atribuicao__c`:
```soql
   SELECT Id, Vendedor__c 
   FROM Configuracao_Equipe__c 
   WHERE Ativo__c = true 
   ORDER BY Ultima_Atribuicao__c ASC NULLS FIRST 
   LIMIT 1
4. O proprietário do Lead (OwnerId) é atualizado com o ID do vendedor encontrado.

5. O registro do vendedor tem seu campo Ultima_Atribuicao__c atualizado com o System.now(), movendo-o automaticamente para o final da fila.

🚀 Tecnologias Utilizadas
Salesforce Apex

SOQL (Salesforce Object Query Language)

Salesforce CLI (sf)

Visual Studio Code

   ---

_Desenvolvido por **Bruno Catelan**. Projeto construído com fins de estudo e portfólio para a stack de engenharia Salesforce._