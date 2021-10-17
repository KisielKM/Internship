public class LogException extends Exception {
    // public String ModuleName {get; set;}
    public String StackTrace {get; set;}
    public String ClassName {get; set;}
    public String MethodName {get; set;}
    public String ExceptionCause {get; set;}
        
    public void log(Exception ex)
    {
     try
        {
            extractExceptionData(ex); 
            writeToObject(ex);
            System.debug('This is a debug message');            
        }
        catch(Exception e)
        {
            // new LogException().Module('LogException').log(e);
            new LogException().log(e);            
        }                 
    }
    
    // public LogException Module(String Name)
    // {
    //     ModuleName = name;
    //     return this;
    // }
    
    public LogException ExceptionCause(String cause)
    {
        ExceptionCause = cause;
        return this;
    }
    
    public void extractExceptionData(Exception ex)
    {
        try
        {
            stackTrace = ex.getStackTraceString()
                         .substringBefore('\n');
            
            className = stackTrace.substringAfter('.')
                        .substringBefore('.'); 
            
            methodName = stackTrace.substringBefore(':')
                         .substringAfter(className)
                         .substringAfter('.');    
        }
        catch(Exception e)
        {
            new LogException().log(e);
            // new LogException().Module('LogException').log(e); 
        }                      
    }
    
    public void writeToObject(Exception ex)
    // drugi parametr Exception
    {
     try
        {
            Error_Log__c logger = new Error_Log__c();
            logger.Process_Name__c = className + ' ' + '/' + methodName;
            logger.Log_Details__c = String.valueOf(ex.getCause());
            logger.Log_Date_Time__c = DateTime.now();
            // // logger.Module_Name__c = ModuleName;
            // logger.Stack_Trace__c = ex.getStackTraceString();
            // logger.Class_Name__c = className;
            // logger.Method_Name__c = methodName;
            // logger.Line_Number__c = ex.getLineNumber();
            // // logger.Exception_Type__c = ex.getTypeName();
            // logger.Exception_Cause_Override__c = ExceptionCause; 
            // logger.Exception_Cause__c = String.valueOf(ex.getCause());
            
            // logger.Exception_Message__c = ex.getMessage();
            
            insert logger;    
        }
        
        catch(Exception e)
        {
            // new LogException().Module('LogException').log(e);
            new LogException().log(e);    
        }
        
    }
    
}
// Process_Name__c
// Log_Details__c
// Log_Date_Time__c
