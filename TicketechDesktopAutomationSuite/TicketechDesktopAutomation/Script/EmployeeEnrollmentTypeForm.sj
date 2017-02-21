//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT EmployeeEnrollmentTypeScreen
//USEUNIT EmployeeEnrollmentTypeMenuPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentTypeForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentTypeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeEnrollmentTypeForm() { 

/*-------------------------------------------------------------------------------- 
  Method: employeeEnrollmentTypeForm() 
  
  Description: This method will Instantiate the EmployeeEnrollmentTypeForm Wrapper
--------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmpEnrolType =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentType", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objEmpEnrolTypeMenuPanel =  EmployeeEnrollmentTypeMenuPanel.New();
  this.objEmpEnrolTypeScreen =  EmployeeEnrollmentTypeScreen.New();
  
  this.throwError = false; 
    
} //timekeeperMenuForm

employeeEnrollmentTypeForm.prototype.Refresh = function () {  

/*------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will re-instantiate the EmployeeEnrollmentTypeForm Wrapper   
------------------------------------------------------------------------------------*/  
  try {
  
    this.dlgEmpEnrolType =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentType", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objEmpEnrolTypeMenuPanel =  EmployeeEnrollmentTypeMenuPanel.New();
    this.objEmpEnrolTypeScreen =  EmployeeEnrollmentTypeScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeEnrollmentTypeForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the EmployeeEnrollmentTypeForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmpEnrolType.Exists;  //Return whether EmployeeEnrollmentTypeForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


employeeEnrollmentTypeForm.prototype.SelectFingerPrint = function () {  

/*------------------------------------------------------------------------------
  Method      : SelectFingerPrint
  
  Description : This method Clicks on the given Finger Print button  
  
  Output      : Clicks the given button if Employee Enrollment Type Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentTypeForm.SelectFingerPrint: The Employee Enrollment Type Form does not Exist.",
              message     : this.dlgEmpEnrolType + " The Employee Enrollment Type Form does not Exist." }             
    
    this.objEmpEnrolTypeMenuPanel.Click("FINGERPRINT");
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectFingerPrintType

employeeEnrollmentTypeForm.prototype.SelectCode = function () {  

/*------------------------------------------------------------------------------
  Method      : SelectCode
  
  Description : This method Clicks on the given Code button  
  
  Output      : Clicks the given button if Employee Enrollment Type Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentTypeForm.SelectCode: The Employee Enrollment Type Form does not Exist.",
              message     : this.dlgEmpEnrolType + " The Employee Enrollment Type Form does not Exist." }             
    
    this.objEmpEnrolTypeMenuPanel.Click("CODE");
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectCode


employeeEnrollmentTypeForm.prototype.SubmitForm = function () {  

/*--------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks enter button  
  
  Output      : Clicks Enter button if employeeEnrollmentTypeForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentTypeForm.SubmitForm: The Employee Enrollment Type Form does not Exist.",
              message     : this.dlgEmpEnrolType + " The Employee Enrollment Type Form does not Exist." }      
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitForm

employeeEnrollmentTypeForm.prototype.CancelForm = function () {  

/*--------------------------------------------------------------------------  
  Method      : CancelForm()
  
  Description : This method Clicks Cancel button  
  
  Output      : Clicks Cancel button if employeeEnrollmentTypeForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentTypeForm.CancelForm: The Employee Enrollment Type Form does not Exist.",
              message     : this.dlgEmpEnrolType + " The Employee Enrollment Type Form does not Exist." }              
    
    this.objNavigationPanel.ClickCancel();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //CancelForm


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating EmployeeEnrollmentTypeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeEnrollmentTypeForm();  
}