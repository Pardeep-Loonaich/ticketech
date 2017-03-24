//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:NoPunchHoursScreen
  
  Description: 
  
  This class has methods and properties to perform the NoPunchHoursScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function noPunchHoursScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: noPunchHoursScreen() 
  
  Description: This method will the Instantiate the NoPunchHoursScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnNoPunchHours =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenNoPunchHours", 2);
  
  this.throwError = false; 
    
} //noPunchHoursScreen

noPunchHoursScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the noPunchHoursScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnNoPunchHours.Exists;  //Return whether noPunchHoursScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

noPunchHoursScreen.prototype.SetPayHours = function (payHour) {  

/*-------------------------------------------------------------------------------
  Method      : SetPayHours()
  
  Description : This method enters the pay hours in the NoPunchHours Screen
  
  Output      : Enters the pay hours in the NoPunchHours Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at noPunchHoursScreen.SetEmployeeID: The Employee Info Screen does not Exist.",
              message     : this.scrnNoPunchHours + " Screen does not Exist." }             
    
    if (payHour !== undefined && payHour !== null)
      this.scrnNoPunchHours.FindChild("WinFormsControlName", "labelTextBox", 2).Keys(payHour);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPayHours

noPunchHoursScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the NoPunchHours Screen 
  
  Output      : Returns the error message displayed in the NoPunchHours Screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at noPunchHoursScreen.GetErrorMessage: The NoPunchHours Screen does not Exist.",
              message     : this.scrnNoPunchHours + " NoPunchHours Screen does not Exist." }             
    
    return this.scrnNoPunchHours.WinFormsObject("screenInformationFooter")
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

  return new noPunchHoursScreen();  
}