//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT MonthlyPaymentsScreen

/**************************************************************************************************
            ---------- Class Definition ----------
  Name:MonthlyPaymentsInfoAccountNumberForm
  
  Description: 
  
  This class has methods and properties to perform the MonthlyPaymentsInfoAccountNumberForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
***************************************************************************************************/

function monthlyPaymentsInfoAccountNumberForm() { 

/*---------------------------------------------------------------------------------------------- 
  Method: monthlyPaymentsInfoAccountNumberForm() 
  
  Description: This method will the Instantiate the monthlyPaymentsInfoAccountNumberForm Wrapper
----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgMonthlyPaymentsInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormMonthlyPaymentsInfoAccountNumber", 3000); 
  
  this.objInformationScreen = InformationScreen.New();
  this.objMonthlyPaymentsScreen = MonthlyPaymentsScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //monthlyPaymentsInfoAccountNumberForm

monthlyPaymentsInfoAccountNumberForm.prototype.Refresh = function () {  

/*--------------------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the monthlyPaymentsInfoAccountNumberForm Wrapper   
--------------------------------------------------------------------------------------------------*/  
  try {
  
    this.dlgMonthlyPaymentsInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormMonthlyPaymentsInfoAccountNumber", 3000); 
  
    this.objInformationScreen = InformationScreen.New();
    this.objMonthlyPaymentsScreen = MonthlyPaymentsScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

monthlyPaymentsInfoAccountNumberForm.prototype.Exists = function () {  

/*------------------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the monthlyPaymentsInfoAccountNumberForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgMonthlyPaymentsInfo.Exists;  //Return whether monthlyPaymentsInfoAccountNumberForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

monthlyPaymentsInfoAccountNumberForm.prototype.InputAndSubmitForm = function (eAccountData) {  

/*---------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters Customer AccountNumber  
  
  Output      : Enters AccountNumber if MonthlyPaymentsInfo Form Exists
---------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsInfoAccountNumberForm.InputAndSubmitForm: The MonthlyPayments Info Form does not Exist.",
              message     : this.dlgMonthlyPaymentsInfo + " The MonthlyPayments Info Form does not Exist." }             
    
    this.objMonthlyPaymentsScreen.SetCustomerAccount(eAccountData.sAccountNo);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitForm

monthlyPaymentsInfoAccountNumberForm.prototype.InputAndSubmitFormWithErrors = function (eAccountData) {  

/*--------------------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
  
  Description : This method enters Accountnumber and click enter button
  
  Output      : Enters Accountnumber in MonthlyPayments Info Form and click enter button
--------------------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(eAccountData);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.objMonthlyPaymentsScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitFormWithErrors

function New() {

/*-------------------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating monthlyPaymentsInfoAccountNumberForm() class from other units of the project. 
--------------------------------------------------------------------------------------------------------------*/

  return new monthlyPaymentsInfoAccountNumberForm();  
}

