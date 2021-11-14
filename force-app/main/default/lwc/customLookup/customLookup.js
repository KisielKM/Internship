import { LightningElement, api } from 'lwc';

export default class CustomLookup extends LightningElement {
    @api childObjectApiName = 'Event__c'; //Contact is the default value
    @api targetFieldApiName = 'Event_Organizer__c'; //AccountId is the default value
    @api fieldLabel = 'Your field label here';
    @api disabled = false;
    @api value;
    @api required = false;

    // handleChange(event) {
    //     // Creates the event
    //     const selectedEvent = new CustomEvent('valueselected');
    //     //dispatching the custom event
    //     this.dispatchEvent(selectedEvent);
    // }

    // @api isValid() {
    //     if (this.required) {
    //         this.template.querySelector('lightning-input-field').reportValidity();
    //     }
    // }
}