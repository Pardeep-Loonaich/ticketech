//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentTypeScreen
  
  Description: 
  
  This class has methods and properties to perform the employeeEnrollmentTypeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function employeeEnrollmentTypeScreen() { 

/*------------------------------------------------------------------------------- 
  Method: employeeEnrollmentTypeScreen() 
  
  Description: This method will Instantiate the employeeEnrollmentTypeScreen Wrapper Helper
--------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmployeeEnrollmentType =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeeEnrollmentType", 2);
  this.throwError = false; 
    
} //employeeEnrollmentTypeScreen

employeeEnrollmentTypeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeEnrollmentType Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmployeeEnrollmentType.Exists;  //Return whether employeeEnrollmentTypeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentTypeScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the employeeEnrollmentType screen 
  
  Output      : Returns the current Title labelled in the employeeEnrollmentType screen 
-------------------------------------------------------------------------------*/  
  return   this.GetText("labelTitle");
      
} //GetTitle

employeeEnrollmentTypeScreen.prototype.GetFooterMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the current FooterMessage in the employeeEnrollmentType screen 
  
  Output      : Returns the current FooterMessage in the employeeEnrollmentType screen 
-------------------------------------------------------------------------------*/  
  return this.GetText("labelInformation");
      
} //GetFooterMessage

employeeEnrollmentTypeScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the employeeEnrollmentType screen 
  
  Output      : Returns the label of the given object in the employeeEnrollmentType screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentTypeScreen.Get"+objControlName+": The EmployeeEnrollmentType screen does not Exist.",
              message     : this.scrnEmployeeEnrollmentType + " Screen does not Exist." }             
    
    return this.scrnEmployeeEnrollmentType.FindChild("WinFormsControlName", objControlName, 2).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentTypeScreen() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeEnrollmentTypeScreen();  
}
