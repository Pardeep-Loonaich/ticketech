//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:MainOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the Main Options Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function mainOptionsPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: mainOptionsPanel() 
  
  Description: This method will the Instantiate the Main Options Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlMainOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelMainOptions", 3);
  this.throwError = false; 
    
} //mainOptionsPanel

mainOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the mainOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlMainOptions.Exists;  //Return whether Main Options Panel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at mainOptionsPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

mainOptionsPanel.prototype.ClickAboutTicketech = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAboutTicketech()
  
  Description : This method Clicks the About Ticketech button  
  
  Output      : Click on AboutTicketech button if main Options Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("ABOUT TICKETECH");
      
} //ClickAboutTicketech

mainOptionsPanel.prototype.ClickLogin = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickLogin()
  
  Description : This method Clicks the Login button  
  
  Output      : Click on Login button if main Options Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("USER LOGIN");
      
} //ClickLogin

mainOptionsPanel.prototype.ClickLogout = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickLogout()
  
  Description : This method Clicks the Logout button  
  
  Output      : Click on Logout button if main Options Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("USER LOGIN");
      
} //ClickLogout

mainOptionsPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button in the parameter
  
  Output      : Click on given button if main Options Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MainOptionsPanel.Click"+index+": The MainOptions Panel does not Exist.",
              message     : this.pnlMainOptions + " MainOptions Panel does not Exist." }             
    
    this.pnlMainOptions.FindChild("Value", btnName, 3).ClickButton();
    Delay(500);
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at mainOptionsPanel.Click "+btnName);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating mainOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new mainOptionsPanel();  
}