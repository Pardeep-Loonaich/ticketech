//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:MonthlyPaymentsSelectPaymentPanel
  
  Description: 
  
  This class has methods and properties to perform the MonthlyPaymentsSelectPayment panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function monthlyPaymentsSelectPaymentPanel() { 

/*--------------------------------------------------------------------------- 
  Method: monthlyPaymentsSelectPaymentPanel() 
  
  Description: This method will the Instantiate the monthlyPaymentsSelectPaymentPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlMonthlyPaymentsSelectPayment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelMonthlyPaymentsSelectPayment", 2);
  this.throwError = false; 
    
} //monthlyPaymentsSelectPaymentPanel

monthlyPaymentsSelectPaymentPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the monthlyPaymentsSelectPaymentPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlMonthlyPaymentsSelectPayment.Exists;  //Return whether monthlyPaymentsSelectPaymentPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

monthlyPaymentsSelectPaymentPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if MonthlyPaymentsSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at monthlyPaymentsSelectPaymentPanel.Click"+btnName+": The MonthlyPaymentsSelectPayment Panel does not Exist.",
              message     : this.pnlMonthlyPaymentsSelectPayment + " Panel does not Exist." }             
    
    objPayTypeButton = this.pnlMonthlyPaymentsSelectPayment.FindChild("WndCaption",btnName, 2);
    if(objPayTypeButton.Exists){
      objPayTypeButton.SetFocus();
      objPayTypeButton.ClickButton();
    }
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

monthlyPaymentsSelectPaymentPanel.prototype.ClickCash = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCash()
  
  Description : This method Clicks the Cash button  
  
  Output      : Click on Cash button if MonthlyPaymentsSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  this.Click("CASH");
      
} //ClickCash

monthlyPaymentsSelectPaymentPanel.prototype.ClickCreditCard = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCreitCard()
  
  Description : This method Clicks the Credit Card button  
  
  Output      : Click on Credit Card button if MonthlyPaymentsSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  this.Click("CREDIT CARD");
      
} //ClickCreditCard

monthlyPaymentsSelectPaymentPanel.prototype.ClickCheck = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCheck()
  
  Description : This method Clicks the Check button  
  
  Output      : Click on Check button if MonthlyPaymentsSelectPayment Panel Exists
-----------------------------------------------------------------*/  
  this.Click("CHECK");
      
} //ClickCheck

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating monthlyPaymentsSelectPaymentPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new monthlyPaymentsSelectPaymentPanel();  
}