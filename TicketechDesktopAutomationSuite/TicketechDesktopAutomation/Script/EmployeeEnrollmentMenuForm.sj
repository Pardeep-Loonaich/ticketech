//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT EmployeeEnrollmentMenuPanel
//USEUNIT EmployeeEnrollmentMenuScreen
//USEUNIT BackPanel
//USEUNIT CursorsPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentMenuForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentMenuForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeEnrollmentMenuForm() { 

/*--------------------------------------------------------------------- 
  Method: employeeEnrollmentMenuForm() 
  
  Description: This method will the Instantiate the employeeEnrollmentMenuForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeeEnrollmentMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentMenu", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.employeeEnrollmentMenuPanel = EmployeeEnrollmentMenuPanel.New();
  this.employeeEnrollmentMenuScreen = EmployeeEnrollmentMenuScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.backPanel = BackPanel.New();
  this.cursorsPanel = CursorsPanel.New();
  this.sTitle = this.employeeEnrollmentMenuScreen.GetTitle();
  
  this.throwError = false; 
    
} //employeeEnrollmentMenuForm

employeeEnrollmentMenuForm.prototype.Refresh = function () {  

/*----------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeEnrollmentMenuForm Wrapper   
-----------------------------------------------------------------------------------------*/  
  try {
   
    this.dlgEmployeeEnrollmentMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentMenu", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.employeeEnrollmentMenuPanel = EmployeeEnrollmentMenuPanel.New();
    this.employeeEnrollmentMenuScreen = EmployeeEnrollmentMenuScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.backPanel = BackPanel.New();
    this.cursorsPanel = CursorsPanel.New();
    this.sTitle = this.employeeEnrollmentMenuScreen.GetTitle();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeEnrollmentMenuForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeEnrollmentMenuForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeeEnrollmentMenu.Exists;  //Return whether employeeEnrollmentMenuForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentMenuForm.prototype.NavigateToAddEmployeeForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToAddEmployeeForm()
  
  Description : This method Clicks Add button  
  
  Output      : Clicks Add button if EmployeeEnrollmentMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeeEnrollmentMenu.NavigateToAddEmployeeForm: The EmployeeEnrollmentMenu Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentMenu + " The EmployeeEnrollmentMenu Form does not Exist." }             
    
    this.employeeEnrollmentMenuPanel.ClickAddEmployee();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToAddEmployeeForm


employeeEnrollmentMenuForm.prototype.NaviagteToUpdateEmployeeDataForm = function (empId) {  

/*------------------------------------------------------------------------------------------------------------------------------
  Method      : NaviagteToUpdateEmployeeDataForm()
  
  Description : This method finds the employee whose data is to be corrected and Clicks Correct button  
  
  Output      : Finds the employee whose data is to be corrected and Clicks Correct button if EmployeeEnrollmentMenu Form Exists
-------------------------------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeeEnrollmentMenu.NavigateToCorrectEmployeeForm: The EmployeeEnrollmentMenu Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentMenu + " The EmployeeEnrollmentMenu Form does not Exist." }
                 
    this.employeeEnrollmentMenuScreen.MoveToEmployeeDataRow(empId);
    this.employeeEnrollmentMenuPanel.ClickCorrect();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NaviagteToUpdateEmployeeDataForm

employeeEnrollmentMenuForm.prototype.NavigateToCorrectEnrollmentForm = function (empId) {  

/*------------------------------------------------------------------------------------------------------------------------------
  Method      : NaviagteToCorrectEnrollmentForm()
  
  Description : This method finds the employee whose Enrollment type is to be corrected and Clicks Correct Enrollment button  
  
  Output      : Finds the employee whose Enrollment type is to be corrected and Clicks Correct button if EmployeeEnrollmentMenu Form Exists
-------------------------------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeeEnrollmentMenu.NavigateToCorrectEmployeeForm: The EmployeeEnrollmentMenu Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentMenu + " The EmployeeEnrollmentMenu Form does not Exist." }
                 
    this.employeeEnrollmentMenuScreen.MoveToEmployeeDataRow(empId);
    this.employeeEnrollmentMenuPanel.ClickCorrectEnrollment();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToCorrectEnrollmentForm

employeeEnrollmentMenuForm.prototype.NavigateToDeleteEnrollmentForm = function (empId) {  

/*------------------------------------------------------------------------------------------------------------------------------
  Method      : NavigateToDeleteEnrollmentForm()
  
  Description : This method finds the employee whose data is to be deleted and Clicks Delete Enrollment button  
  
  Output      : Finds the employee whose Enrollment type is to be deleted and Clicks Delete Enrollment button if EmployeeEnrollmentMenu Form Exists
-------------------------------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeeEnrollmentMenu.NavigateToDeleteEnrollmentForm: The EmployeeEnrollmentMenu Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentMenu + " The EmployeeEnrollmentMenu Form does not Exist." }
                 
    this.employeeEnrollmentMenuScreen.MoveToEmployeeDataRow(empId);
    this.employeeEnrollmentMenuPanel.ClickDeleteEnrollment();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToDeleteEnrollmentForm



function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeEnrollmentMenuForm();  
}