/**
* Developer: Usha Jennifer A
* Created Date: 09-Oct-2026
* Description: Controller class for Term Deposit Calculator.
*              Accepts user input (principal, interest rate, term, frequency),
*              performs simple or compound interest calculation,
*              and returns the final balance with a status message.
*/

public with sharing class TermDepositCalculatorController {
    
    /**
* Wrapper class for input parameters.
* - startAmount: Principal deposit amount
* - interestRate: Annual interest rate in percentage (e.g., 1.10)
* - termYears: Investment term in years (fractional allowed)
* - interestFrequency: Frequency of interest application (monthly, quarterly, annually, maturity)
*/
    public class CalculatorInput {
        @AuraEnabled public Decimal startAmount { get; set; }
        @AuraEnabled public Decimal interestRate { get; set; }
        @AuraEnabled public Decimal termYears { get; set; }
        @AuraEnabled public String interestFrequency { get; set; }
    }
    
    /**
* Wrapper class for output results.
* - finalBalance: Calculated maturity amount
* - message: Status message (success or error)
*/
    public class CalculatorOutput {
        @AuraEnabled public Decimal finalBalance;
        @AuraEnabled public String message;
    }
    
    /**
* Main calculation method.
* Performs interest calculation based on frequency:
* - Maturity → Simple interest
* - Monthly/Quarterly/Annually → Compound interest
* Returns final balance and message.
*/
    @AuraEnabled
    public static CalculatorOutput calculate(CalculatorInput input) {
        CalculatorOutput result = new CalculatorOutput();
        try {
            // Extract input values
            Decimal principal = input.startAmount;
            Decimal rate = input.interestRate / 100;
            Decimal years = input.termYears;
            Decimal finalAmount;
            
            // Normalize frequency input
            String freq = (input.interestFrequency == null) ? '' : input.interestFrequency.toLowerCase();
            
            // Switch based on frequency
            switch on freq {
                when 'maturity' {
                    // ✅ Simple interest at maturity
                    finalAmount = principal * (1 + rate * years);
                }
                when 'monthly' {
                    finalAmount = calculateCompound(principal, rate, years, 12);
                }
                when 'quarterly' {
                    finalAmount = calculateCompound(principal, rate, years, 4);
                }
                when 'annually' {
                    finalAmount = calculateCompound(principal, rate, years, 1);
                }
                when else {
                    // Handle invalid frequency
                    result.message = 'Invalid interest frequency.';
                    result.finalBalance = 0;
                    return result;
                }
            }
            
            // Round result to 2 decimal places
            result.finalBalance = finalAmount.setScale(2);
            result.message = 'Calculation successful.';
            
        } catch (Exception e) {
            // ✅ Security-conscious error handling
            result.message = 'An unexpected error occurred. Please contact your administrator.';
            result.finalBalance = 0;
        }
        
        return result;
    }
    
    /**
* Helper method for compound interest calculation.
* Formula: A = P * (1 + r/n)^(n*t)
* - principal: Initial deposit
* - rate: Annual interest rate (decimal)
* - years: Investment term in years
* - n: Number of compounding periods per year
* Handles invalid inputs gracefully.
*/
    private static Decimal calculateCompound(Decimal principal, Decimal rate, Decimal years, Integer n) {
        try {
            // ✅ Defensive checks
            if (principal == null || rate == null || years == null || n == null || n <= 0) {
                // Return 0 if inputs are invalid
                return 0;
            }
            
            // ✅ Perform compound interest calculation
            Double calc = (Double)principal * 
                Math.pow((1 + (Double)rate / n), (Double)(n * (Double)years));
            
            return Decimal.valueOf(calc).setScale(2);
        } catch (Exception e) {
            // ✅ Error handling: return safe default
            // Do not expose system internals in the error
            return 0;
        }
    }
    
}