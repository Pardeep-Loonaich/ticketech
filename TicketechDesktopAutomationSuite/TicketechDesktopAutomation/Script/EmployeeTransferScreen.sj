//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeTransferScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeeTransferScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function employeeTransferScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: employeeTransferScreen() 
  
  Description: This method will the Instantiate the EmployeeTransferScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmployeeTransfer =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeeTransfer", 3);
  
  this.throwError = false; 
    
} //employeeTransferScreen

employeeTransferScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeTransferScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmployeeTransfer.Exists;  //Return whether employeeTransferScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at employeeTransferScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeTransferScreen.prototype.SetLocationCode = function (code) {  

/*-------------------------------------------------------------------------------
  Method      : SetLocationCode()
  
  Description : This method enters the Location Code in the Employee Transfer screen
  
  Output      : Enters the Location Code  in the Employee Transfer screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeTransferScreen.SetLocationCode: The EmployeeTransfer Screen does not Exist.",
              message     : this.scrnEmployeeTransfer + " Screen does not Exist." }             
    
    if (code !== undefined && code !== null)
      this.scrnEmployeeTransfer.FindChild("WinFormsControlName", "maskedTextBoxInfo", 1).Keys(code);
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at employeeTransferScreen.SetLocationCode "+code);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetLocationCode

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeTransferScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new employeeTransferScreen();  
}