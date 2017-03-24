//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:MonthlyPaymentsScreen
  
  Description: 
  
  This class has methods and properties to perform the MonthlyPaymentsScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function monthlyPaymentsScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: monthlyPaymentsScreen() 
  
  Description: This method will the Instantiate the MonthlyPaymentsScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnMonthlyPayments =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenMonthlyPayments", 2);
  
  this.throwError = false; 
    
} //monthlyPaymentsScreen

monthlyPaymentsScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the monthlyPaymentsScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnMonthlyPayments.Exists;  //Return whether monthlyPaymentsScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

monthlyPaymentsScreen.prototype.SetCustomerAccount = function (sAccountNumber) {  

/*-------------------------------------------------------------------------------
  Method      : SetCustomerAccount()
  
  Description : This method enters the CustomerAccount in the Monthly payments screen
  
  Output      : Enters the CustomerAccount in the Monthly payments screen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at monthlyPaymentsScreen.SetCustomerAccount: The MonthlyPayments Screen does not Exist.",
              message     : this.scrnMonthlyPayments + " MonthlyPayments Screen does not Exist." }             
    
    if (sAccountNumber !== undefined && sAccountNumber !== null)
      this.scrnMonthlyPayments.FindChild("WinFormsControlName", "labelTextBox", 2).Keys(sAccountNumber);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetCustomerAccount

monthlyPaymentsScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the MonthlyPayments screen 
  
  Output      : Returns the error message displayed in the MonthlyPayments screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at monthlyPaymentsScreen.GetErrorMessage: The MonthlyPayments screen does not Exist.",
              message     : this.scrnMonthlyPayments + " MonthlyPayments Screen does not Exist." }             
    
    return this.scrnMonthlyPayments.FindChild("WinFormsControlName", "labelInformation", 2).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating monthlyPayments screen class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new monthlyPaymentsScreen();  
}