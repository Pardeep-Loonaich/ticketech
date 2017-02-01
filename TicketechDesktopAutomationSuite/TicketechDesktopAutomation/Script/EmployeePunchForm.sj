//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeePunchForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeePunchForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeePunchForm() { 

/*--------------------------------------------------------------------- 
  Method: employeePunchForm() 
  
  Description: This method will the Instantiate the employeePunchForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeePunch =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePunch", 3000); 
  
  this.InfoScreen = InformationScreen.New();
  //this.employeeInfoScreen = EmployeeInfoScreen.New();
  this.navigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //employeePunchForm

employeePunchForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeePunchForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgEmployeePunch =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePunch", 3000); 
  
    this.infoScreen = InformationScreen.New();
 //   this.employeeInfoScreen = EmployeeInfoScreen.New();
    this.navigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeePunchForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeePunchForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeePunch.Exists;  //Return whether employeePunchForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeePunchForm.prototype.SubmitForm = function () {  

/*--------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks enter button  
  
  Output      : Clicks Enter button if Punch Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeePunch.SubmitForm: The Employee Punch Form does not Exist.",
              message     : this.formEmployeePunch + " The Employee Punch Form does not Exist." }             
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitForm

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeePunchForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeePunchForm();  
}