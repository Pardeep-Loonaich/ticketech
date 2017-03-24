//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomeScreen
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function otherIncomeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: otherIncomeScreen() 
  
  Description: This method will the Instantiate the OtherIncomeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnOtherIncome =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenOtherIncome", 2);
  
  this.throwError = false; 
    
} //otherIncomeScreen

otherIncomeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnOtherIncome.Exists;  //Return whether otherIncomeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

otherIncomeScreen.prototype.SetDescription = function (sDescription) {  

/*-------------------------------------------------------------------------------
  Method      : SetDescription()
  
  Description : This method enters the Description in the Other Income Screen
  
  Output      : Enters the Description in the Other Income Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeScreen.SetDescription: The Other Income Screen does not Exist.",
              message     : this.scrnOtherIncome + " Screen does not Exist." }             
    
    if (sDescription !== undefined && sDescription !== null)
    this.scrnOtherIncome.FindChild("WinFormsControlName", "textBoxInfo", 2).Keys(sDescription);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetDescription

otherIncomeScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the OtherIncome screen
  
  Output      : Returns the error message displayed in the OtherIncome screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeScreen.GetErrorMessage: The OtherIncome screen does not Exist.",
              message     : this.scrnOtherIncome + " OtherIncome Screen does not Exist." }             
    
    return this.scrnOtherIncome.WinFormsObject("screenInformationFooter").WinFormsObject("labelInformation").WndCaption;
    
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

  return new otherIncomeScreen();  
}