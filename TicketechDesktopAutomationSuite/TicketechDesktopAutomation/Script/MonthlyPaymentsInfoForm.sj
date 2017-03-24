//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT BackPanel
//USEUNIT MonthlyPaymentsPaymentTypeScreen
//USEUNIT MonthlyPaymentsSelectPaymentPanel
//USEUNIT TaxTypeOptionsPanel

/**************************************************************************************
            ---------- Class Definition ----------
  Name:MonthlyPaymentsInfoForm
  
  Description: 
  
  This class has methods and properties to perform the MonthlyPaymentsInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************************/

function monthlyPaymentsInfoForm() { 

/*--------------------------------------------------------------------------------- 
  Method: monthlyPaymentsInfoForm() 
  
  Description: This method will the Instantiate the monthlyPaymentsInfoForm Wrapper
---------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgMonthlyPaymentsInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormMonthlyPaymentsInfo*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objMonthlyPayTypeScreen = MonthlyPaymentsPaymentTypeScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objBackPanel = BackPanel.New();
  
  this.throwError = false; 
    
} //monthlyPaymentsInfoForm

monthlyPaymentsInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the monthlyPaymentsInfoForm Wrapper   
-------------------------------------------------------------------------------------*/  
  try {
  
    this.dlgMonthlyPaymentsInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormMonthlyPaymentsInfo*", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objMonthlyPayTypeScreen = MonthlyPaymentsPaymentTypeScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objBackPanel = BackPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

monthlyPaymentsInfoForm.prototype.Exists = function () {  

/*------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the monthlyPaymentsInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgMonthlyPaymentsInfo.Exists;  //Return whether monthlyPaymentsInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

monthlyPaymentsInfoForm.prototype.InputPayDetails = function (ePayData) {  

/*-----------------------------------------------------------------------
  Method      : InputPayDetails()
  
  Description : This method enters Payment details  
  
  Output      : Enters Payment Details if MonthlyPaymentsInfo Form Exists
-----------------------------------------------------------------------*/  
  try {
  
    bErrorFlag = false; //boolean flag to set for error during field validation
  
    this.lastError = {};
    
    //Checks if MonthlyPaymentsInfoForm Exists else throw error
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsInfoForm.InputPayDetails: The MonthlyPayments Info Form does not Exist.",
              message     : this.dlgMonthlyPaymentsInfo + " The MonthlyPayments Info Form does not Exist." }             
   
    //if MonthlyPaymentsInfoForm Exists, continue with Steps
    
    //Checks Pay amount greater than 0, if yes, enters pay amount, else sets errorflag to true
    if(ePayData.iPayAmount > 0){
      this.objMonthlyPayTypeScreen.SetPayAmount(ePayData.iPayAmount);
      Delay(1000);
    }
    else 
      bErrorFlag = true;
      
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    //Checks ErrorFlag is false, to continue next step, else skips other steps 
    if (!bErrorFlag){
      //Initialize TaxTypeOptionsPanel
      this.objTaxTypeOptionsPanel = TaxTypeOptionsPanel.New();
      //Checks Taxtype from testData and Clicks the required button
      if (ePayData.sTaxType === "Exemption")
        this.objTaxTypeOptionsPanel.ClickExemption();
      else
        this.objTaxTypeOptionsPanel.ClickFullTax();
    
      this.Refresh();
      Delay(3000);
      
      //Initialize MonthlyPaymentsSelectPaymentPanel
      this.objMonthlyPaymentsSelectPaymentPanel = MonthlyPaymentsSelectPaymentPanel.New();
      //Checks Paytype from testData and Clicks the required button
      if (ePayData.sPayType === "Cash")
        this.objMonthlyPaymentsSelectPaymentPanel.ClickCash();
      else if (ePayData.sPayType === "Check")
        this.objMonthlyPaymentsSelectPaymentPanel.ClickCheck(); 
      else if (ePayData.sPayType === "CreditCard")
        this.objMonthlyPaymentsSelectPaymentPanel.ClickCreditCard(); 
      else {
        this.objNavigationPanel.ClickEnter();
        bErrorFlag = true;//if no option, set errorFlag as true
      }
      Delay(1000);
    }
    return bErrorFlag; 
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputPayDetails

monthlyPaymentsInfoForm.prototype.InputPayDetailsWithError = function (ePayData) {  

/*------------------------------------------------------------------------------------------
  Method      : InputPayDetailsWithError()
  
  Description : This method enters invalid Pay details and click enter button
  
  Output      : Enters invalid Pay details in MonthlyPaymentsInfo Form and click enter button
-------------------------------------------------------------------------------------------*/  
  try {
    var sMessage = null;  
    
    //Calls InputPayDetails method and passes testData, Checks errorFlag
    if(this.InputPayDetails(ePayData))
      sMessage = this.objMonthlyPayTypeScreen.GetErrorMessage();//if errorFlag is true, gets errorMessage
      
    return sMessage;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputPayDetailsWithError


function New() {

/*------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating monthlyPaymentsInfoForm() class from other units of the project. 
-------------------------------------------------------------------------------------------------*/

  return new monthlyPaymentsInfoForm();  
}
