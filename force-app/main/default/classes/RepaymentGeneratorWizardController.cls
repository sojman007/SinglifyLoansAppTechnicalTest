public without sharing class RepaymentGeneratorWizardController {
    
    private List<String> fieldsOfInterest = new List<String>{'Suma_Credit__c','Number_Of_Months__c',
    'Monthly_Due_Date__c' ,'Name','Status__c' ,'Expected_Disbursement_Date__c', 'Periods_Per_Year__c',
    'Interest__c','Processing_Fee__c' ,'Risk_Fee__c','Administrative_Fee__c','Loan_Offer__r.Id'
    ,'Loan_Offer__r.Interest__c','Loan_Offer__r.Risk_Fee__c','Loan_Offer__r.Administrative_Fee__c',
    'Loan_Offer__r.Processing_Fee__c'
    };
    private Loan_Request__c loanRequest ; 
    private IRepaymentService rPayService {get;set;}
    private List<string> acceptableStatuses = new String[]{'Approved' ,'Disbursed'};


    public boolean messageDisplayed {get;set;}
    public boolean displayContent {get;set;}
    public string implementation {get;set;}
    public List<RepaymentScheduleModel> GeneratedRepayments {get;set;}
    public List<SelectOption> implementationOptions {get
        {
            List<SelectOption> options = new List<SelectOption>();
            Map<string,RepaymentServiceImpl__mdt> registeredRepaymentServices = RepaymentServiceImpl__mdt.getAll();
            if(registeredRepaymentServices != null && registeredRepaymentServices.size() > 0){
                for(RepaymentServiceImpl__mdt mdt : registeredRepaymentServices.values()){
                    SelectOption opt = new SelectOption(mdt.ServiceName__c , mdt.ServiceName__c);
                    options.add(opt);
                }
            }
            return options;
        }set;}

        public boolean disableAction{get{
            return this.rPayService == null ? true : false;
         }set;}





    
    public RepaymentGeneratorWizardController(ApexPages.StandardController std) {
        if(!Test.isRunningTest()){
            std.addFields(fieldsOfinterest);
        }
        loanRequest = (Loan_Request__c)std.getRecord();
        displayContent = true;
        implementation = implementationOptions[0].getValue();
        onChangeImplementation();
        if(! (loanRequest?.Status__c== null) &&  !(acceptableStatuses.contains(loanRequest.Status__c))){
            displayContent = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR , 'You cannot Generate Repayment Schedules for Loans Not yet Approved Or Disbursed. Please Approve/Disburse This Loan ')); 
        }
    }

    public void onChangeImplementation(){
        try{
            this.rPayService = (IRepaymentService)RepaymentServiceFactory.getInstance(implementation);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR , 'No Registered Implementation Found For the Selected Service'));
        }

    }

    public void onGenerateRepaymentSchedules(){
        List<Loan_Repayment_Schedule__c> repaymentSchedules = this.rPayService.generateRepaymentSchedules(this.loanRequest);
        this.GeneratedRepayments = RepaymentScheduleModel.generateTableData(repaymentSchedules, this.loanRequest);
    }

    public void SaveGeneratedRepaymentSchedules(){

    }



}
