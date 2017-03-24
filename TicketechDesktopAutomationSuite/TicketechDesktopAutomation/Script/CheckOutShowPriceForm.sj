//USEUNIT Utility
//USEUNIT StayPriceScreen
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT DealsOptionsPanel
//USEUNIT OtherIncomeSelectPaymentPanel
//USEUNIT OptionsPricePanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckOutShowPriceForm
  
  Description: 
  
  This class has methods and properties to perform the CheckOutShowPriceForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkOutShowPriceForm() { 

/*--------------------------------------------------------------------- 
  Method: checkOutShowPriceForm() 
  
  Description: This method will the Instantiate the checkOutShowPriceForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckOutShowPrice =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutShowPrice", 3000); 
  
  this.objStayPriceScreen               = StayPriceScreen.New();
  this.objNavigationPanel               = NavigationPanel.New();
  this.objDealsOptionsPanel             = DealsOptionsPanel.New();
  this.objOtherIncomeSelectPaymentPanel = OtherIncomeSelectPaymentPanel.New();
  this.objOptionsPricePanel             = OptionsPricePanel.New();
  
  this.throwError = false; 
    
} //checkOutShowPriceForm

checkOutShowPriceForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkOutShowPriceForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
   
    this.dlgCheckOutShowPrice =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutShowPrice", 3000); 
  
    this.objStayPriceScreen               = StayPriceScreen.New();
    this.objNavigationPanel               = NavigationPanel.New();
    this.objDealsOptionsPanel             = DealsOptionsPanel.New();
    this.objOtherIncomeSelectPaymentPanel = OtherIncomeSelectPaymentPanel.New();
    this.objOptionsPricePanel             = OptionsPricePanel.New();
  
  this.throwError = false; 
    
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkOutShowPriceForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkOutShowPriceForm.  
  
  Output      : True if dialog Exists
                False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckOutShowPrice.Exists;  //Return whether checkInCustomerInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


checkOutShowPriceForm.prototype.GetDetails = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetDetails() 
  
  Description:
  This method is for getting the Info of the Screen such as Amount and Rate Type. 
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutShowPriceForm.GetDetails: The CheckOutShowPrice Form does not Exist.",
              message     : this.dlgCheckOutShowPrice + " The CheckOutShowPrice Form does not Exist." }
     
    detailsInfo = {   StayPrice    : this.objStayPriceScreen.GetTotalValue().OleValue,
                      StayRateType : this.objStayPriceScreen.GetRateType()
                  };

    return detailsInfo;       
  }
  
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }

}//GetDetails

checkOutShowPriceForm.prototype.NavigateToAlternateRateScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToAlternateRateScreen
  
  Description : This method Clicks on the given Alternate rate button  
  
  Output      : Clicks the Alternate rate button if CheckOutShowPrice Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutShowPriceForm.ClickAlternateRate: The CheckOutShowPrice Form does not Exist.",
              message     : this.dlgCheckOutShowPrice + " The CheckOutShowPrice Form does not Exist." }             
    
    this.objOptionsPricePanel.ClickAlternateRate();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
}//NavigateToAlternateRateScreen
 
checkOutShowPriceForm.prototype.NavigateToCreditCardScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCreditCardScreen
  
  Description : This method Clicks Credit Card button  
  
  Output      : Clicks Credit Card if CheckOutShowPrice Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutShowPriceForm.NavigateToCreditCardScreen: The CheckOutShowPrice Form does not Exist.",
              message     : this.dlgCheckOutShowPrice + " The CheckOutShowPrice Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCreditCard();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToCreditCardScreen

checkOutShowPriceForm.prototype.NavigateToNoChargeScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToNoChargeScreen
  
  Description : This method Clicks No Charge button  
  
  Output      : Clicks No Charge if CheckOutShowPrice Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutShowPriceForm.NavigateToNoChargeScreen: The CheckOutShowPrice Form does not Exist.",
              message     : this.dlgCheckOutShowPrice + " The CheckOutShowPrice Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickNoCharge();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToNoChargeScreen

checkOutShowPriceForm.prototype.NavigateToChargeScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToChargeScreen
  
  Description : This method ClicksCharge button  
  
  Output      : Clicks Charge if CheckOutShowPrice Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutShowPriceForm.NavigateToChargeScreen: The CheckOutShowPrice Form does not Exist.",
              message     : this.dlgCheckOutShowPrice + " The CheckOutShowPrice Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCharge();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToChargeScreen

checkOutShowPriceForm.prototype.NavigateToCashScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCashScreen
  
  Description : This method Clicks Cash button  
  
  Output      : Clicks Cash if CheckOutShowPrice Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutShowPriceForm.NavigateToCashScreen: The CheckOutShowPrice Form does not Exist.",
              message     : this.dlgCheckOutShowPrice + " The CheckOutShowPrice Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCash();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToCashScreen

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkOutShowPriceForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkOutShowPriceForm();  
}

