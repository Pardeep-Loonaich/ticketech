//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:ExpensesScreen
  
  Description: 
  
  This class has methods and properties to perform the ExpensesScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function expensesScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: expensesScreen() 
  
  Description: This method will the Instantiate the ExpensesScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnExpenses =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenExpenses", 2);
  
  this.throwError = false; 
    
} //expensesScreen

expensesScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the expensesScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnExpenses.Exists;  //Return whether expensesScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

expensesScreen.prototype.SetDescription = function (sDescription) {  

/*-------------------------------------------------------------------------------
  Method      : SetDescription()
  
  Description : This method enters the Description in the Expenses Screen
  
  Output      : Enters the Description in the Expenses Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at expensesScreen.SetDescription: The Expenses Screen does not Exist.",
              message     : this.scrnExpenses + " Screen does not Exist." }             
    
    if (sDescription !== undefined && sDescription !== null)
    this.scrnExpenses.FindChild("WinFormsControlName", "textBoxInfo", 2).Keys(sDescription);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetDescription

expensesScreen.prototype.SetAmount = function (iPayAmount) {  

/*-------------------------------------------------------------------------------------------------------
  Method      : SetAmount()
  
  Description : This method enters the Payment Amount in the given field of Expenses screen
  
  Output      : Enters the payment Amount in the given field of Expenses screen
-------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ExpensesScreen.SetAmount: The Expenses Screen does not Exist.",
              message     : this.scrnExpenses + " Screen does not Exist." }             
    
    if (iPayAmount !== undefined && iPayAmount !== null)
      this.scrnExpenses.FindChild("Caption", "AMOUNT", 2).FindChild("WinFormsControlName","maskedTextBoxInfo",1).Keys(iPayAmount);
         
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetAmount

expensesScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the Expenses screen
  
  Output      : Returns the error message displayed in the Expenses screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at expensesScreen.GetErrorMessage: The Expenses screen does not Exist.",
              message     : this.scrnExpenses + " Expenses Screen does not Exist." }             
    
    return this.scrnExpenses.FindChild("WinFormsControlName","labelInformation",3).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

expensesScreen.prototype.GetCurrentSelectedField = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetCurrentSelectedField()
  
  Description : This method returns the CurrentSelectedField in the Expenses screen
  
  Output      : Returns the CurrentSelectedField displayed in the Expenses screen
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at expensesScreen.GetCurrentSelectedField: The Expenses screen does not Exist.",
              message     : this.scrnExpenses + " Expenses Screen does not Exist." }             
    
    return this.scrnExpenses.FindChild("CustomState","Selected",3).Caption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetCurrentSelectedField

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new expensesScreen();  
}