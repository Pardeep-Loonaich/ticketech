//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT OtherIncomeSelectPaymentPanel




/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckOutSelectPaymentTypeForm
  
  Description: 
  
  This class has methods and properties to perform the CheckOutSelectPaymentTypeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkOutSelectPaymentTypeForm() { 

/*--------------------------------------------------------------------- 
  Method: checkOutSelectPaymentTypeForm() 
  
  Description: This method will the Instantiate the checkOutSelectPaymentTypeForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckOutSelectPaymentType =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutSelectPaymentType", 3000); 
  
  this.objNavigationPanel               = NavigationPanel.New();
  this.objOtherIncomeSelectPaymentPanel  =OtherIncomeSelectPaymentPanel.New();

  
  this.throwError = false; 
    
} //checkOutSelectPaymentTypeForm

checkOutSelectPaymentTypeForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkOutSelectPaymentTypeForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
   
    this.dlgCheckOutSelectPaymentType =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutSelectPaymentType", 3000); 

    this.objNavigationPanel               = NavigationPanel.New();
    this.objOtherIncomeSelectPaymentPanel  =OtherIncomeSelectPaymentPanel.New();
  
  this.throwError = false; 
    
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkOutSelectPaymentTypeForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkOutSelectPaymentTypeForm.  
  
  Output      : True if dialog Exists
                False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckOutSelectPaymentType.Exists;  //Return whether checkInCustomerInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


 
checkOutSelectPaymentTypeForm.prototype.NavigateToCreditCardScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCreditCardScreen
  
  Description : This method Clicks Credit Card button  
  
  Output      : Clicks Credit Card if CheckInPayment Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutSelectPaymentTypeForm.NavigateToCreditCardScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckOutSelectPaymentType + " The CheckInPayment Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCreditCard();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToCreditCardScreen

checkOutSelectPaymentTypeForm.prototype.NavigateToCashScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCashScreen
  
  Description : This method Clicks No Charge button  
  
  Output      : Clicks No Charge if CheckInPayment Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutSelectPaymentTypeForm.NavigateToCashScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckOutSelectPaymentType + " The CheckInPayment Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCash();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToCashScreen

checkOutSelectPaymentTypeForm.prototype.NavigateToStampScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToStampScreen
  
  Description : This method Clicks Stamp button  
  
  Output      : Clicks Stamp if CheckOutSelectPaymentType Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutSelectPaymentTypeForm.NavigateToStampScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckOutSelectPaymentType + " The CheckInPayment Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickStamp();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToStampScreen

checkOutSelectPaymentTypeForm.prototype.NavigateToCouponScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCouponScreen
  
  Description : This method Clicks Coupon button  
  
  Output      : Clicks Cou[pon if CheckOutSelectPaymentType Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutSelectPaymentTypeForm.NavigateToCouponScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckOutSelectPaymentType + " The CheckInPayment Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCoupon();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToCouponScreen

checkOutSelectPaymentTypeForm.prototype.NavigateToChargeScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToChargeScreen
  
  Description : This method Clicks Charge button  
  
  Output      : Clicks Charge if CheckOutSelectPaymentType Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutSelectPaymentTypeForm.NavigateToChargeScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckOutSelectPaymentType + " The CheckInPayment Form does not Exist." }             
    
    this.objOtherIncomeSelectPaymentPanel.ClickCharge();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToChargeScreen


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkOutSelectPaymentTypeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkOutSelectPaymentTypeForm();  
}

