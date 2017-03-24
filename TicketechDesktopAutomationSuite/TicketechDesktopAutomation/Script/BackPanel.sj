//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:BackPanel
  
  Description: 
  
  This class has methods and properties to perform the Back panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function backPanel() { 

/*--------------------------------------------------------------------------- 
  Method: backPanel() 
  
  Description: This method will the Instantiate the backPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlBack =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelBack", 2);
  this.throwError = false; 
    
} //backPanel

backPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the backPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlBack.Exists;  //Return whether backPanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at backPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

backPanel.prototype.ClickBack = function () {  

/*------------------------------------------------------
  Method      : ClickBack()
  
  Description : This method Clicks Back button 
  
  Output      : Clicks Back button if Back Panel Exists
------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at BackPanel.ClickBack: The Back Panel does not Exist.",
              message     : this.pnlBack + " Panel does not Exist." }             
    
    this.pnlBack.WaitWinFormsObject("ScreenButton", "BACK", 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at backPanel.ClickBack");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickBack


function New() {

/*----------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating backPanel() class from other units of the project. 
-----------------------------------------------------------------------------------*/

  return new backPanel();  
}