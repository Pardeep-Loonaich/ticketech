//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomePaymentChargeScreen
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomePaymentChargeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function otherIncomePaymentChargeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: otherIncomePaymentChargeScreen() 
  
  Description: This method will the Instantiate the OtherIncomePaymentChargeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnOtherIncomePaymentCharge =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenOtherIncomePaymentCharge", 2);
  
  this.throwError = false; 
    
} //otherIncomePaymentChargeScreen

otherIncomePaymentChargeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomePaymentChargeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnOtherIncomePaymentCharge.Exists;  //Return whether otherIncomePaymentChargeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

otherIncomePaymentChargeScreen.prototype.EnterAccountNumber = function (account_number) {  

/*-------------------------------------------------------------------------------
  Method      : EnterAccountNumber()
  
  Description : This method enters the account number in the OtherIncomePaymentCharge screen
  
  Output      : Enters the account number in the OtherIncomePaymentCharge screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomePaymentChargeScreen.EnterAccountNumber: The OtherIncomePaymentCharge screen does not Exist.",
              message     : this.scrnOtherIncomePaymentCharge + " Screen does not Exist." }             
    
    if (account_number !== undefined && account_number !== null)
      this.scrnOtherIncomePaymentCharge.FindChild("WinFormsControlName", "labelTextBox", 2).Keys(account_number);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetEmployeeID

otherIncomePaymentChargeScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the OtherIncomePaymentsCharge screen 
  
  Output      : Returns the error message displayed in the OtherIncomePaymentsCharge screen  
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomePaymentChargeScreen.GetErrorMessage: The OtherIncomePaymentCharge screen does not Exist.",
              message     : this.scrnOtherIncomePaymentCharge + " OtherIncomePaymentCharge Screen does not Exist." }             
    
    return this.scrnOtherIncomePaymentCharge.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
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
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new otherIncomePaymentChargeScreen();  
}