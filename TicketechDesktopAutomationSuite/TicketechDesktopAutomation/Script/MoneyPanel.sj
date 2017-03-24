//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------

  Name:MoneyPanel
  
  Description: 
  
  This class has methods and properties to perform the Money Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************/

function moneyPanel() { 

/*--------------------------------------------------------------------------------------------- 
  Method: moneyPanel() 
  
  Description: This method will the Instantiate the Money Panel Wrapper Helper
---------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlMoney =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelMoney", 3);
  this.throwError = false; 
    
} //moneyPanel

moneyPanel.prototype.Exists = function () {  

/*---------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the moneyPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlMoney.Exists;  //Return whether MoneyPanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at moneyPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


moneyPanel.prototype.Click = function (btnName) {  

/*------------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Money Panel Exists
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MoneyPanel.Click"+btnName+": The Money Panel does not Exist.",
              message     : this.pnlMoney + " Panel does not Exist." } 
                          
    Delay(1000);
    this.pnlMoney.FindChild(["WndCaption","Visible"] ,[btnName,true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at moneyPanel.Click "+btnName);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*---------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating moneyPanel() class from other units of the project. 
-----------------------------------------------------------------------------------------------------*/

  return new moneyPanel();  
}