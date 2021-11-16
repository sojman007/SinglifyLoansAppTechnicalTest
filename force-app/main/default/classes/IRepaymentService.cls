public interface IRepaymentService {
    
    List<Loan_Repayment_Schedule__c> generateRepaymentSchedules(Loan_Request__c loanRequest);


}
