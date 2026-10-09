/**
 * Developer: Usha Jennifer A
 * Created Date: 09-Oct-2026
 * Description: Unit test class for TermDepositCalculatorController.
 *              Validates calculation logic for different interest frequencies,
 *              ensures error handling for invalid inputs and unexpected scenarios.
 */

@IsTest
private class TermDepositCalculatorControllerTest {
    
    /**
     * Test simple interest calculation at maturity.
     * Expects final balance > principal and success message.
     */
    @IsTest
    static void testValidMaturityCalculation() {
        TermDepositCalculatorController.CalculatorInput input = new TermDepositCalculatorController.CalculatorInput();
        input.startAmount = 10000;
        input.interestRate = 1.10;
        input.termYears = 3;
        input.interestFrequency = 'maturity';
        
        TermDepositCalculatorController.CalculatorOutput result = TermDepositCalculatorController.calculate(input);
        
        System.assert(result.finalBalance > 10000, 'Final balance should be greater than principal');
        System.assertEquals('Calculation successful.', result.message);
    }
    
    /**
     * Test compound interest calculation with monthly frequency.
     * Expects final balance > principal and success message.
     */
    @IsTest
    static void testValidMonthlyCompoundCalculation() {
        TermDepositCalculatorController.CalculatorInput input = new TermDepositCalculatorController.CalculatorInput();
        input.startAmount = 5000;
        input.interestRate = 2.0;
        input.termYears = 2; // 2 years
        input.interestFrequency = 'monthly';
        
        TermDepositCalculatorController.CalculatorOutput result = TermDepositCalculatorController.calculate(input);
        
        System.assert(result.finalBalance > 5000, 'Final balance should be greater than principal');
        System.assertEquals('Calculation successful.', result.message);
    }
    
    /**
     * Test compound interest calculation with quarterly frequency.
     * Uses fractional years to validate precision.
     */
    @IsTest
    static void testValidQuarterlyCompoundCalculation() {
        TermDepositCalculatorController.CalculatorInput input = new TermDepositCalculatorController.CalculatorInput();
        input.startAmount = 8000;
        input.interestRate = 1.5;
        input.termYears = 1.5; // fractional years
        input.interestFrequency = 'quarterly';
        
        TermDepositCalculatorController.CalculatorOutput result = TermDepositCalculatorController.calculate(input);
        
        System.assert(result.finalBalance > 8000, 'Final balance should be greater than principal');
        System.assertEquals('Calculation successful.', result.message);
    }
    
    /**
     * Test compound interest calculation with annual frequency.
     * Expects final balance > principal and success message.
     */
    @IsTest
    static void testValidAnnualCompoundCalculation() {
        TermDepositCalculatorController.CalculatorInput input = new TermDepositCalculatorController.CalculatorInput();
        input.startAmount = 12000;
        input.interestRate = 1.25;
        input.termYears = 5;
        input.interestFrequency = 'annually';
        
        TermDepositCalculatorController.CalculatorOutput result = TermDepositCalculatorController.calculate(input);
        
        System.assert(result.finalBalance > 12000, 'Final balance should be greater than principal');
        System.assertEquals('Calculation successful.', result.message);
    }
    
    /**
     * Test invalid frequency handling.
     * Expects final balance = 0 and error message.
     */
    @IsTest
    static void testInvalidFrequency() {
        TermDepositCalculatorController.CalculatorInput input = new TermDepositCalculatorController.CalculatorInput();
        input.startAmount = 10000;
        input.interestRate = 1.10;
        input.termYears = 3;
        input.interestFrequency = 'weekly'; // unsupported
        
        TermDepositCalculatorController.CalculatorOutput result = TermDepositCalculatorController.calculate(input);
        
        System.assertEquals(0, result.finalBalance);
        System.assertEquals('Invalid interest frequency.', result.message);
    }
    
    /**
     * Test unexpected error handling.
     * Passes null values to force exception.
     * Expects final balance = 0 and generic error message.
     */
    @IsTest
    static void testUnexpectedErrorHandling() {
        TermDepositCalculatorController.CalculatorInput input = new TermDepositCalculatorController.CalculatorInput();
        input.startAmount = null;
        input.interestRate = null;
        input.termYears = null;
        input.interestFrequency = null;
        
        TermDepositCalculatorController.CalculatorOutput result = TermDepositCalculatorController.calculate(input);
        
        System.assertEquals(0, result.finalBalance);
        System.assertEquals(
            'An unexpected error occurred. Please contact your administrator.', 
            result.message,
            'Error message should be security-friendly and not expose system internals'
        );
    }
}
