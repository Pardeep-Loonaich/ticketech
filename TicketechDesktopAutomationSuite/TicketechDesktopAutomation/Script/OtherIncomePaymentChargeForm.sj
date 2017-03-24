//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT OtherIncomePaymentChargeScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomePaymentChargeForm
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomePaymentChargeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function otherIncomePaymentChargeForm() { 

/*-------------------------------------------------------------------------- 
  Method: otherIncomePaymentChargeForm() 
  
  Description: This method will the Instantiate the otherIncomePaymentChargeForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgOtherIncomePaymentCharge =  Sys.Process("PosApplication").WaitWinFormsObject("FormOtherIncomePaymentCharge", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.otherIncomePaymentChargeScreen = OtherIncomePaymentChargeScreen.New();
  this.navigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //otherIncomePaymentChargeForm

otherIncomePaymentChargeForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the otherIncomePaymentChargeForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgOtherIncomePaymentCharge =  Sys.Process("PosApplication").WaitWinFormsObject("FormOtherIncomePaymentCharge", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.otherIncomePaymentChargeScreen = OtherIncomePaymentChargeScreen.New();
    this.navigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

otherIncomePaymentChargeForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomePaymentChargeForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgOtherIncomePaymentCharge.Exists;  //Return whether otherIncomePaymentChargeForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

otherIncomePaymentChargeForm.prototype.InputAndSubmitForm = function (account_number) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters the account number  
  
  Output      : Enters Account Number if OtherIncomePaymentCharge Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomePaymentChargeForm.InputAndSubmitForm: The OtherIncomePaymentCharge Form does not Exist.",
              message     : this.dlgOtherIncomePaymentCharge + " The OtherIncomePaymentCharge Form does not Exist." }             
    
    this.otherIncomePaymentChargeScreen.EnterAccountNumber(account_number);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitForm

otherIncomePaymentChargeForm.prototype.InputAndSubmitFormWithErrors = function (account_number) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
  
  Description : This method enters the account number
  
  Output      :  Enters Account Number if OtherIncomePaymentCharge Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(account_number);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.otherIncomePaymentChargeScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitFormWithErrors

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating otherIncomePaymentChargeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new otherIncomePaymentChargeForm();  
}


