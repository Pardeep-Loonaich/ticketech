//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:ExpensesCodesPanel
  
  Description: 
  
  This class has methods and properties to perform the ExpensesCodes Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function expensesCodesPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: expensesCodesPanel() 
  
  Description: This method will the Instantiate the ExpensesCodes Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlExpensesCodes =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelExpensesCodes", 2);
  this.throwError = false; 
    
} //expensesInfoCodePanel

expensesCodesPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the expensesCodesPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlExpensesCodes.Exists;  //Return whether expensesInfoCodePanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


expensesCodesPanel.prototype.ClickExpensesCode = function () {

/*----------------------------------------------------------------------------------------------- 
  Method: ClickExpensesCode() 
  
  Description:
  This method is to check if any expenses code is avilable and then click an avilable expense code 
------------------------------------------------------------------------------------------------*/
  
  var bCodeAvailable = false;
  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at expensesCodesPanel.Click"+btnName+": The ExpensesCodes Panel does not Exist.",
              message     : this.pnlExpensesCodes + " Panel does not Exist." }             
    
    //Array variable to store the number of Expenses Code found in ExpensesCodesPanel
    aExpensesCode = this.pnlExpensesCodes.FindAllChildren(["Name","Enabled"], ["WinFormsObject(\"ScreenButton\", \"\*\")",true],1).toArray();
    
    //Click the first avilable ExpensesCode, if any available
    if(aExpensesCode.length > 0){
      aExpensesCode[0].ClickButton();
       
      TestLog.Message("Clicked Button "+aExpensesCode[0].WndCaption);
      bCodeAvailable = true;
    }
    
    return bCodeAvailable;
  } //End try
  
  catch (exception) {
    TestLog.Error("Exception at ClickExpensesCode method in ExpensesCodesPanel");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
}//ClickExpensesCode

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating expensesInfoCodePanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new expensesCodesPanel();  
}