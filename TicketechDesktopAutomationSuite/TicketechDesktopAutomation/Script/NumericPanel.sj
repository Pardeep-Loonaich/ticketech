﻿//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:NumericPanel
  
  Description: 
  
  This class has methods and properties to perform the Numeric Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function numericPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: numericPanel() 
  
  Description: This method will the Instantiate the Main Options Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlNumeric =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelNumeric", 2000);
  this.throwError = false; 
    
} //numericPanel

numericPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the mainOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlNumeric.Exists;  //Return whether punchPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

numericPanel.prototype.ClickAboutTicketech = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAboutTicketech()
  
  Description : This method Clicks the About Ticketech button  
  
  Output      : Click on AboutTicketech button if main Options Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PunchPanel.ClickAboutTicketech: The Punch Panel does not Exist.",
              message     : this.pnlPunch + " Panel does not Exist." }             
    
    this.pnlMainOptions.WaitWinFormsObject(["Value", "Visible"], ["ABOUT TICKETECH", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickAboutTicketech


numericPanel.prototype.ClickLogin = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickLogin()
  
  Description : This method Clicks the Login button  
  
  Output      : Click on Login button if main Options Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PunchPanel.ClickLogin: The Punch Panel does not Exist.",
              message     : this.pnlPunch + " Panel does not Exist." }             
    
    this.pnlMainOptions.WaitWinFormsObject(["Value", "Visible"], ["USER LOGIN", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickLogin

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating mainOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new mainOptionsPanel();  
}