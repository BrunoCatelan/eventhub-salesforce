import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

// Importando as referências dos campos
import VAGAS_MAX_FIELD from '@salesforce/schema/Evento__c.Vagas_Maximas__c';
import TOTAL_INSCRITOS_FIELD from '@salesforce/schema/Evento__c.Total_Inscritos__c';

const FIELDS = [VAGAS_MAX_FIELD, TOTAL_INSCRITOS_FIELD];

export default class EventStatus extends LightningElement {
    @api recordId; // O Salesforce preenche isso automaticamente com o ID do Evento atual

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    evento;

    get vagasMaximas() {
        return getFieldValue(this.evento.data, VAGAS_MAX_FIELD);
    }

    get totalInscritos() {
        return getFieldValue(this.evento.data, TOTAL_INSCRITOS_FIELD);
    }

    // Lógica para decidir se está lotado
    get isFull() {
        if (this.vagasMaximas && this.totalInscritos != null) {
            return this.totalInscritos >= this.vagasMaximas;
        }
        return false;
    }

    get error() {
        return this.evento.error;
    }
}