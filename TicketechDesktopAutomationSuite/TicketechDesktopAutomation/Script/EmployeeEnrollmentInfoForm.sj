//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT EmployeeEnrollmentIdentificationScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT BackPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentInfoForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeEnrollmentInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: employeeEnrollmentInfoForm() 
  
  Description: This method will the Instantiate the employeeEnrollmentInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeeEnrollmentInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentInfo*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objEmployeeEnrollmentInfoScreen = EmployeeEnrollmentInfoScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objNumericPanel = NumericPanel.New();
  this.objBackPanel = BackPanel.New();
  
  this.throwError = false; 
    
} //employeeEnrollmentInfoForm

employeeEnrollmentInfoForm.prototype.Refresh = function () {  

/*----------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeEnrollmentInfoForm Wrapper   
----------------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgEmployeeEnrollmentInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentInfo*", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objEmployeeEnrollmentInfoScreen = EmployeeEnrollmentInfoScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objNumericPanel = NumericPanel.New();
    this.objBackPanel = BackPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeEnrollmentInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeEnrollmentInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeeEnrollmentInfo.Exists;  //Return whether employeeEnrollmentInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentInfoForm.prototype.InputAndSubmitForm = function (enumEmployeeData) {  

/*-----------------------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters Employee Enrollment Data 
  
  Output      : Enters Employee Enrollment Data if EmployeeEnrollmentInfo Form Exists
-----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentInfoForm.InputAndSubmitForm: The EmployeeEnrollment Info Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentInfo + " The EmployeeEnrollment Info Form does not Exist." }             
    
    this.employeeEnrollmentInfoScreen.SetEmployeeData("EMPLOYEE ID",employeeData.ID);
    Delay(500);
    
    this.navigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.employeeEnrollmentInfoScreen.SetEmployeeData("LAST NAME",employeeData.FirstName);
    Delay(500);
    
    this.navigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.employeeEnrollmentInfoScreen.SetEmployeeData("FIRST NAME",employeeData.LastName);
    Delay(500);
    
    this.navigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.employeeEnrollmentInfoScreen.SetEmployeeData("SOCIAL SECURITY NUMBER",employeeData.SSN);
    Delay(500);
    
    this.navigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitForm

employeeEnrollmentInfoForm.prototype.InputAndSubmitFormWithErrors = function (enumEmployeeData) {  

/*----------------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
    
  Description : This method enters Employee Enrollment Data, that might be invalid
  
  Output      : Enters Employee Enrollment Data if EmployeeEnrollmentInfo Form Exists
-----------------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(enumEmployeeData);
    Delay(500);
    
    this.Refresh();
    Delay(500);
    
    return this.employeeEnrollmentInfoScreen.GetMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitFormWithErrors

function New() {

/*--------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentInfoForm() class from other units of the project. 
----------------------------------------------------------------------------------------------------*/

  return new employeeEnrollmentInfoForm();  
}