//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT PaymentPanel
//USEUNIT PaymentCheckScreen

/**************************************************************************************
            ---------- Class Definition ----------
  Name:MonthlyPaymentsCheckForm
  
  Description: 
  
  This class has methods and properties to perform the MonthlyPaymentsCheckForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************************/

function monthlyPaymentsCheckForm() { 

/*--------------------------------------------------------------------------------- 
  Method: monthlyPaymentsCheckForm() 
  
  Description: This method will the Instantiate the monthlyPaymentsCheckForm Wrapper
---------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgMonthlyPaymentsCheck =  Sys.Process("PosApplication").WaitWinFormsObject("FormMonthlyPaymentsCheck*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objPaymentCheckScreen = PaymentCheckScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objPaymentPanel = PaymentPanel.New();
  
  this.throwError = false; 
    
} //monthlyPaymentsCheckForm

monthlyPaymentsCheckForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the monthlyPaymentsCheckForm Wrapper   
-------------------------------------------------------------------------------------*/  
  try {
  
    this.dlgMonthlyPaymentsCheck =  Sys.Process("PosApplication").WaitWinFormsObject("FormMonthlyPaymentsCheck*", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objPaymentCheckScreen = PaymentCheckScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objPaymentPanel = PaymentPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

monthlyPaymentsCheckForm.prototype.Exists = function () {  

/*------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the monthlyPaymentsCheckForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgMonthlyPaymentsCheck.Exists;  //Return whether monthlyPaymentsCheckForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

monthlyPaymentsCheckForm.prototype.InputCheckDetails = function (eCheckData) {  

/*-----------------------------------------------------------------------
  Method      : InputCheckDetails()
  
  Description : This method enters Check details  
  
  Output      : Enters Check Details if MonthlyPaymentsCheck Form Exists
-----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    //Checks if MonthlyPaymentsCheckForm Exists else throw error
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsCheckForm.InputCheckDetails: The MonthlyPayments Check Form does not Exist.",
              message     : this.dlgMonthlyPaymentsCheck + " The MonthlyPayments Check Form does not Exist." }             
   
    //if MonthlyPaymentsCheckForm Exists, continue with Steps
    
    this.objPaymentCheckScreen.SetBankName(eCheckData.sBankName);
    Delay(1000);
      
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    this.objPaymentCheckScreen.SetCheckNumber(eCheckData.iCheckNumber);
    Delay(1000);
      
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputCheckDetails


function New() {

/*------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating monthlyPaymentsCheckForm() class from other units of the project. 
-------------------------------------------------------------------------------------------------*/

  return new monthlyPaymentsCheckForm();  
}
