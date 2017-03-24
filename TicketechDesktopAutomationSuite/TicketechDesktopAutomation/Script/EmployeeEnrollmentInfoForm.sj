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
	TestLog.Messgae("Exception at EmployeeEnrollmentInfoForm.Exists");
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
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("FIRST NAME", objTestData.sFirstName);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("LAST NAME", objTestData.sLastName);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("SOCIAL SECURITY NUMBER", objTestData.iSSNum);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("BIRTHDAY", objTestData.sBirthDate);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitForm

employeeEnrollmentInfoForm.prototype.InputAndSubmitFormWithErrors = function (objTestData) {  

/*----------------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
    
  Description : This method enters Employee Enrollment Data, that might be invalid
  
  Output      : Enters Employee Enrollment Data if EmployeeEnrollmentInfo Form Exists
-----------------------------------------------------------------------------------*/  
  try {
    objMessage = null;  //Initializing the Message Object
  
    this.lastError = {};
    
    if (!this.Exists()) // Verifying if employeeEnrollmentInfoForm exists, if not throws below error message
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentInfoForm.InputAndSubmitFormWithErrors: The EmployeeEnrollment Info Form does not Exist.",
              message     : this.dlgEmployeeEnrollmentInfo + " The EmployeeEnrollment Info Form does not Exist." }; 
              
    //Entering Test Data in employeeEnrollmentInfoForm           
    if(objMessage===null || objMessage==="THE SYSTEM IS WAITING FOR YOUR NEXT SELECTION.") {
    
      this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("EMPLOYEE ID", objTestData.sEmpId);
      Delay(1000);
    
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
      
      this.Refresh();
      
      objMessage = this.objEmployeeEnrollmentInfoScreen.GetMessage();
    } else {
      this.objNavigationPanel.ClickCancel(); Delay(1000);
    }
    
    if(objMessage===null || objMessage==="THE SYSTEM IS WAITING FOR YOUR NEXT SELECTION.") { 

      this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("FIRST NAME", objTestData.sFirstName);
      Delay(1000);
    
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
      
      this.Refresh();
      
      objMessage = this.objEmployeeEnrollmentInfoScreen.GetMessage();
    } else {
      this.objNavigationPanel.ClickCancel(); Delay(1000);
    }
      
    if (objMessage === null || objMessage === "THE SYSTEM IS WAITING FOR YOUR NEXT SELECTION.") { 
    
      this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("LAST NAME", objTestData.sLastName);
      Delay(1000);
    
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
        
      this.Refresh();
        
      objMessage = this.objEmployeeEnrollmentInfoScreen.GetMessage();
      
    } else {
      this.objNavigationPanel.ClickCancel(); Delay(1000);
    }
        
    if(objMessage === null || objMessage === "THE SYSTEM IS WAITING FOR YOUR NEXT SELECTION.") { 
          
      this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("SOCIAL SECURITY NUMBER", objTestData.iSSNum);
      Delay(1000);
          
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
          
      this.Refresh();
          
      objMessage = this.objEmployeeEnrollmentInfoScreen.GetMessage();
    } else {
      this.objNavigationPanel.ClickCancel(); Delay(1000);
    }
          
    if(objMessage === null || objMessage === "THE SYSTEM IS WAITING FOR YOUR NEXT SELECTION.") { 
            
      this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("BIRTHDAY", objTestData.sBirthDate);
      Delay(1000);
    
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
            
      this.Refresh();
          
      objMessage = this.objEmployeeEnrollmentInfoScreen.GetMessage();
      if(objMessage !== null || objMessage !== "THE SYSTEM IS WAITING FOR YOUR NEXT SELECTION."){
        this.objNavigationPanel.ClickCancel(); Delay(1000);
      } 
    }      
    return objMessage;
    
  } //End try
  
  catch (exception) {
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
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("LAST NAME", objTestData.sLastName);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("SOCIAL SECURITY NUMBER", objTestData.iSSNum);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.objEmployeeEnrollmentInfoScreen.SetEmployeeData("BIRTHDAY", objTestData.sBirthDate);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
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

employeeEnrollmentInfoForm.prototype.CancelForm = function () {  

/*--------------------------------------------------------------------------  
  Method      : CancelForm()
  
  Description : This method Clicks Cancel button  
  
  Output      : Clicks Cancel button if employeeEnrollmentInfoForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentInfoForm.CancelForm: The Employee Enrollment Info Form does not Exist.",
              message     : this.dlgEmpEnrolInfo + " The Employee Enrollment Info Form does not Exist." }              
    
    this.objNavigationPanel.ClickCancel();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //CancelForm

employeeEnrollmentInfoForm.prototype.MoveToFirstField = function () {  

/*--------------------------------------------------------------------------  
  Method      : MoveToFirstField()
  
  Description : This method Clicks back button to move to first field
  
  Output      : Clicks back button if employeeEnrollmentInfoForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentInfoForm.MoveToFirstField: The Employee Enrollment Info Form does not Exist.",
              message     : this.dlgEmpEnrolInfo + " The Employee Enrollment Info Form does not Exist." }              
    
    this.objBackPanel.ClickCancel();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //CancelForm