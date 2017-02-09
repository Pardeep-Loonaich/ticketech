﻿//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentTypeMenuPanel
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentTypeMenu panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeEnrollmentTypeMenuPanel() { 

/*--------------------------------------------------------------------------- 
  Method: employeeEnrollmentTypeMenuPanel() 
  
  Description: This method will the Instantiate the employeeEnrollmentTypeMenuPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlEmpEnrolTypeMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelEmployeeEnrollmentTypeMenu", 2000);
  this.throwError = false; 
    
} //employeeEnrollmentTypeMenuPanel

employeeEnrollmentTypeMenuPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeEnrollmentTypeMenuPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlEmpEnrolTypeMenu.Exists;  //Return whether employeeEnrollmentTypeMenuPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentTypeMenuPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if EmployeeEnrollmentTypeMenu Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentTypeMenuPanel.Click"+btnName+": The EmployeeEnrollmentTypeMenu Panel does not Exist.",
              message     : this.pnlEmpEnrolTypeMenu + " Panel does not Exist." }             
    
    this.pnlEmpEnrolTypeMenu.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

employeeEnrollmentTypeMenuPanel.prototype.ClickYes = function () {  

/*-----------------------------------------------------------------
  Method      : ClickYes()
  
  Description : This method Clicks the Yes button  
  
  Output      : Click on Yes button if EmployeeEnrollmentTypeMenu Panel Exists
-----------------------------------------------------------------*/  
  this.Click("YES");
      
} //ClickYes

employeeEnrollmentTypeMenuPanel.prototype.ClickNo = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNo()
  
  Description : This method Clicks the No button  
  
  Output      : Click on No button if EmployeeEnrollmentTypeMenu Panel Exists
-----------------------------------------------------------------*/  
  this.Click("NO");
      
} //ClickNo

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentTypeMenuPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeEnrollmentTypeMenuPanel();  
}