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
  
  this.throwError = false; 
    
} //employeeEnrollmentMenuForm

employeeEnrollmentMenuForm.prototype.Refresh = function () {  

/*----------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeEnrollmentMenuForm Wrapper   
-----------------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgEmployeeEnrollmentMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentMenu", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.employeeEnrollmentMenuPanel = EmployeeEnrollmentMenuPanel.New();
    this.employeeEnrollmentMenuScreen = EmployeeEnrollmentMenuScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.backPanel = BackPanel.New();
    this.cursorsPanel = CursorsPanel.New();
        
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
    
    this.employeeEnrollmentMenuPanel.ClickAdd();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToAddEmployeeForm

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeEnrollmentMenuForm();  
}