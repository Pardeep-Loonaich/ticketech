//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT OtherIncomePaymentTypeScreen
//USEUNIT Utility
//USEUNIT OtherIncomeSelectPaymentPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomeInfoForm
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomeInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function otherIncomeInfoForm() { 

/*---------------------------------------------------------------------------------- 
  Method: otherIncomeInfoForm() 
  
  Description: This method will the Instantiate the otherIncomeInfoForm Wrapper
---------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgOtherIncomeInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormOtherIncomeInfo*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objOtherIncomePaymentTypeScreen = OtherIncomePaymentTypeScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  //this.objOtherIncomeSelectPaymentPanel=OtherIncomeSelectPaymentPanel.New();
  
  this.throwError = false; 
    
} //otherIncomeInfoForm

otherIncomeInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the otherIncomeInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgOtherIncomeInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormOtherIncomeInfo*", 3000); 
    
    this.objInfoScreen = InformationScreen.New();
    this.objOtherIncomePaymentTypeScreen = OtherIncomePaymentTypeScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    //this.objOtherIncomeSelectPaymentPanel=OtherIncomeSelectPaymentPanel.New();
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

otherIncomeInfoForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomeInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgOtherIncomeInfo.Exists;  //Return whether otherIncomeInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


otherIncomeInfoForm.prototype.InputPayDetails = function (ePayData) {  

/*-----------------------------------------------------------------------
  Method      : InputPayDetails()
  
  Description : This method enters Payment details  
  
  Output      : Enters Payment Details if OtherIncomeInfo Form Exists
-----------------------------------------------------------------------*/  
  try {
  
    bErrorFlag = false; //boolean flag to set for error during field validation
  
    this.lastError = {};
    
    //Checks if OtherIncomeInfoForm Exists else throw error
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at OtherIncomeInfoForm.InputPayDetails: The OtherIncome Info Form does not Exist.",
              message     : this.dlgOtherIncomeInfo + " The OtherIncome Info Form does not Exist." }             
   
    //if OtherIncomeInfoForm Exists, continue with Steps
    
    //Checks Pay amount greater than 0, if yes, enters pay amount, else sets errorflag to true
    if(ePayData.iPayAmount > 0){
      this.objOtherIncomePaymentTypeScreen.SetAmount(ePayData.iPayAmount);
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
          
      //Initialize OtherIncomeSelectPaymentPanel
      this.objOtherIncomeSelectPaymentPanel = OtherIncomeSelectPaymentPanel.New();
      //Checks Paytype from testData and Clicks the required button
      if (ePayData.sPayType === "Cash")
        this.objOtherIncomeSelectPaymentPanel.ClickCash();
      else if (ePayData.sPayType === "CreditCard")
        this.objOtherIncomeSelectPaymentPanel.ClickCreditCard();
      else if (ePayData.sPayType === "Charge")
        this.objOtherIncomeSelectPaymentPanel.ClickCharge(); 
      else if (ePayData.sPayType === "Check")
        this.objOtherIncomeSelectPaymentPanel.ClickCheck();   
      else {
        this.objNavigationPanel.ClickEnter();
        bErrorFlag = true;//if no option, set errorFlag as true
      }
      Delay(2000);
    }
    return bErrorFlag; 
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputPayDetails

otherIncomeInfoForm.prototype.InputPayDetailsWithErrors = function (ePayData) {  

/*------------------------------------------------------------------------------------------
  Method      : InputPayDetailsWithErrors()
  
  Description : This method enters invalid Pay details and click enter button
  
  Output      : Enters invalid Pay details in OtherIncomeInfo Form and click enter button
-------------------------------------------------------------------------------------------*/  
  try {
    var sMessage = null;  
    
    //Calls InputPayDetails method and passes testData, Checks errorFlag
    if(this.InputPayDetails(ePayData))
      sMessage = this.objOtherIncomePaymentTypeScreen.GetErrorMessage();//if errorFlag is true, gets errorMessage
      
    return sMessage;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputPayDetailsWithErrors

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating otherIncomeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new otherIncomeInfoForm();  
}
