﻿//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:PunchPanel
  
  Description: 
  
  This class has methods and properties to perform the punch panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function punchPanel() { 

/*--------------------------------------------------------------------------- 
  Method: punchPanel() 
  
  Description: This method will the Instantiate the PunchPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlPunch =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelPunch", 2000);
  this.throwError = false; 
    
} //punchPanel

punchPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the punchPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlPunch.Exists;  //Return whether punchPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

punchPanel.prototype.ClickPunchIn = function () {  

/*-----------------------------------------------------------------
  Method      : ClickPunchIn()
  
  Description : This method Clicks the PunchIn button  
  
  Output      : Click on PunchIn button if Punch Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PunchPanel.ClickPunchIn: The Punch Panel does not Exist.",
              message     : this.pnlPunch + " Panel does not Exist." }             
    
    this.pnlPunch.WaitWinFormsObject("ScreenButton", "PUNCH IN", 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickPunchIn

punchPanel.prototype.ClickPunchOut = function () {  

/*-----------------------------------------------------------------
  Method      : ClickPunchOut()
  
  Description : This method Clicks the PunchOut button  
  
  Output      : Click on PunchOut button if Punch Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PunchPanel.ClickPunchOut: The Punch Panel does not Exist.",
              message     : this.pnlPunch + " Panel does not Exist." }             
    
    this.pnlPunch.WaitWinFormsObject("ScreenButton", "PUNCH OUT", 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickPunchOut

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating punchPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new punchPanel();  
}