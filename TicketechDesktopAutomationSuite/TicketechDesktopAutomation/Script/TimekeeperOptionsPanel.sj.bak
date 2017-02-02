//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:TimekeeperOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the TimekeeperOptions panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function timekeeperOptionsPanel() { 

/*--------------------------------------------------------------------------- 
  Method: timekeeperOptionsPanel() 
  
  Description: This method will the Instantiate the timekeeperOptionsPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTimekeeperOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTimekeeperOptions", 2000);
  this.throwError = false; 
    
} //timekeeperOptionsPanel

timekeeperOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the timekeeperOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTimekeeperOptions.Exists;  //Return whether timekeeperOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

timekeeperOptionsPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if TimekeeperOptions Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at timekeeperOptionsPanel.Click"+btnName+": The TimekeeperOptions Panel does not Exist.",
              message     : this.pnlTimekeeperOptions + " Panel does not Exist." }             
    
    this.pnlTimekeeperOptions.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

timekeeperOptionsPanel.prototype.ClickYes = function () {  

/*-----------------------------------------------------------------
  Method      : ClickYes()
  
  Description : This method Clicks the Yes button  
  
  Output      : Click on Yes button if TimekeeperOptions Panel Exists
-----------------------------------------------------------------*/  
  this.Click("YES");
      
} //ClickYes

timekeeperOptionsPanel.prototype.ClickNo = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNo()
  
  Description : This method Clicks the No button  
  
  Output      : Click on No button if TimekeeperOptions Panel Exists
-----------------------------------------------------------------*/  
  this.Click("NO");
      
} //ClickNo

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating timekeeperOptionsPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new timekeeperOptionsPanel();  
}