//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:PaymentCashScreen
  
  Description: 
  
  This class has methods and properties to perform the PaymentCashScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function paymentCashScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: paymentCashScreen() 
  
  Description: This method will the Instantiate the PaymentCashScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPaymentCash =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPaymentCash", 3);
  
  this.throwError = false; 
    
} //paymentCashScreen

paymentCashScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentCashScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPaymentCash.Exists;  //Return whether paymentCashScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentCashScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentCashScreen.prototype.SetPaymentCash = function (iCash) {  

/*-------------------------------------------------------------------------------
  Method      : SetPaymentCash()
  
  Description : This method enters the Cash to Pay in the PaymentCash screen
  
  Output      : Enters the Cash in the PaymentCash screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentCashScreen.SetPaymentCash: The PaymentCash Screen does not Exist.",
              message     : this.scrnPaymentCash + " Screen does not Exist." }             
    
    if (iCash !== undefined && iCash !== null)
      this.scrnPaymentCash.FindChild("Caption","PAY",2).FindChild("WinFormsControlName", "maskedTextBoxInfo", 1).Keys(iCash);
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentCashScreen.SetPaymentCash "+iCash);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPaymentCash

paymentCashScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText(objControlName)
  
  Description : This method returns the text labelled in the paymentCash screen 
  
  Output      : Returns the Text labelled in the paymentCash screen 
-------------------------------------------------------------------------------*/ 

  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentCashScreen.GetText: The paymentCash screen does not Exist.",
              message     : this.scrnPaymentCash + " paymentCash screen does not Exist." }             
    
    return this.scrnPaymentCash.FindChild("WinFormsControlName", objControlName, 2).Text;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText


paymentCashScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the PaymentCash screen 
  
  Output      : Returns the error message displayed in the PaymentCash screen 
-------------------------------------------------------------------------------------*/            
    
  return this.GetText("labelInformation");
      
} //GetErrorMessage

paymentCashScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the PaymentCash screen 
  
  Output      : Returns the current Title labelled in the PaymentCash screen 
-------------------------------------------------------------------------------*/ 
  
  return this.GetText("labelTitle");
  
} //GetTitle 

paymentCashScreen.prototype.GetTotalToPay = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTotalToPay()
  
  Description : This method returns the Total amount To Pay in the PaymentCash screen 
  
  Output      : Returns the Total amount To Pay in the PaymentCash screen 
-------------------------------------------------------------------------------*/ 
  
  return   this.GetText("selectableTextBoxTotalToPay");
  
} //GetTotalToPay


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating paymentCashScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new paymentCashScreen();  
}