import { LightningElement, api, wire, track } from 'lwc';
import getAttendees from '@salesforce/apex/AttendeesTableController.getAttendees';
import LOCATION from '@salesforce/schema/Event__c.Location__r.Name';

// const COLUMNS = [
//     {label:'Attendee Name', fieldName:'Name'},
//     {label:'Phone', fieldName:'Phone__c', type:'phone'},
//     {label:'Email', fieldName:'Email__c', type:'email'},
//     {label:'Location', fieldName:'Loocation__r.Name'}
// ];

const COLUMNS = [
    
    { label: 'Account Id', fieldName: 'Attendee_Name', type: 'text' },
    { label: 'Account Name', fieldName: 'Attendee_Phone', type: 'text' },
    { label: 'Contact Id', fieldName: 'Attendee_Email', type: 'text' },
    { label: 'Contact Title', fieldName: 'Attendee_Location', type: 'text' }
];

export default class AttendeesTable extends LightningElement {
    
    @track refreshTable;
    @track attendees;
    @api recordId;
    
    tableData;
    @api columns = COLUMNS;
    // @wire(getAttendees,{recordId: '$recordId'})
    
    // speakersHandler({data, error}){
    //     //console.log(JSON.stringify(data));
    //     if(data){
    //         console.log(this.recordId);
    //         this.tableData = data;
    //         data.forEach(attendee => {
    //             attendee.locationnName = attendee.Location__r.Name;
    //             console.log(attendee);
    //         });
    //     }
    //     if(error){
    //         console.error(error);
    //     }
    // }

    @wire(getAttendees, { recordId: '$recordId' }) wired(result) {
        this.refreshTable = result;
        if (result.data) {
            this.attendees = result.data.map(
                Attendee_Name =       Attendee_r.Name,
                Attendee_Phone =      Attendee_r.Phone__c,
                Attendee_Email =      Attendee_r.Email__c,
                Attendee_Location =   Attendee_r.Location__r.Name);
            // let preparedAttendees = [];
            // result.data.forEach(attendee => {
            //     let preparedAttendees = {};
            //     preparedAttendees.Attendee_Name =       attendee.Name;
            //     preparedAttendees.Attendee_Phone =      attendee.Phone__c;
            //     preparedAttendees.Attendee_Email =      attendee.Email__c;
            //     preparedAttendees.Attendee_Location =   attendee.Location__c.Name;
            //     // and so on for other fields
            //     preparedAttendees.push(preparedAttendees);
            // });
            // this.attendees = preparedAttendees;
            console.log(attendees);
            }
        
        if (result.error) {
            this.error = result.error;
        }
    }
}