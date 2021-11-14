import { LightningElement, api, wire } from 'lwc';
import getSpeakers from '@salesforce/apex/speakersTableController.getSpeakers';

const COLUMNS = [
    {label:'Speaker Name', fieldName:'Name'},
    {label:'Phone', fieldName:'Phone__c', type:'phone'},
    {label:'Email', fieldName:'Email__c', type:'email'},
    {label:'Company', fieldName:'Company__c'}
];

export default class SpeakersTable extends LightningElement {

    @api recordId;
    
    tableData;
    @api columns = COLUMNS;
    @wire(getSpeakers,{recordId: '$recordId'})
    speakersHandler({data, error}){
        console.log(data);
        if(data){
            console.log(this.recordId);
            this.tableData = data;
            
        }
        if(error){
            console.error(error);
        }
    }
}