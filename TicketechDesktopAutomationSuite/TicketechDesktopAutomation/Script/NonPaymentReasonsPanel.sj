//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:NonPaymentReasonsPanel
  
  Description: 
  
  This class has methods and properties to perform the NonPaymentReasons Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function nonPaymentReasonsPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: nonPaymentReasonsPanel() 
  
  Description: This method will the Instantiate the NonPaymentReasons Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlNonPaymentReasons =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelNonPaymentReasons", 2);
  this.throwError = false; 
    
} //nonPaymentReasonsPanel

nonPaymentReasonsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the nonPaymentReasonsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlNonPaymentReasons.Exists;  //Return whether nonPaymentReasonsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


nonPaymentReasonsPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if NonPaymentReasons Panel Exists
--------------------------------------------------------------------------*/  
try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at nonPaymentReasonsPanel.Click"+btnName+": The nonPaymentReasons Panel does not Exist.",
              message     : this.pnlNonPaymentReasons + " Panel does not Exist." }             
    
    this.pnlNonPaymentReasons.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
}//Click

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating nonPaymentReasonsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new nonPaymentReasonsPanel();  
}