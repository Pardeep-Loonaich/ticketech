//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT EmployeeEnrollmentInfoScreen
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
  
    this.dlgEmployeeEnrollmentInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeEnrollmentInfo*", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objEmployeeEnrollmentInfoScreen = EmployeeEnrollmentInfoScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objNumericPanel = NumericPanel.New();
    this.objBackPanel = BackPanel.New();
        
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at EmployeeEnrollmentInfoForm.Refresh");
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
	TestLog.Message("Exception at EmployeeEnrollmentInfoForm.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentInfoForm.prototype.InputAndSubmitForm = function (objTestData) {  

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
              message     : this.dlgEmployeeEnrollmentInfo + " The EmployeeEnrollment Info Form does not Exist." };             
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("EMPLOYEE ID", objTestData.sEmpId);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("FIRST NAME", objTestData.sFirstName);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("LAST NAME", objTestData.sLastName);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("SOCIAL SECURITY NUMBER", objTestData.iSSNum);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("BIRTHDAY", objTestData.sBirthDate);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at EmployeeEnrollmentInfoForm.InputAndSubmitForm");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitForm

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
    
    return this.objEmployeeEnrollmentInfoScreen.GetMessage();
    
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at EmployeeEnrollmentInfoForm.InputAndSubmitFormWithErrors");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitFormWithErrors

employeeEnrollmentInfoForm.prototype.UpdateAndSubmitForm = function (objTestData) {  

/*-----------------------------------------------------------------------------------
  Method      : UpdateAndSubmitForm()
  
  Description : This method Updates Employee Enrollment Data 
  
  Output      : Updates Employee Enrollment Data if EmployeeEnrollmentInfo Form Exists
-----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentInfoForm.UpdateAndSubmitForm: The EmployeeEnrollment Info Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentInfo + " The EmployeeEnrollment Info Form does not Exist." };             
    
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("FIRST NAME", objTestData.sFirstName);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("LAST NAME", objTestData.sLastName);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("SOCIAL SECURITY NUMBER", objTestData.iSSNum);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("BIRTHDAY", objTestData.sBirthDate);
    Delay(500);
    
    this.objNavigationPanel.ClickEnter();
    Delay(500);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //UpdateAndSubmitForm

function New() {

/*--------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentInfoForm() class from other units of the project. 
----------------------------------------------------------------------------------------------------*/

  return new employeeEnrollmentInfoForm();  
}