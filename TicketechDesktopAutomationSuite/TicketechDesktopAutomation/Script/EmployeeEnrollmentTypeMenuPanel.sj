//USEUNIT Utility

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
  
  this.pnlEmpEnrolTypeMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelEmployeeEnrollmentTypeMenu", 2);
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

employeeEnrollmentTypeMenuPanel.prototype.ClickCode = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCode()
  
  Description : This method Clicks the Code button  
  
  Output      : Click on Code button if EmployeeEnrollmentTypeMenu Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("CODE")
  
} //ClickCode

employeeEnrollmentTypeMenuPanel.prototype.ClickFingerPrint = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickFingerPrint()
  
  Description : This method Clicks the Finger Print button  
  
  Output      : Click on Finger Print button if EmployeeEnrollmentTypeMenu Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("FINGERPRINT")
  
} //ClickCode


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

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentTypeMenuPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeEnrollmentTypeMenuPanel();  
}