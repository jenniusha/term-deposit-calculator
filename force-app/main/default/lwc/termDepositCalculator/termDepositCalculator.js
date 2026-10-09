import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import calculate from '@salesforce/apex/TermDepositCalculatorController.calculate';

export default class TermDepositCalculator extends LightningElement {
    // ✅ Reactive tracked properties for user inputs and results
        startAmount;
        interestRate;
        termYears;
        interestFrequency = 'maturity';
        result;


    // ✅ Error message holders for each field
        startAmountError;
        interestRateError;
        termYearsError;

    // ✅ Dropdown options for interest frequency
    get frequencyOptions() {
        return [
            { label: 'Monthly', value: 'monthly' },
            { label: 'Quarterly', value: 'quarterly' },
            { label: 'Annually', value: 'annually' },
            { label: 'At Maturity', value: 'maturity' }
        ];
    }

    // ✅ Handle input changes
    // Uses the "name" attribute to map values to properties
    // Clears error messages when user starts typing again
    handleChange(event) {
        const field = event.target.name;
        this[field] = event.target.value;

        if (field === 'startAmount') this.startAmountError = null;
        if (field === 'interestRate') this.interestRateError = null;
        if (field === 'termYears') this.termYearsError = null;
    }

    // ✅ Client-side validation
    // Ensures all required fields are filled and > 0
    validateInputs() {
        let isValid = true;

        if (!this.startAmount || this.startAmount <= 0) {
            this.startAmountError = 'Start Deposit Amount is required and must be > 0.';
            isValid = false;
        }
        if (!this.interestRate || this.interestRate <= 0) {
            this.interestRateError = 'Interest Rate is required and must be > 0.';
            isValid = false;
        }
        if (!this.termYears || this.termYears <= 0) {
            this.termYearsError = 'Investment Term (Years) is required and must be > 0.';
            isValid = false;
        }

        return isValid;
    }

    // ✅ Main calculation method
    // - Validates inputs
    // - Shows toast if validation fails
    // - Calls Apex if inputs are valid
    // - Shows success or error toast based on response
    calculate() {
        if (!this.validateInputs()) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Validation Error',
                    message: 'Please fix the errors above before calculating.',
                    variant: 'error'
                })
            );
            return;
        }

        // Clear previous errors before calling Apex
        this.startAmountError = null;
        this.interestRateError = null;
        this.termYearsError = null;

        // ✅ Call Apex method with parsed inputs
        calculate({
            input: {
                startAmount: parseFloat(this.startAmount),
                interestRate: parseFloat(this.interestRate),
                termYears: parseFloat(this.termYears),
                interestFrequency: this.interestFrequency
            }
        })
        .then(result => {
            this.result = result;

            // ✅ Show success toast with final balance
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Calculation Successful',
                    message: 'Final Balance: ' + result.finalBalance,
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            // ✅ Show error toast if Apex call fails
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Server Error',
                    message: error.body ? error.body.message : 'Unknown error',
                    variant: 'error'
                })
            );
        });
    }
}
