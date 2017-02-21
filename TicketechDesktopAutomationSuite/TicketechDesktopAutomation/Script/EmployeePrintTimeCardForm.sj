//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT BackPanel
//USEUNIT EmployeePrintTimecardScreen
//USEUNIT PrintTimecardOptionsPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:Employee PrintTimecardForm
  
  Description: 
  
  This class has methods and properties to perform the Employee PrintTimecardForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeePrintTimecardForm() { 

/*-------------------------------------------------------------------------- 
  Method: employeePrintTimecardForm() 
  
  Description: This method will the Instantiate the employeePrintTimecardForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgemployeePrintTimecard =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePrintTimecard", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.employeePrintTimecardScreen = EmployeePrintTimecardScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.printTimecardOptionsPanel= PrintTimecardOptionsPanel.New();
  this.backPanel= BackPanel.New();
  
  this.throwError = false; 
    
} //employee PrintTimecardForm

employeePrintTimecardForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employee PrintTimecardForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgemployeePrintTimecard =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePrintTimecard", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.employeePrintTimecardScreen = EmployeePrintTimecardScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.printTimecardOptionsPanel= PrintTimecardOptionsPanel.New();
    this.backPanel= BackPanel.New();
     
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeePrintTimecardForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employee PrintTimecardForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgemployeePrintTimecard.Exists;  //Return whether employee PrintTimecardForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeePrintTimecardForm.prototype.InputAndSubmitForm = function (empID) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters Employee ID  
  
  Output      : Enters Emp ID if Employee Print Timecard Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeePrintTimecard.SetEmployeeID: The Employee Print Timecard Form does not Exist.",
              message     : this.dlgemployeePrintTimecard + " The Employee Print Timecard Form does not Exist." }             
    
    this.employeePrintTimecardScreen.SetEmployeeID(empID);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitForm

employeePrintTimecardForm.prototype.InputAndSubmitFormWithErrors = function (empID) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
  
  Description : This method enters Employee ID and click enter button
  
  Output      : Enters Emp ID in Employee Print Timecard Form and click enter button
--------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(empID);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.employeePrintTimecardScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitFormWithErrors

employeePrintTimecardForm.prototype.NavigateToAllEmployees = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToAllEmployees()
  
  Description : This method clicks All Employees button
  
  Output      : Clicks All Employees button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeePrintTimecard.NavigateToAllEmployees: The Employee Print Timecard Form does not Exist.",
              message     : this.dlgemployeePrintTimecard + " The Employee Print Timecard Form does not Exist." }             
    
    this.printTimecardOptionsPanel.ClickAllEmployees();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToAllEmployees


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeePrintTimecardForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeePrintTimecardForm();  
}