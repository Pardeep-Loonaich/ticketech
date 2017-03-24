//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:PaymentCreditCardOfflineScreen
  
  Description: 
  
  This class has methods and properties to perform the PaymentCreditCardOfflineScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function paymentCreditCardOfflineScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: paymentCreditCardOfflineScreen() 
  
  Description: This method will the Instantiate the PaymentCreditCardOfflineScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPaymentCreditCardOffline =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPaymentCreditCardOffline", 3);
  
  this.throwError = false; 
    
} //paymentCreditCardOfflineScreen

paymentCreditCardOfflineScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentCreditCardOfflineScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPaymentCreditCardOffline.Exists;  //Return whether paymentCreditCardOfflineScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentCreditCardOfflineScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentCreditCardOfflineScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText(objControlName)
  
  Description : This method returns the text labelled in the paymentCreditCardOffline screen 
  
  Output      : Returns the Text labelled in the paymentCreditCardOffline screen 
-------------------------------------------------------------------------------*/ 

  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentCreditCardOfflineScreen.GetText: The paymentCreditCardOffline screen does not Exist.",
              message     : this.scrnPaymentCreditCardOffline + " paymentCreditCardOffline screen does not Exist." }             
    
    return this.scrnPaymentCreditCardOffline.FindChild("WinFormsControlName", objControlName, 2).Text;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText


paymentCreditCardOfflineScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the PaymentCreditCardOffline screen 
  
  Output      : Returns the error message displayed in the PaymentCreditCardOffline screen 
-------------------------------------------------------------------------------------*/            
    
  return this.GetText("labelInformation");
      
} //GetErrorMessage

paymentCreditCardOfflineScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the PaymentCreditCardOffline screen 
  
  Output      : Returns the current Title labelled in the PaymentCreditCardOffline screen 
-------------------------------------------------------------------------------*/ 
  
  return this.GetText("labelTitle");
  
} //GetTitle 

paymentCreditCardOfflineScreen.prototype.GetTotalToPay = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTotalToPay()
  
  Description : This method returns the Total amount To Pay in the PaymentCreditCardOffline screen 
  
  Output      : Returns the Total amount To Pay in the PaymentCreditCardOffline screen 
-------------------------------------------------------------------------------*/ 
  
  return   this.GetText("selectableTextBoxAmount");
  
} //GetTotalToPay


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating paymentCreditCardOfflineScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new paymentCreditCardOfflineScreen();  
}