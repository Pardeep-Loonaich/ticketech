//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------

  Name:EmployeeEnrollmentMenuPanel
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentMenu Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************/

function employeeEnrollmentMenuPanel() { 

/*--------------------------------------------------------------------------------------------- 
  Method: employeeEnrollmentMenuPanel() 
  
  Description: This method will the Instantiate the EmployeeEnrollmentMenu Panel Wrapper Helper
---------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlEmployeeEnrollmentMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelEmployeeEnrollmentMenu", 2);
  this.throwError = false; 
    
} //numericPanel

employeeEnrollmentMenuPanel.prototype.Exists = function () {  

/*---------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeEnrollmentMenuPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlEmployeeEnrollmentMenu.Exists;  //Return whether EmployeeEnrollmentMenuPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentMenuPanel.prototype.ClickAddEmployee = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAddEmployee()
  
  Description : This method Clicks the Add button  
  
  Output      : Click on Add button if EmployeeEnrollmentMenu Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("ADD")
  
} //ClickAddEmployee

employeeEnrollmentMenuPanel.prototype.ClickCorrect = function () {  

/*-----------------------------------------------------------------------------
  Method      : ClickCorrect()
  
  Description : This method Clicks the Correct button  
  
  Output      : Click on Correct button if EmployeeEnrollmentMenu Panel Exists
-----------------------------------------------------------------------------*/ 
  this.Click("CORRECT")
  
} //ClickCorrect

employeeEnrollmentMenuPanel.prototype.ClickCorrectEnrollment = function () {  

/*---------------------------------------------------------------------------------------
  Method      : ClickCorrectEnrollment()
  
  Description : This method Clicks the Correct Enrollment button  
  
  Output      : Click on Correct Enrollment button if EmployeeEnrollmentMenu Panel Exists
---------------------------------------------------------------------------------------*/ 
  this.Click("CORRECT ENROLLMENT")
  
} //ClickCorrectEnrollment

employeeEnrollmentMenuPanel.prototype.ClickDeleteEnrollment = function () {  

/*-----------------------------------------------------------------------------
  Method      : ClickDeleteEnrollment()
  
  Description : This method Clicks the Delete Enrollment button  
  
  Output      : Click on Delete Enrollment button if EmployeeEnrollmentMenu Panel Exists
-----------------------------------------------------------------------------*/ 
  this.Click("DELETE ENROLLMENT")
  
} //ClickDeleteEnrollment

employeeEnrollmentMenuPanel.prototype.Click = function (btnName) {  

/*------------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if EmployeeEnrollmentMenu Panel Exists
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentMenuPanel.Click"+btnName+": The EmployeeEnrollmentMenu Panel does not Exist.",
              message     : this.pnlEmployeeEnrollmentMenu + " Panel does not Exist." }             
    
    Delay(2000);
    objButton =  this.pnlEmployeeEnrollmentMenu.FindChild(["Value", "Visible"], [btnName, true], 2);
    objButton.SetFocus();
    if(objButton.Focus()){
      objButton.Keys("[Enter]");
      Delay(1000);
    }
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*---------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentMenuPanel() class from other units of the project. 
-----------------------------------------------------------------------------------------------------*/

  return new employeeEnrollmentMenuPanel();  
}