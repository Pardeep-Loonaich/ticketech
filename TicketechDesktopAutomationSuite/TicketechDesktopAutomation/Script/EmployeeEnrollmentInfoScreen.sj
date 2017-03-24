//USEUNIT Utility

/******************************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentInfoScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentInfoScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************/

function employeeEnrollmentInfoScreen() { 

/*--------------------------------------------------------------------------------------------- 
  Method: employeeEnrollmentInfoScreen() 
  
  Description: This method will Instantiate the EmployeeEnrollmentInfoScreen Wrapper Helper
----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmpEnrolInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeeEnrollmentInfo", 2);
  
  this.throwError = false; 
    
} //employeeEnrollmentInfoScreen

employeeEnrollmentInfoScreen.prototype.Exists = function () {  

/*----------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the EmployeeEnrollmentInfoScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmpEnrolInfo.Exists;  //Return whether EmployeeEnrollmentInfoScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentInfoScreen.prototype.SetEmployeeData = function (sCaption,sEmpData) {  

/*-------------------------------------------------------------------------------------------------------
  Method      : SetEmployeeData()
  
  Description : This method enters the EmployeeData in the given field of Employee Enrollment Info screen
  
  Output      : Enters the EmployeeData in the given field of Employee Enrollment Info screen
-------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentInfoScreen.SetEmployeeData: The Employee Enrollment Info screen does not Exist.",
              message     : this.scrnEmpEnrolInfo + " Screen does not Exist." }             
    
    if (sEmpData !== undefined && sEmpData !== null)
      this.scrnEmpEnrolInfo.FindChild("Caption", sCaption,2).FindChild("WinFormsControlName","maskedTextBoxInfo",0).Clear();
      this.scrnEmpEnrolInfo.FindChild("Caption", sCaption,2).FindChild("WinFormsControlName","maskedTextBoxInfo",0).Keys(sEmpData);
      
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetEmployeeData


employeeEnrollmentInfoScreen.prototype.GetMessage = function () {  

/*-----------------------------------------------------------------------------------------
  Method      : GetMessage()
  
  Description : This method returns the message displayed in the EmployeeEnrollment Info screen 
  
  Output      : Returns the the message displayed in the EmployeeEnrollment Info screen 
------------------------------------------------------------------------------------------*/  
  try {
    Message = null;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeEnrollmentInfoScreen.GetMessage: The EmployeeEnrollment Info screen does not Exist.",
              message     : this.scrnEmpEnrolInfo + " Info does not Exist." }  
    
    objMessage = this.scrnEmpEnrolInfo.FindChild("WinFormsControlName","labelInformation",3); 
             
    if(objMessage.Exists)
      Message = objMessage.WndCaption;
    
    return Message;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetMessage

function New() {

/*------------------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating EmployeeEnrollmentInfoScreen() class from other units of the project. 
------------------------------------------------------------------------------------------------------*/

  return new employeeEnrollmentInfoScreen();  
}