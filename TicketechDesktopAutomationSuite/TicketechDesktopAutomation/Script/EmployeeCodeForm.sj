//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT EmployeeCodeScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeCodeForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeeCodeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeCodeForm() { 

/*--------------------------------------------------------------------- 
  Method: employeeCodeForm() 
  
  Description: This method will the Instantiate the employeeCodeForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeeCode =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeCode", 3000); 
  
  this.codeScreen = InformationScreen.New();
  this.employeeCodeScreen = EmployeeCodeScreen.New();
  this.navigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //employeeCodeForm

employeeCodeForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeCodeForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgEmployeeCode =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeCode", 3000); 
  
    this.codeScreen = InformationScreen.New();
    this.employeeCodeScreen = EmployeeCodeScreen.New();
    this.navigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeCodeForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeCodeForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeeCode.Exists;  //Return whether employeeCodeForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeCodeForm.prototype.InputAndSubmitForm = function (code) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters Employee Code  
  
  Output      : Enters Code if Employee Code Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeeCode.InputandSubmitForm: The Employee Info Form does not Exist.",
              message     : this.dlgEmployeeCode + " The Employee Info Form does not Exist." }             
    
    this.employeeCodeScreen.SetEmployeeCode(code);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitForm

employeeCodeForm.prototype.InputAndSubmitFormWithErrors = function (code) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
  
  Description : This method enters Code and click enter button
  
  Output      : Enters Emp ID if Employee Code Form and click enter button
--------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(code);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.employeeCodeScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitFormWithErrors()

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeCodeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeCodeForm();  
}
