//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:PaymentPanel
  
  Description: 
  
  This class has methods and properties to perform the Payment panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function paymentPanel() { 

/*--------------------------------------------------------------------------- 
  Method: paymentPanel() 
  
  Description: This method will the Instantiate the paymentPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlPayment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelPayment", 2);
  this.throwError = false; 
    
} //paymentPanel

paymentPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the paymentPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlPayment.Exists;  //Return whether paymentPanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

paymentPanel.prototype.ClickPayment = function () {  

/*------------------------------------------------------
  Method      : ClickPayment()
  
  Description : This method Clicks Payment button 
  
  Output      : Clicks Payment button if Payment Panel Exists
------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PaymentPanel.ClickPayment: The Payment Panel does not Exist.",
              message     : this.pnlPayment + " Panel does not Exist." }             
    
    this.pnlPayment.WaitWinFormsObject("ScreenButton", "PAYMENT", 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at paymentPanel.ClickPayment");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickPayment


function New() {

/*----------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating paymentPanel() class from other units of the project. 
-----------------------------------------------------------------------------------*/

  return new paymentPanel();  
}