//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:PaymentChargeScreen
  
  Description: 
  
  This class has methods and properties to perform the PaymentChargeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function paymentChargeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: paymentChargeScreen() 
  
  Description: This method will the Instantiate the PaymentChargeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPaymentCharge =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPaymentCharge", 2);
  
  this.throwError = false; 
    
} //paymentChargeScreen

paymentChargeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentChargeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPaymentCharge.Exists;  //Return whether paymentChargeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentChargeScreen.prototype.SetAccountNo= function (sAccountNo) {  

/*-------------------------------------------------------------------------------
  Method      : SetAccountNo()
  
  Description : This method enters the Account Number in the PaymentCharge Screen
  
  Output      : Enters the Description in the PaymentChargeScreen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentChargeScreen.SetAccountNo: The PaymentCharge Screen does not Exist.",
              message     : this.scrnPaymentCharge + " Screen does not Exist." }             
    
    if (sAccountNo !== undefined && sAccountNo !== null)
    this.scrnPaymentCharge.FindChild("WinFormsControlName", "maskedTextBoxInfo", 2).Keys(sAccountNo);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetAccountNo

paymentChargeScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the PaymentCharge Screen
  
  Output      : Returns the error message displayed in the PaymentCharge Screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentChargeScreen.GetErrorMessage: The PaymentCharge Screen does not Exist.",
              message     : this.scrnPaymentCharge + " OtherIncome Screen does not Exist." }             
    
    return this.scrnPaymentCharge.WinFormsObject("screenInformationFooter")
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

  return new paymentChargeScreen();  
}