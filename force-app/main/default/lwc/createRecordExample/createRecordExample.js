import { LightningElement, track } from "lwc";

import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { createRecord } from "lightning/uiRecordApi";
import { reduceErrors } from "c/ldsUtils";
import {NavigationMixin} from "lightning/navigation";

import EVENT__C_OBJECT from "@salesforce/schema/Event__c";

export default class CreateRecordExample extends NavigationMixin(LightningElement) {
    eventRecord = {};
    isLoading = false;

    handleChange(event) {
        this.eventRecord[event.target.name] = event.target.value;
    }

    handleChangeForLookup(event) {
        this.eventRecord[event.target.name] = event.detail.value[0];
    }

    createEvent() {
        this.isLoading = true;
        const fields = this.eventRecord;

        const recordInput = { apiName: EVENT__C_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then((account) => {
                this.accountId = account.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success",
                        message: "Event created successfully!",
                        variant: "success"
                    })
                );
                
                this.eventRecord = {};
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: account.id,
                        objectApiName: 'Event__c', // objectApiName is optional
                        actionName: 'view'
                    }
                });
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error creating record",
                        message: reduceErrors(error).join(", "),
                        variant: "error"
                    })
                );
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}