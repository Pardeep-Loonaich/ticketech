//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT PaymentPanel
//USEUNIT CreditCardsPanel
//USEUNIT PaymentCreditCardOfflineScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckOutPaymentCreditCardOfflineForm
  
  Description: 
  
  This class has methods and properties to perform the CheckOutPaymentCreditCardOfflineForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/


function checkOutPaymentCreditCardOfflineForm() { 

/*--------------------------------------------------------------------- 
  Method: checkOutPaymentCreditCardOfflineForm() 
  
  Description: This method will the Instantiate the checkOutPaymentCreditCardOfflineForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckOutPaymentCreditCardOffline =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentCreditCardOffline*", 3000); 
  
  this.objInformationScreen = InformationScreen.New();
  this.objPaymentCreditCardOfflineScreen = PaymentCreditCardOfflineScreen.New();
  this.objNavigationPanel   = NavigationPanel.New();
  this.objCreditCardsPanel  = CreditCardsPanel.New();
  this.objPaymentPanel      = PaymentPanel.New();
  
  this.throwError = false; 
    
} //checkOutPaymentCreditCardOfflineForm

checkOutPaymentCreditCardOfflineForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkOutPaymentCreditCardOfflineForm Wrapper   
--------------------------------------------------------------------------------------*/  
  try {
    
    this.dlgCheckOutPaymentCreditCardOffline =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentCreditCardOffline*", 3000); 
  
    this.objInformationScreen = InformationScreen.New();
    this.objPaymentCreditCardOfflineScreen = PaymentCreditCardOfflineScreen.New();
    this.objNavigationPanel   = NavigationPanel.New();
    this.objCreditCardsPanel  = CreditCardsPanel.New();
    this.objPaymentPanel      = PaymentPanel.New();
        
  } //End try
  
  catch (exception) {
	  TestLog.Messgae("Exception at CheckOutPaymentCreditCardOfflineForm.Refresh");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkOutPaymentCreditCardOfflineForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkOutPaymentCreditCardOfflineForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckOutPaymentCreditCardOffline.Exists;  //Return whether checkOutPaymentCreditCardOfflineForm exists or not
  
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at CheckOutPaymentCreditCardOfflineForm.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkOutPaymentCreditCardOfflineForm.prototype.SelectCard = function (iCardIndex) {  

/*----------------------------------------------------------------------------------
  Method      : SelectCard()
  
  Description : This method select a creit card in CheckOutPaymentCreditCardOfflineForm  
  
  Output      : selects card if CheckOutPaymentCreditCardOfflineForm Form Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormCheckOutPaymentCreditCardOffline.SelectCard: The CheckOutPaymentCreditCardOffline Form does not Exist.",
              message     : this.dlgCheckOutPaymentCreditCardOffline + " The CheckOutPaymentCreditCardOffline Form does not Exist." }             
    
    this.objCreditCardsPanel.ClickCreditCardType(iCardIndex);
    Delay(1000);
  
  } //End try
  
  catch (exception) {
	  TestLog.Message("Exception at CheckOutPaymentCreditCardOfflineForm.SetPaymentKeyBoard");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectCard

checkOutPaymentCreditCardOfflineForm.prototype.SubmitForm = function () {  

/*----------------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks enter in CheckOutPaymentCreditCardOfflineForm  
  
  Output      : Clicks enter if CheckOutPaymentCreditCardOfflineForm Form Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormCheckOutPaymentCreditCardOffline.SubmitForm: The CheckOutPaymentCreditCardOffline Form does not Exist.",
              message     : this.dlgCheckOutPaymentCreditCardOffline + " The CheckOutPaymentCreditCardOffline Form does not Exist." }             
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);

    return this.objPaymentCreditCardOfflineScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
	  TestLog.Message("Exception at CheckOutPaymentCreditCardOfflineForm.SubmitForm");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitForm

checkOutPaymentCreditCardOfflineForm.prototype.CancelForm = function () {  

/*----------------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks Cancel in CheckOutPaymentCreditCardOfflineForm  
  
  Output      : Clicks Cancel if CheckOutPaymentCreditCardOfflineForm Form Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormCheckOutPaymentCreditCardOffline.CancelForm: The CheckOutPaymentCreditCardOffline Form does not Exist.",
              message     : this.dlgCheckOutPaymentCreditCardOffline + " The CheckOutPaymentCreditCardOffline Form does not Exist." }             
    
    this.objNavigationPanel.ClickCancel();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
	  TestLog.Message("Exception at CheckOutPaymentCreditCardOfflineForm.CancelForm");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //CancelForm



function New() {

/*------------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkOutPaymentCreditCardOfflineForm() class from other units of the project. 
-------------------------------------------------------------------------------------------------*/

  return new checkOutPaymentCreditCardOfflineForm();  
}
