//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:PrepaymentScreen
  
  Description: 
  
  This class has methods and properties to perform the PrepaymentScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function prepaymentScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: prepaymentScreen() 
  
  Description: This method will the Instantiate the PrepaymentScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnPrepayment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenPrepayment", 2);
  
  this.throwError = false; 
    
} //prepaymentScreen

prepaymentScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the prepaymentScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnPrepayment.Exists;  //Return whether prepaymentScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

prepaymentScreen.prototype.SetAmount = function (iAmount) {  

/*-------------------------------------------------------------------------------
  Method      : SetAmount()
  
  Description : This method enters the Amount in the Prepayment Screen
  
  Output      : Enters the Amount in the Prepayment Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at prepaymentScreen.SetAmount: The Prepayment Screen does not Exist.",
              message     : this.scrnPrepayment + " Screen does not Exist." } 
                          
    Delay(1000);
    if (iAmount !== undefined && iAmount !== null)
      this.scrnPrepayment.FindChild("WinFormsControlName", "maskedTextBoxInfo", 3).Keys(iAmount);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetAmount

prepaymentScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the Prepayment screen
  
  Output      : Returns the error message displayed in the Prepayment screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at prepaymentScreen.GetErrorMessage: The Prepayment screen does not Exist.",
              message     : this.scrnPrepayment + " Prepayment Screen does not Exist." }             
    
    return this.scrnPrepayment.FindChild("WinFormsControlName","labelInformation",3).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

prepaymentScreen.prototype.GetAmount = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetAmount()
  
  Description : This method returns the Amount displayed in the Prepayment screen
  
  Output      : Returns the Amount displayed in the Prepayment screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at prepaymentScreen.GetErrorMessage: The Prepayment screen does not Exist.",
              message     : this.scrnPrepayment + " Prepayment Screen does not Exist." } 
              
    Delay(1000);            
    
    return aqString.Replace(this.scrnPrepayment.FindChild("WinFormsControlName","maskedTextBoxInfo",3).wText,"$","");
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetAmount

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new prepaymentScreen();  
}