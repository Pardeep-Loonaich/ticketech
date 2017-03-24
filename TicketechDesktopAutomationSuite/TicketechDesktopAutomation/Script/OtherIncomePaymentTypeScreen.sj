//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomePaymentTypeScreen
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomePaymentTypeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function otherIncomePaymentTypeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: otherIncomePaymentTypeScreen() 
  
  Description: This method will the Instantiate the OtherIncomePaymentTypeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnOtherIncomePaymentType =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenOtherIncomePaymentType", 2);
  
  this.throwError = false; 
    
} //otherIncomePaymentTypeScreen

otherIncomePaymentTypeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomePaymentTypeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnOtherIncomePaymentType.Exists;  //Return whether otherIncomePaymentTypeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

otherIncomePaymentTypeScreen.prototype.SetAmount = function (iAmount) {  

/*-------------------------------------------------------------------------------
  Method      : SetAmount()
  
  Description : This method enters the Amount in the OtherIncomePaymentType Screen
  
  Output      : Enters the Amount in the OtherIncomePaymentType Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomePaymentTypeScreen.SetAmount: The OtherIncomePaymentType Screen does not Exist.",
              message     : this.scrnOtherIncomePaymentType + " Screen does not Exist." }             
    
    if (iAmount !== undefined && iAmount !== null)
    this.scrnOtherIncomePaymentType.FindChild("WinFormsControlName", "maskedTextBoxInfo", 2).Keys(iAmount);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetAmount

otherIncomePaymentTypeScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the OtherIncomePaymentType screen
  
  Output      : Returns the error message displayed in the OtherIncomePaymentType screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomePaymentTypeScreen.GetErrorMessage: The OtherIncomePaymentType screen does not Exist.",
              message     : this.scrnOtherIncomePaymentType + " OtherIncomePaymentType Screen does not Exist." }             
    
    return this.scrnOtherIncomePaymentType.WinFormsObject("screenInformationFooter")
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

  return new otherIncomePaymentTypeScreen();  
}