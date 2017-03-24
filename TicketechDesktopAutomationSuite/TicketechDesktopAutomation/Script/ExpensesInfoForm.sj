//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT ExpensesScreen
//USEUNIT Utility
//USEUNIT ExpensesCodesPanel
//USEUNIT BackPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:ExpensesInfoForm
  
  Description: 
  
  This class has methods and properties to perform the ExpensesInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function expensesInfoForm() { 

/*---------------------------------------------------------------------------------- 
  Method: expensesInfoForm() 
  
  Description: This method will the Instantiate the expensesInfoForm Wrapper
---------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgExpensesInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormExpensesInfo*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objExpensesScreen = ExpensesScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objBackPanel = BackPanel.New();

  this.throwError = false; 
    
} //expensesInfoForm

expensesInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the expensesInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgExpensesInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormExpensesInfo*", 3000); 
    
    this.objInfoScreen = InformationScreen.New();
    this.objExpensesScreen = ExpensesScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objBackPanel = BackPanel.New();    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

expensesInfoForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the expensesInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgExpensesInfo.Exists;  //Return whether expensesInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


expensesInfoForm.prototype.InputExpensesDetails = function (eExpensesData) {  

/*-----------------------------------------------------------------
  Method      : InputExpensesDetails()
  
  Description : This method enters Expenses details 
  
  Output      : Enters Expenses details if expensesInfo Form Exists
-----------------------------------------------------------------*/  
  try {
  
    bErrorFlag = false;
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at expensesInfoForm.InputExpenseDetail: The expensesInfo Form does not Exist.",
              message     : this.dlgExpensesInfo + " The expensesInfo Form does not Exist." }             
    
   
    this.objExpensesCodesPanel = ExpensesCodesPanel.New();
    
    if(!this.objExpensesCodesPanel.ClickExpensesCode()){
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
      bErrorFlag = true;
    }
    if(bErrorFlag)
      return this.objExpensesScreen.GetErrorMessage();
    

    if (aqString.GetLength(eExpensesData.sDescription)== 0)
      bErrorFlag = true;
    
    this.objExpensesScreen.SetDescription(eExpensesData.sDescription);
    Delay(1000);

    this.objNavigationPanel.ClickEnter();
    Delay(1000);
          
    this.Refresh();  
    Delay(1000);
    
    if(bErrorFlag)
      return this.objExpensesScreen.GetErrorMessage(); 
     
    if (!(eExpensesData.iPayAmount > 0))
        bErrorFlag = true;
          
    this.objExpensesScreen.SetAmount(eExpensesData.iPayAmount);
    Delay(1000);
    
    switch(eExpensesData.sSubmitCode) {
      case "Cancel": this.objNavigationPanel.ClickCancel(); Delay(1000); break;
      
      case "Back"  : this.objBackPanel.ClickBack(); Delay(1000); this.Refresh(); Delay(1000);
                     if(this.objExpensesScreen.GetCurrentSelectedField().Equals("DESCRIPTION"))
                      TestLog.Message("Navigated Back to "+this.objExpensesScreen.GetCurrentSelectedField()+" Field");
                     else 
                      return false;
                      
                     this.objBackPanel.ClickBack(); Delay(1000); this.Refresh(); Delay(1000);
                     if(this.objExpensesScreen.GetCurrentSelectedField().Equals("EXPENSE"))
                      TestLog.Message("Navigated Back to "+this.objExpensesScreen.GetCurrentSelectedField()+" Field");
                     else 
                      return false;
                     return true;
                     break;
                     
      default      : this.objNavigationPanel.ClickEnter(); Delay(1000); break;
    }
    
    if(bErrorFlag)
      return this.objExpensesScreen.GetErrorMessage(); 
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputExpensesDetails

expensesInfoForm.prototype.SubmitWithoutSelectingExpensesCode= function () {  

/*----------------------------------------------------------------------------------
  Method      : SubmitWithoutSelectingExpensesCode()
  
  Description : This method Clicks enter in Without Selecting ExpensesCode  
  
  Output      : Clicks enter Without Selecting ExpensesCode if expensesInfoForm Form Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at expensesInfoForm.SubmitWithoutSelectingExpensesCode: The expensesInfoForm does not Exist.",
              message     : this.dlgExpensesInfo + " The expensesInfoForm does not Exist." }             
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);

    return this.objExpensesScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
	  TestLog.Message("Exception at expensesInfoForm.SubmitWithoutSelectingExpensesCode");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitWithoutSelectingExpensesCode

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating expensesInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new expensesInfoForm();  
}
