//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT BankDropScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT CursorsPanel
//USEUNIT BackPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:BankDropInfoForm
  
  Description: 
  
  This class has methods and properties to perform the BankDropInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function bankDropInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: bankDropInfoForm() 
  
  Description: This method will the Instantiate the bankDropInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgBankDropInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName","FormBankDropInfo*", 2); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objBankDropScreen = BankDropScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objNumericPanel = NumericPanel.New();
  this.objCursorsPanel = CursorsPanel.New();
  this.objBackPanel = BackPanel.New
  
  this.throwError = false; 
    
} //bankDropInfoForm

bankDropInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the bankDropInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgBankDropInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormBankDropInfo*", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objBankDropScreen = BankDropScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objNumericPanel = NumericPanel.New();
    this.objCursorsPanel = CursorsPanel.New();
    this.objBackPanel = BackPanel.New
  
        
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at bankDropInfoForm.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

bankDropInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the bankDropInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgBankDropInfo.Exists;  //Return whether bankDropInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

bankDropInfoForm.prototype.InputBankDropDetails = function (objTestData) {  

/*--------------------------------------------------------------------------
  Method      : InputBankDropDetails()
  
  Description : This method enters Bag Number and Amount 
  
  Output      : Enters Bag Number and Amount if BankDropInfoBagNumber Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at bankDropInfoForm.InputBankDropDetails: The BankDropInfoBagNumber Form does not Exist.",
              message     : this.dlgBankDropInfo + " The BankDropInfoBagNumber Form does not Exist." }             
    
    this.objBankDropScreen.SetBagNumber(objTestData.sBagNumber);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    if(objTestData.sBagNumber === this.objBankDropScreen.GetBagNumber())  
      this.objBankDropScreen.SetAmount(objTestData.iAmount);
    else
      return this.objBankDropScreen.GetBagNumber();
      
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at bankDropInfoForm.InputBankDropDetails");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputBankDropDetails

bankDropInfoForm.prototype.InputBankDropDetailsWithErrors = function (objTestData) {  

/*--------------------------------------------------------------------------
  Method      : InputBankDropDetailsWithErrors()
    
  Description : This method enters Username and Password 
  
  Output      : Enters Username and Password if UserInfo Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.InputBankDropDetails(objTestData);
    
    this.Refresh();
    Delay(1000);    
    
    return this.objBankDropScreen.GetMessage();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at bankDropInfoForm.InputBankDropDetailsWithErrors");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputBankDropDetailsWithErrors

bankDropInfoForm.prototype.CheckLastAddedBagInGridFirstRow = function (sBagNumber) {  

/*--------------------------------------------------------------------------
  Method      : CheckLastAddedBagInGridFirstRow()
    
  Description : This method Checks the latest added grid is available in the first row
  
  Output      : returns true if the last added Bag is found in Grid first row
--------------------------------------------------------------------------*/  
  try {
    
    return this.objBankDropScreen.CheckGivenBagInFirstRow(sBagNumber);
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at bankDropInfoForm.CheckLastAddedBagInGridFirstRow");
  } //End catch
      
} //CheckLastAddedBagInGridFirstRow

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating bankDropInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new bankDropInfoForm();  
}

