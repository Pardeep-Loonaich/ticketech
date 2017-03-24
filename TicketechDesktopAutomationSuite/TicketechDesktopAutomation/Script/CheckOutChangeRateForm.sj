//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT ChangeRatePanel
//USEUNIT PaymentPanel
//USEUNIT StayPriceScreen


/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckOutChangeRateForm
  
  Description: 
  
  This class has methods and properties to perform the CheckOutChangeRateForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkOutChangeRateForm() { 

/*-------------------------------------------------------------------------------- 
  Method: checkOutChangeRateForm() 
  
  Description: This method will Instantiate the CheckOutChangeRateForm Wrapper
--------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckOutChangeRate =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutChangeRate", 3000); 
  
  this.objInfoScreen      = InformationScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objChangeRatePanel = ChangeRatePanel.New();
  this.objPaymentPanel    = PaymentPanel.New();
  this.objStayPriceScreen = StayPriceScreen.New();
  
  this.throwError = false; 
    
} //timekeeperMenuForm

checkOutChangeRateForm.prototype.Refresh = function () {  

/*------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will re-instantiate the CheckOutChangeRateForm Wrapper   
------------------------------------------------------------------------------------*/  
  try {
  
  this.dlgCheckOutChangeRate =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutChangeRate", 3000); 
  
  this.objInfoScreen         = InformationScreen.New();
  this.objNavigationPanel    = NavigationPanel.New();
  this.objChangeRatePanel    = ChangeRatePanel.New();
  this.objPaymentPanel       = PaymentPanel.New();
  this.objStayPriceScreen    = StayPriceScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkOutChangeRateForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the CheckOutChangeRateForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckOutChangeRate.Exists;  //Return whether CheckOutChangeRateForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkOutChangeRateForm.prototype.SelectRateType = function () {  

/*------------------------------------------------------------------------------
  Method      : SelectRateType
  
  Description : This method Clicks on the given rate type button  
  
  Output      : Clicks the given button if CheckOutChangeRate Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at CheckOutChangeRateForm.SelectRateType: The CheckOutChangeRate Form does not Exist.",
              message     : this.dlgCheckOutChangeRate + " The CheckOutChangeRate Form does not Exist." }             
    
    this.objChangeRatePanel.Click("AUDIOCOMMAND");
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectCode

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating CheckOutChangeRateForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkOutChangeRateForm();  
}