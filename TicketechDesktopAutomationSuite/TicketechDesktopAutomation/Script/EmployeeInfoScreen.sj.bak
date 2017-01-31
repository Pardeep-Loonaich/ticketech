//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeInfoScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeeInfoScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function employeeInfoScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: employeeInfoScreen() 
  
  Description: This method will the Instantiate the EmployeeInfoScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmployeeInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeeInfo", 3);
  
  this.throwError = false; 
    
} //mainScreen

employeeInfoScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeInfoScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmployeeInfo.Exists;  //Return whether employeeInfoScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeInfoScreen.prototype.SetEmployeeID = function (empID) {  

/*-------------------------------------------------------------------------------
  Method      : SetEmployeeID()
  
  Description : This method enters the Emp ID in the Employee Info screen
  
  Output      : Enters the Emp ID in the Employee Info screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeInfoScreen.SetEmployeeID: The Employee Info does not Exist.",
              message     : this.scrnEmployeeInfo + " Screen does not Exist." }             
    
    if (empID !== undefined && empID !== null)
      this.scrnEmployeeInfo.FindChild("WinFormsControlName", "labelTextBox", 1000).Keys(empID);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetEmployeeID

employeeInfoScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the info screen 
  
  Output      : Returns the error message displayed in the emp info screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeInfoScreen.GetErrorMessage: The Info screen does not Exist.",
              message     : this.scrnInfo + " Info does not Exist." }             
    
    return this.scrnEmployeeInfo.WinFormsObject("screenInformationFooter")
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

  return new employeeInfoScreen();  
}