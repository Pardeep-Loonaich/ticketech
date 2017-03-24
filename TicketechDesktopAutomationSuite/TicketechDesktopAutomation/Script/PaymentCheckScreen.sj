//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:PaymentCheckScreen
  
  Description: 
  
  This class has methods and properties to perform the PaymentCheckScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function paymentCheckScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: paymentCheckScreen() 
  
  Description: This method will the Instantiate the PaymentCheckScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPaymentCheck =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPaymentCheck", 3);
  
  this.throwError = false; 
    
} //paymentCheckScreen

paymentCheckScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentCheckScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPaymentCheck.Exists;  //Return whether paymentCheckScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentCheckScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentCheckScreen.prototype.SetBankName = function (sBankName) {  

/*-------------------------------------------------------------------------------
  Method      : SetBankName()
  
  Description : This method enters the BankName in the PaymentCheck screen
  
  Output      : Enters the BankName in the PaymentCheck screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentCheckScreen.SetBankName: The PaymentCheck Screen does not Exist.",
              message     : this.scrnPaymentCheck + " Screen does not Exist." }             
    
    if (sBankName !== undefined && sBankName !== null)
      this.scrnPaymentCheck.FindChild("Caption","BANK",2).FindChild("WinFormsControlName", "maskedTextBoxInfo", 1).Keys(sBankName);
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentCheckScreen.SetBankName "+sBankName);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetBankName

paymentCheckScreen.prototype.SetCheckNumber = function (iCheckNumber) {  

/*-------------------------------------------------------------------------------
  Method      : SetCheckNumber()
  
  Description : This method enters the CheckNumber in the PaymentCheck screen
  
  Output      : Enters the CheckNumber in the PaymentCheck screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentCheckScreen.SetCheckNumber: The PaymentCheck Screen does not Exist.",
              message     : this.scrnPaymentCheck + " Screen does not Exist." }             
    
    if (iCheckNumber !== undefined && iCheckNumber !== null)
      this.scrnPaymentCheck.FindChild("Caption","NUMBER",2).FindChild("WinFormsControlName", "maskedTextBoxInfo", 1).Keys(iCheckNumber);
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentCheckScreen.SetCheckNumber "+iCheckNumber);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetCheckNumber

paymentCheckScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText(objControlName)
  
  Description : This method returns the text labelled in the paymentCheck screen 
  
  Output      : Returns the Text labelled in the paymentCheck screen 
-------------------------------------------------------------------------------*/ 

  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentCheckScreen.GetText: The paymentCheck screen does not Exist.",
              message     : this.scrnPaymentCheck + " paymentCheck screen does not Exist." }             
    
    return this.scrnPaymentCheck.FindChild("WinFormsControlName", objControlName, 2).Text;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText


paymentCheckScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the PaymentCheck screen 
  
  Output      : Returns the error message displayed in the PaymentCheck screen 
-------------------------------------------------------------------------------------*/            
    
  return this.GetText("labelInformation");
      
} //GetErrorMessage

paymentCheckScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the PaymentCheck screen 
  
  Output      : Returns the current Title labelled in the PaymentCheck screen 
-------------------------------------------------------------------------------*/ 
  
  return this.GetText("labelTitle");
  
} //GetTitle 

paymentCheckScreen.prototype.GetTotalToPay = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTotalToPay()
  
  Description : This method returns the Total amount To Pay in the PaymentCheck screen 
  
  Output      : Returns the Total amount To Pay in the PaymentCheck screen 
-------------------------------------------------------------------------------*/ 
  
  return   this.GetText("selectableTextBoxPay");
  
} //GetTotalToPay

paymentCheckScreen.prototype.GetAccountNo = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetAccountNo()
  
  Description : This method returns the AccountNo in the PaymentCheck screen 
  
  Output      : Returns the AccountNo in the PaymentCheck screen 
-------------------------------------------------------------------------------*/ 
  
  return   this.GetText("selectableTextBoxAccount");
  
} //GetAccountNo


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating paymentCheckScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new paymentCheckScreen();  
}