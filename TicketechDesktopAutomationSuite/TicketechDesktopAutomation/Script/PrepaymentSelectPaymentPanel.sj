//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:PrepaymentSelectPaymentPanel
  
  Description: 
  
  This class has methods and properties to perform the PrepaymentSelectPayment Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function prepaymentSelectPaymentPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: prepaymentSelectPaymentPanel() 
  
  Description: This method will the Instantiate the PrepaymentSelectPayment Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlPrepaymentSelectPayment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelPrepaymentSelectPayment", 2);
  this.throwError = false; 
    
} //prepaymentSelectPaymentPanel

prepaymentSelectPaymentPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the prepaymentSelectPaymentPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlPrepaymentSelectPayment.Exists;  //Return whether prepaymentSelectPaymentPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

prepaymentSelectPaymentPanel.prototype.ClickCash = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCash()
  
  Description : This method Clicks the cash  button  
  
  Output      : Click on Cash button if PrepaymentSelectPayment Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("CASH")
  
} //ClickReservation

prepaymentSelectPaymentPanel.prototype.ClickCreditCard = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCreditCard()
  
  Description : This method Clicks the CreditCard button  
  
  Output      : Click onCreditCard button if PrepaymentSelectPayment Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("CREDIT CARD")
  
} //ClickPrepay

prepaymentSelectPaymentPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if PrepaymentSelectPayment Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at prepaymentSelectPaymentPanel.Click"+btnName+": The PrepaymentSelectPayment Panel does not Exist.",
              message     : this.pnlPrepaymentSelectPayment + " Panel does not Exist." }             
    
    this.pnlPrepaymentSelectPayment.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating prepaymentSelectPaymentPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new prepaymentSelectPaymentPanel();  
}