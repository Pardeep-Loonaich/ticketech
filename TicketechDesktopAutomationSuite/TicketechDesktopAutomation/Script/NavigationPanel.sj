//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:NavigationPanel
  
  Description: 
  
  This class has methods and properties to perform the Navigation Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function navigationPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: navigationPanel() 
  
  Description: This method will the Instantiate the Navigation Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlNavigation =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelNavigation", 2000);
  this.throwError = false; 
    
} //numericPanel

navigationPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the navigationPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlNavigation.Exists;  //Return whether punchPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

navigationPanel.prototype.ClickEnter = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickEnter()
  
  Description : This method Clicks the Enter button  
  
  Output      : Click on Enter button if Navigation Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at navigationPanel.ClickEnter: The Navigation Panel does not Exist.",
              message     : this.pnlNavigation + " Panel does not Exist." }             
    
    this.pnlNavigation.FindChild(["Value", "Visible"], ["Enter", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickEnter

navigationPanel.prototype.ClickCancel = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCancel()
  
  Description : This method Clicks the Cancel button  
  
  Output      : Click on Cancel button if Navigation Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at navigationPanel.ClickCancel: The Navigation Panel does not Exist.",
              message     : this.pnlNavigation + " Panel does not Exist." }             
    
    this.pnlNavigation.WaitWinFormsObject(["Value", "Visible"], ["Cancel", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickCancel

navigationPanel.prototype.ClickLogin = function () {  

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
  This method is for instantiating navigationPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new navigationPanel();  
}