//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:PaymentNoChargeScreen
  
  Description: 
  
  This class has methods and properties to perform the PaymentNoChargeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function paymentNoChargeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: paymentNoChargeScreen() 
  
  Description: This method will the Instantiate the PaymentNoChargeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPaymentNoCharge =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPaymentNoCharge", 2);
  
  this.throwError = false; 
    
} //paymentNoChargeScreen

paymentNoChargeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentNoChargeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPaymentNoCharge.Exists;  //Return whether paymentNoChargeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentNoChargeScreen.prototype.SetDescription = function (sDescription) {  

/*-------------------------------------------------------------------------------
  Method      : SetDescription()
  
  Description : This method enters the Description in the PaymentNoCharge Screen
  
  Output      : Enters the Description in the PaymentNoChargeScreen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentNoChargeScreen.SetDescription: The PaymentNoCharge Screen does not Exist.",
              message     : this.scrnPaymentNoCharge + " Screen does not Exist." }             
    
    if (sDescription !== undefined && sDescription !== null)
    this.scrnPaymentNoCharge.FindChild("WinFormsControlName", "textBoxInfo", 2).Keys(sDescription);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetDescription

paymentNoChargeScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the PaymentNoCharge Screen
  
  Output      : Returns the error message displayed in the PaymentNoCharge Screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentNoChargeScreen.GetErrorMessage: The PaymentNoCharge Screen does not Exist.",
              message     : this.scrnPaymentNoCharge + " OtherIncome Screen does not Exist." }             
    
    return this.scrnPaymentNoCharge.WinFormsObject("screenInformationFooter")
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

  return new paymentNoChargeScreen();  
}