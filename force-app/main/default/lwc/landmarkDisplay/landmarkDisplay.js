import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import STREET from '@salesforce/schema/Event__c.Location__r.Street__c';
import CITY from '@salesforce/schema/Event__c.Location__r.City__c';
import COUNTRY from '@salesforce/schema/Event__c.Location__r.Country__c';
import STATE from '@salesforce/schema/Event__c.Location__r.State__c';
import POSTAL from '@salesforce/schema/Event__c.Location__r.Postal_Code__c';

export default class WireGetRecordDynamicLocation extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [STREET, CITY, COUNTRY, STATE, POSTAL] })
    location;

    get street() {
        return getFieldValue(this.location.data,STREET);
    }

    get city() {
        return getFieldValue(this.location.data,CITY);
    }

    get country() {
        return getFieldValue(this.location.data,COUNTRY);
    }

    get state() {
        return getFieldValue(this.location.data,STATE);
    }

    get postal() {
        return getFieldValue(this.location.data,POSTAL);
    } 
}