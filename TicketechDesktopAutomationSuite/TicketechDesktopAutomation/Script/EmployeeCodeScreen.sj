//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeCodeScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeeCodeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function employeeCodeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: employeeCodeScreen() 
  
  Description: This method will the Instantiate the EmployeeCodeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmployeeCode =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeeCode", 3);
  
  this.throwError = false; 
    
} //employeeCodeScreen

employeeCodeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeCodeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmployeeCode.Exists;  //Return whether employeeCodeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeCodeScreen.prototype.SetEmployeeCode = function (code) {  

/*-------------------------------------------------------------------------------
  Method      : SetEmployeeCode()
  
  Description : This method enters the Code in the Employee Code screen
  
  Output      : Enters the Code  in the Employee Code screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeCodeScreen.SetEmployeeCode: The Employee Code Exist.",
              message     : this.scrnEmployeeCode + " Screen Exist." }             
    
    if (code !== undefined && code !== null)
      this.scrnEmployeeCode.FindChild("Caption","CODE",1).FindChild("WinFormsControlName", "labelTextBox", 1).Keys(code);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetEmployeeCode

employeeCodeScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the code screen 
  
  Output      : Returns the error message displayed in the emp code screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeCodeScreen.GetErrorMessage: The Code screen does not Exist.",
              message     : this.scrnEmployeeCode + " Code screen does not Exist." }             
    
    return this.scrnEmployeeCode.WinFormsObject("screenInformationFooter")
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
  This method is for instantiating employeeCodeForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new employeeCodeScreen();  
}