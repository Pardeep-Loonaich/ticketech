//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT PrepaymentSelectPaymentPanel




/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInPrepaymentForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInPrepaymentForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInPrepaymentForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInPrepaymentForm() 
  
  Description: This method will the Instantiate the checkInPrepaymentForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckInPrepayment =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInPrepayment", 3000); 
  
  this.objNavigationPanel               = NavigationPanel.New();
  this.objPrepaymentSelectPaymentPanel  =PrepaymentSelectPaymentPanel.New();

  
  this.throwError = false; 
    
} //checkInPrepaymentForm

checkInPrepaymentForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkInPrepaymentForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
   
    this.dlgCheckInPrepayment =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInPrepayment", 3000); 

    this.objNavigationPanel               = NavigationPanel.New();
    this.objPrepaymentSelectPaymentPanel  =PrepaymentSelectPaymentPanel.New();
  
  this.throwError = false; 
    
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkInPrepaymentForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInPrepaymentForm.  
  
  Output      : True if dialog Exists
                False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckInPrepayment.Exists;  //Return whether checkInCustomerInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


 
checkInPrepaymentForm.prototype.NavigateToCreditCardScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCreditCardScreen
  
  Description : This method Clicks Credit Card button  
  
  Output      : Clicks Credit Card if CheckInPayment Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInPrepaymentForm.NavigateToCreditCardScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckInPrepayment + " The CheckInPayment Form does not Exist." }             
    
    this.objPrepaymentSelectPaymentPanel.ClickCreditCard();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch  
      
} //NavigateToCreditCardScreen

checkInPrepaymentForm.prototype.NavigateToCashScreen = function () {  

/*------------------------------------------------------------------------------
  Method      : NavigateToCashScreen
  
  Description : This method Clicks No Charge button  
  
  Output      : Clicks No Charge if CheckInPayment Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInPrepaymentForm.NavigateToCashScreen: The CheckInPayment Form does not Exist.",
              message     : this.dlgCheckInPrepayment + " The CheckInPayment Form does not Exist." }             
    
    this.objPrepaymentSelectPaymentPanel.ClickCash();
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
  This method is for instantiating checkInPrepaymentForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInPrepaymentForm();  
}

