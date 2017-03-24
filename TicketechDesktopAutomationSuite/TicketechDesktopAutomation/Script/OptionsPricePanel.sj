//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:OptionsPricePanel
  
  Description: 
  
  This class has methods and properties to perform the OptionsPricePanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function optionsPricePanel() { 

/*--------------------------------------------------------------------------- 
  Method: optionsPricePanel() 
  
  Description: This method will the Instantiate the optionsPricePanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlOptionsPrice =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelOptionsPrice", 2);
  this.throwError = false; 
    
} //optionsPricePanel

optionsPricePanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the optionsPricePanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlOptionsPrice.Exists;  //Return whether optionsPricePanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

optionsPricePanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if OptionsPrice Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPricePanel.Click"+btnName+": The OptionsPrice Panel does not Exist.",
              message     : this.pnlOptionsPrice + " Panel does not Exist." }             
    
    this.pnlOptionsPrice.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

optionsPricePanel.prototype.ClickReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickReservation()
  
  Description : This method Clicks the Reservation button  
  
  Output      : Click on Reservation button if OptionsPrice Panel Exists
-----------------------------------------------------------------*/  
  this.Click("RESERVATION");
      
} //ClickCash

optionsPricePanel.prototype.ClickMobileCoupons = function () {  

/*-----------------------------------------------------------------
  Method      : ClickMobileCoupons()
  
  Description : This method Clicks the Mobile Coupons button  
  
  Output      : Click on Mobile Coupons button if OptionsPrice Panel Exists
-----------------------------------------------------------------*/  
  this.Click("MOBILE COUPONS");
      
} //ClickCreditCard

optionsPricePanel.prototype.ClickAlternateRate = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCharge()
  
  Description : This method Clicks Charge button  
  
  Output      : Click on Charge button if OptionsPrice Panel Exists
-----------------------------------------------------------------*/  
  this.Click("ALTERNATE RATE");
      
} //ClickAlternateRate

optionsPricePanel.prototype.ClickCorrectPrice = function () {  

/*------------------------------------------------------------------------------
  Method      : ClickStamp()
  
  Description : This method Clicks the Stamp button  
  
  Output      : Click on Stamp button if OptionsPrice Panel Exists
--------------------------------------------------------------------------------*/  
  this.Click("CORRECT PRICE");
}

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating optionsPricePanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new optionsPricePanel();  
}