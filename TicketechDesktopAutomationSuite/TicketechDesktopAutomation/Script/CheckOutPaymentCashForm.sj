//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT PaymentPanel
//USEUNIT MoneyPanel
//USEUNIT PaymentCashScreen
//USEUNIT NumericPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckOutPaymentCashForm
  
  Description: 
  
  This class has methods and properties to perform the CheckOutPaymentCashForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkOutPaymentCashForm() { 

/*--------------------------------------------------------------------- 
  Method: checkOutPaymentCashForm() 
  
  Description: This method will the Instantiate the checkOutPaymentCashForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckOutPaymentCash =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentCash", 3000); 
  
  this.objInformationScreen = InformationScreen.New();
  this.objPaymentCashScreen = PaymentCashScreen.New();
  this.objNavigationPanel   = NavigationPanel.New();
  this.objMoneyPanel        = MoneyPanel.New();
  this.objPaymentPanel      = PaymentPanel.New();
  this.objNumericPanel      = NumericPanel.New();
  
  this.throwError = false; 
    
} //checkOutPaymentCashForm

checkOutPaymentCashForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkOutPaymentCashForm Wrapper   
--------------------------------------------------------------------------------------*/  
  try {
    
    this.dlgCheckOutPaymentCash =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentCash", 3000); 
  
    this.objInformationScreen = InformationScreen.New();
    this.objPaymentCashScreen = PaymentCashScreen.New();
    this.objNavigationPanel   = NavigationPanel.New();
    this.objMoneyPanel        = MoneyPanel.New();
    this.objPaymentPanel      = PaymentPanel.New();
    this.objNumericPanel      = NumericPanel.New();
        
  } //End try
  
  catch (exception) {
	TestLog.Messgae("Exception at CheckOutPaymentCashForm.Refresh");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkOutPaymentCashForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkOutPaymentCashForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckOutPaymentCash.Exists;  //Return whether checkOutPaymentCashForm exists or not
  
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at CheckOutPaymentCashForm.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkOutPaymentCashForm.prototype.SetPaymentKeyBoard = function (iAmount) {  

/*----------------------------------------------------------------------------------
  Method      : SetPaymentKeyBoard()
  
  Description : This method enters Pay amount in CheckOutPaymentCashForm  
  
  Output      : Enters Pay Amount by Keyboard if CheckOutPaymentCashForm Form Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormCheckOutPaymentCash.InputAndSubmitForm: The CheckOutPaymentCash Form does not Exist.",
              message     : this.dlgCheckOutPaymentCash + " The CheckOutPaymentCash Form does not Exist." }             
    
    this.objPaymentCashScreen.SetPaymentCash(iAmount);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
	  TestLog.Message("Exception at CheckOutPaymentCashForm.SetPaymentKeyBoard");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPaymentKeyBoard

checkOutPaymentCashForm.prototype.SubmitForm = function () {  

/*----------------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks enter in checkOutPaymentCashForm  
  
  Output      : Clicks enter if checkOutPaymentCashForm Form Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at CheckOutPaymentCashForm.SubmitForm: The CheckOutPaymentCashForm does not Exist.",
              message     : this.dlgCheckOutPaymentCash + " The CheckOutPaymentCashForm does not Exist." }             
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);

    return this.objPaymentCashScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
	  TestLog.Message("Exception at checkOutPaymentCashForm.SubmitForm");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitForm


function New() {

/*------------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkOutPaymentCashForm() class from other units of the project. 
-------------------------------------------------------------------------------------------------*/

  return new checkOutPaymentCashForm();  
}

checkOutPaymentCashForm.prototype.SetPaymentbyButton = function (PayAmount) {  

/*--------------------------------------------------------------------------
  Method      : SetPaymentbyButton()
  
  Description : This method enters Pay amount CheckOutPaymentCashForm  
  
  Output      : Enters Pay Amount if CheckOutPaymentCashForm Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormCheckOutPaymentCash.SetPaymentbyButton: The CheckOutPaymentCash Form does not Exist.",
              message     : this.dlgCheckOutPaymentCash + " The CheckOutPaymentCash Form does not Exist." }             
    
    Delay(1000);
    this.objMoneyPanel.Click("$"+PayAmount+".00");
    
  } //End try

  catch (exception) {
	TestLog.Message("Exception at CheckOutPaymentCashForm.SetPaymentbyButton");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPaymentbyButton 

checkOutPaymentCashForm.prototype.SelectLesserAmount = function () {  

/*--------------------------------------------------------------------------
  Method      : SelectLesserAmount()
  
  Description : This method enters less than the Pay amount CheckOutPaymentCashForm  
  
  Output      : Enters Pay Amount if CheckOutPaymentCashForm Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormCheckOutPaymentCash.SelectLesserAmount: The CheckOutPaymentCash Form does not Exist.",
              message     : this.dlgCheckOutPaymentCash + " The CheckOutPaymentCash Form does not Exist." }             
    
    this.objMoneyPanel.Click("$*");
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try

  catch (exception) {
	TestLog.Message("Exception at CheckOutPaymentCashForm.SelectLesserAmount");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPaymentbyButton     
