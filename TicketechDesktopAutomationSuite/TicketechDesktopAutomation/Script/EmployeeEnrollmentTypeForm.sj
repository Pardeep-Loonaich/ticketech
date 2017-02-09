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

function EmployeeEnrollmentTypeForm() { 

/*-------------------------------------------------------------------------------- 
  Method: EmployeeEnrollmentTypeForm() 
  
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

EmployeeEnrollmentTypeForm.prototype.Refresh = function () {  

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

EmployeeEnrollmentTypeForm.prototype.Exists = function () {  

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

EmployeeEnrollmentTypeForm.prototype.SelectEnrollmentType = function () {  

/*------------------------------------------------------------------------------
  Method      : SelectEnrollmentType
  
  Description : This method Clicks on the given EnrollmentType button  
  
  Output      : Clicks the given button if Employee Enrollment Type Form Exists
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentTypeForm.SelectEnrollmentType: The Employee Enrollment Type Form does not Exist.",
              message     : this.dlgEmpEnrolType + " The Employee Enrollment Type Form does not Exist." }             
    
    this.EmployeeEnrollmentTypeMenuPanel.Click("CODE");
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitCode

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating EmployeeEnrollmentTypeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new EmployeeEnrollmentTypeForm();  
}