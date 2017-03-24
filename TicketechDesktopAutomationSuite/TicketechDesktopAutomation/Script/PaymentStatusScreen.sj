//USEUNIT Utility

/**********************************************************************************
            ---------- Class Definition ----------
  Name:PaymentStatusScreen
  
  Description: 
  
  This class has methods and properties to perform the paymentStatusScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*********************************************************************************/

function paymentStatusScreen() { 

/*------------------------------------------------------------------------------- 
  Method: paymentStatusScreen() 
  
  Description: This method will Instantiate the paymentStatusScreen Wrapper Helper
--------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPaymentStatus =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPaymentStatus", 2);
  this.throwError = false; 
    
} //paymentStatusScreen

paymentStatusScreen.prototype.Exists = function () {  

/*--------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentStatus Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPaymentStatus.Exists;  //Return whether paymentStatusScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentStatusScreen.prototype.GetTitle = function () {  

/*----------------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the paymentStatus screen 
  
  Output      : Returns the current Title labelled in the paymentStatus screen 
----------------------------------------------------------------------------------------*/  
  return   this.GetText("labelTitle");
      
} //GetTitle

paymentStatusScreen.prototype.GetAccountNumber = function () {  

/*--------------------------------------------------------------------------------------
  Method      : GetAccountNumber()
  
  Description : This method returns the AccountNumber labelled in the paymentStatus screen 
  
  Output      : Returns the AccountNumber labelled in the paymentStatus screen 
---------------------------------------------------------------------------------------*/  
  return this.GetText("customerInfo");
      
} //GetAccountNumber

paymentStatusScreen.prototype.GetScreenMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetScreenMessage()
  
  Description : This method returns the ScreenMessage in the paymentStatus screen 
  
  Output      : Returns the ScreenMessage in the paymentStatus screen 
-------------------------------------------------------------------------------*/  
  return this.GetText("vehicleInfo");
      
} //GetScreenMessage

paymentStatusScreen.prototype.GetFooterMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the current FooterMessage in the paymentStatus screen 
  
  Output      : Returns the current FooterMessage in the paymentStatus screen 
-------------------------------------------------------------------------------*/  
  return this.GetText("labelInformation");
      
} //GetFooterMessage

paymentStatusScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the paymentStatus screen 
  
  Output      : Returns the label of the given object in the paymentStatus screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at paymentStatusScreen.Get"+objControlName+": The PaymentStatus screen does not Exist.",
              message     : this.scrnPaymentStatus + " Screen does not Exist." }             
    
    return this.scrnPaymentStatus.FindChild("WinFormsControlName", objControlName, 2).Text;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating paymentStatusScreen() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new paymentStatusScreen();  
}