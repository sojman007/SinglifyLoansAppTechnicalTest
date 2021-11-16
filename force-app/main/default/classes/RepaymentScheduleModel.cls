public class RepaymentScheduleModel {
    
    public Loan_Repayment_Schedule__c repaymentSchedule {get;private set;}
    public integer index {get;set;}


    /**
     * @description generateTableData creates a List of RepaymentScheduleModel given a list of repayment records 
     * The general idea is to be able to generate data for the vf wizard (including periods with no payment)
     * @param  repaymentRecords represents the repayment Records to be stored/ already stored in the database
     * @return                  return a List of RepaymentScheduleModel
     */ 
    public static List<RepaymentScheduleModel> generateTableData(List<Loan_Repayment_Schedule__c> repaymentRecords, Loan_Request__c loanRequest) {
        List<RepaymentScheduleModel> response = new List<RepaymentScheduleModel>();
        for(integer i = 1; i < loanRequest.Number_Of_Months__c ; i++){
            


        }


        return response;


    }


}
