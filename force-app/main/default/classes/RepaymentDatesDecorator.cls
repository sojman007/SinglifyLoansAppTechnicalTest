public without sharing class RepaymentDatesDecorator {
    public Date repaymentDate {get ; private set;}
    public boolean hasRepayment {get;private set;}


    public RepaymentDatesDecorator(Date rpDate){
        repaymentDate = rpDate;

    }

    public void setHasRepayment(boolean hasRepayment){
        this.hasRepayment = hasRepayment;
    }

}
