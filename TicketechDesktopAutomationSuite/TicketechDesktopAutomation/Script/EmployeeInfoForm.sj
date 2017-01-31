﻿//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT EmployeeInfoScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:MainDialog
  
  Description: 
  
  This class has methods and properties to perform the EmployeeInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: employeeInfoForm() 
  
  Description: This method will the Instantiate the employeeInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeeInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeInfo", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.employeeInfoScreen = EmployeeInfoScreen.New();
  this.navigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //employeeInfoForm

employeeInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgEmployeeInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeInfo", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.employeeInfoScreen = EmployeeInfoScreen.New();
    this.navigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeeInfo.Exists;  //Return whether employeeInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeInfoForm.prototype.InputandSubmitForm = function (empID) {  

/*--------------------------------------------------------------------------
  Method      : SetEmployeeID()
  
  Description : This method enters Employee ID  
  
  Output      : Enters Emp ID if Employee Info Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeeInfo.SetEmployeeID: The Employee Info Form does not Exist.",
              message     : this.formEmployeeInfo + " The Employee Info Form does not Exist." }             
    
    this.employeeInfoScreen.SetEmployeeID(empID);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitForm

employeeInfoForm.prototype.InputandSubmitFormWithErrors = function (empID) {  

/*--------------------------------------------------------------------------
  Method      : InputandSubmitFormWithErrors()
  
  Description : This method enters Employee ID and click enter button
  
  Output      : Enters Emp ID if Employee Info Form and click enter button
--------------------------------------------------------------------------*/  
  try {
  
    this.InputandSubmitForm(empID);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.employeeInfoScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickAboutTicketech

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeInfoForm();  
}