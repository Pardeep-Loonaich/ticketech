//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT PrepaymentScreen
//USEUNIT Utility

/*************************************************************************
            ---------- Class Definition ----------
  Name:PrepaymentAmountForm
  
  Description: 
  
  This class has methods and properties to perform the PrepaymentAmountForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function prepaymentAmountForm() { 

/*---------------------------------------------------------------------------------- 
  Method: prepaymentAmountForm() 
  
  Description: This method will the Instantiate the prepaymentAmountForm Wrapper
---------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgPrepaymentAmount =  Sys.Process("PosApplication").WaitWinFormsObject("FormPrepaymentAmount", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objPrepaymentScreen = PrepaymentScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //prepaymentAmountForm

prepaymentAmountForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the prepaymentAmountForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgPrepaymentAmount =  Sys.Process("PosApplication").WaitWinFormsObject("FormPrepaymentAmount", 3000); 
    
    this.objInfoScreen = InformationScreen.New();
    this.objPrepaymentScreen = PrepaymentScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

prepaymentAmountForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the prepaymentAmountForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgPrepaymentAmount.Exists;  //Return whether prepaymentAmountForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


prepaymentAmountForm.prototype.InputPrepayDetails = function (ePrepayData) {  

/*-----------------------------------------------------------------------
  Method      : InputPrepayDetails()
  
  Description : This method enters Prepayment details  
  
  Output      : Enters Prepayment Details if PrepaymentAmount Form Exists
-----------------------------------------------------------------------*/  
  try {
  
    bErrorFlag = false; //boolean flag to set for error during field validation
  
    this.lastError = {};
    
    //Checks if PrepaymentAmountForm Exists else throw error
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PrepaymentAmountForm.InputPrepayDetails: The PrepaymentAmount Form does not Exist.",
              message     : this.dlgPrepaymentAmount + " The PrepaymentAmount Form does not Exist." }             
   
    
    sExistingPrepayAmount = this.objPrepaymentScreen.GetAmount();
    //Checks Pay amount greater than 0, if yes, enters pay amount, else sets errorflag to true
    
    if(ePrepayData.sPrepayAmount == "0"){
      bErrorFlag = true;
    }
    else {
      this.objPrepaymentScreen.SetAmount(ePrepayData.sPrepayAmount);
      TestLog.Message("Prepay Amount set to: $"+ePrepayData.sPrepayAmount+" from $"+sExistingPrepayAmount);
      Delay(1000);
    }
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    if(bErrorFlag)
      return this.objPrepaymentScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputPrepayDetails

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating prepaymentAmountForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new prepaymentAmountForm();  
}
