//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomeSelectPaymentPanel
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomeSelectPaymentPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function otherIncomeSelectPaymentPanel() { 

/*--------------------------------------------------------------------------- 
  Method: otherIncomeSelectPaymentPanel() 
  
  Description: This method will the Instantiate the otherIncomeSelectPaymentPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlOtherIncomeSelectPayment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "Panel*Payment", 2);
  this.throwError = false; 
    
} //otherIncomeSelectPaymentPanel

otherIncomeSelectPaymentPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomeSelectPaymentPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlOtherIncomeSelectPayment.Exists;  //Return whether otherIncomeSelectPaymentPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

otherIncomeSelectPaymentPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if OtherIncomeSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeSelectPaymentPanel.Click"+btnName+": The OtherIncomeSelectPayment Panel does not Exist.",
              message     : this.pnlOtherIncomeSelectPayment + " Panel does not Exist." }             
    
    this.pnlOtherIncomeSelectPayment.WaitWinFormsObject("ScreenButton", btnName, 1000).Keys("[Enter]");
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

otherIncomeSelectPaymentPanel.prototype.ClickCash = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCash()
  
  Description : This method Clicks the Cash button  
  
  Output      : Click on cash button if OtherIncomeSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  this.Click("CASH");
      
} //ClickCash

otherIncomeSelectPaymentPanel.prototype.ClickCreditCard = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCreditCard()
  
  Description : This method Clicks the Credit Card button  
  
  Output      : Click on Credit Card button if OtherIncomeSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  this.Click("CREDIT CARD");
      
} //ClickCreditCard

otherIncomeSelectPaymentPanel.prototype.ClickCharge = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCharge()
  
  Description : This method Clicks Charge button  
  
  Output      : Click on Charge button if OtherIncomeSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  this.Click("CHARGE");
      
} //ClickCharge

otherIncomeSelectPaymentPanel.prototype.ClickStamp = function () {  

/*------------------------------------------------------------------------------
  Method      : ClickStamp()
  
  Description : This method Clicks the Stamp button  
  
  Output      : Click on Stamp button if OtherIncomeSelectPayment Panel Exists
--------------------------------------------------------------------------------*/  
  this.Click("STAMP");
  
}// ClickStamp

otherIncomeSelectPaymentPanel.prototype.ClickNoCharge = function () {  

/*------------------------------------------------------------------------------
  Method      : ClickNoCharge()
  
  Description : This method Clicks the No Charge button  
  
  Output      : Click on No Charge button if OtherIncomeSelectPayment Panel Exists
--------------------------------------------------------------------------------*/  
  this.Click("NO CHARGE");
  
}//ClickNoCharge

otherIncomeSelectPaymentPanel.prototype.ClickCoupon = function () {  

/*------------------------------------------------------------------------------
  Method      : ClickCoupon()
  
  Description : This method Clicks the Couponbutton  
  
  Output      : Click on Coupon button if OtherIncomeSelectPayment Panel Exists
--------------------------------------------------------------------------------*/  
  this.Click("COUPON");
  
}//ClickCoupon

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating otherIncomeSelectPaymentPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new otherIncomeSelectPaymentPanel();  
}