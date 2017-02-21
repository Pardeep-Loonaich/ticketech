//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:EmployeePrintTimecardScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeePrintTimecardScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function employeePrintTimecardScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: employeePrintTimecardScreen() 
  
  Description: This method will the Instantiate the EmployeePrintTimecardScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnemployeePrintTimecard =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeePrintTimecard", 2);
  
  this.throwError = false; 
    
} //employeePrintTimecardScreen

employeePrintTimecardScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeePrintTimecardScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnemployeePrintTimecard.Exists;  //Return whether employeePrintTimecardScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeePrintTimecardScreen.prototype.SetEmployeeID = function (empID) {  

/*-------------------------------------------------------------------------------
  Method      : SetEmployeeID()
  
  Description : This method enters the Emp ID in the Employee PrintTimecard screen
  
  Output      : Enters the Emp ID in the Employee PrintTimecard screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeePrintTimecardScreen.SetEmployeeID: The Employee PrintTimecard Screen does not Exist.",
              message     : this.scrnemployeePrintTimecard + " Screen does not Exist." }             
    
    if (empID !== undefined && empID !== null)
      this.scrnemployeePrintTimecard.FindChild("WinFormsControlName", "labelTextBox", 2).Keys(empID);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetEmployeeID

employeePrintTimecardScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the EmployeePrintTimecard screen 
  
  Output      : Returns the error message displayed in the EmployeePrintTimecard screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeePrintTimecardScreen.GetErrorMessage: The EmployeePrintTimecard screen does not Exist.",
              message     : this.scrnemployeePrintTimecard + " EmployeePrintTimecard Screen does not Exist." }             
    
    return this.scrnemployeePrintTimecard.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new employeePrintTimecardScreen();  
}