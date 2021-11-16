public without sharing class RepaymentServiceFactory {
    
    /**
     * @description getInstance returns the instance of the IRepaymentSercive service class registered for the service name at runtime
     * @throws ImplementationNotFoundException
     * @param  serviceName - the name of the registered service
     * @return             returns the ServiceFactoryImplementation of IRepaymentFactory.
     */ 

    public static IRepaymentService getInstance(string serviceName) {
        
        Map<string,RepaymentServiceImpl__mdt> registeredRepaymentServices = RepaymentServiceImpl__mdt.getAll();
        if(registeredRepaymentServices != null && registeredRepaymentServices.size() > 0) {
            for(RepaymentServiceImpl__mdt service : registeredRepaymentServices.values()) {
                if(service.ServiceName__c.equalsIgnoreCase(serviceName)){
                    try{
                        return (IRepaymentService)Type.forName(service.ServiceClass__c).newInstance();
                    }catch(Exception e){
                        // using a custom exception here to allow for extension later on.
                        throw new ImplementationNotFoundException(e.getMessage());
                    }
                }

            }
        }
        
        
        // throw an exception so that the client knows how to handle the scenarion that there are no registered 
        throw new ImplementationNotFoundException('No Registered Repayment Services Found. Please Register Services in Custom Metadata');

    }





}
