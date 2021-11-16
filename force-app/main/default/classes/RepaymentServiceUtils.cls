public without sharing class RepaymentServiceUtils {
    


    public static List<RepaymentDatesDecorator> generateRepaymentDates(Date startDate , 
                                                                        integer numberOfMonths , 
                                                                        List<String> PeriodsPerYear, 
                                                                        integer payday){

        List<RepaymentDatesDecorator> response = new List<RepaymentDatesDecorator>();
        
        Date tempDate = startDate.addMonths(1);
        Date nextRepaymentDate = Date.newInstance(tempDate.year() , tempDate.month() , payday);
        for(integer  i =1 ; i <= numberOfMonths ; i++){
            RepaymentDatesDecorator rpDate = new RepaymentDatesDecorator(nextRepaymentDate);
            if(PeriodsPerYear.contains(RepaymentServiceConstants.getCalenderYearRegister().get(nextRepaymentDate.month()))){
                rpDate.setHasRepayment(true);
            }else rpDate.setHasRepayment(false);
            response.add(rpDate);
            Date tempFutureDate = nextRepaymentDate.addMonths(1);
            nextRepaymentDate = Date.newInstance(tempFutureDate.year() , tempFutureDate.month(), payday);
        }

        return response;

    }


    


}
