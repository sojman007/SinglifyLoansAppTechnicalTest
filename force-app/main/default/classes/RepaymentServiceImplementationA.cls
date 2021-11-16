public with sharing class RepaymentServiceImplementationA 
extends BaseRepaymentServiceImplementation 
implements IRepaymentService{
    
    public RepaymentServiceImplementationA() {
        super();
    }


    /**
     * @description generateRepaymentSchedules houses the logic for the way Loan Repayments 
     * are calculated for this algorithm - For now this uses a basic mock implementation
     * @param  request - represents the Loan Request we are generating repayment schedules for.
     * @return         - returns generated Loan RepaymentSchedules models for display.
     */ 
    public List<Loan_Repayment_Schedule__c> generateRepaymentSchedules(Loan_Request__c request){
        List<Loan_Repayment_Schedule__c> schedules = new List<Loan_Repayment_Schedule__c>();
        List<string> periodsPerYear = request.Periods_Per_year__c.split(';');
        List<RepaymentDatesDecorator> repaymentDates = RepaymentServiceUtils.generateRepaymentDates(request.Expected_Disbursement_Date__c, 
        Integer.valueOf(request.number_Of_Months__c), 
        PeriodsPerYear, Integer.valueOf(request.Monthly_Due_Date__c));

        decimal totalLoanInterest = request.Interest__c * request.Suma_Credit__c / 100;
        for(Integer i =1 ; i <= repaymentDates.size(); i++){
            RepaymentDatesDecorator rpDate = repaymentDates[i-1];
            System.debug(repaymentDate);
            // Loan_Repayment_Schedule__c schedule = new Loan_Repayment_Schedule__c();
            if(rpDate.hasRepayment == true){
                // call a service to calculate the repayment fee
                Loan_Repayment_Schedule__c schedule = new Loan_Repayment_Schedule__c(Date__c = rpDate.repaymentDate ,
                 Principal__c= 5000.00, Interest__c = 400.00, Period__c ='Period '+i, Total_Amount__c = 8012.3 ,
                 Fees__c=200.00);
                
                schedules.add(schedule);    
            }

        }
        return schedules;

    }



}
