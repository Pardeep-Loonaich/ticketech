//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:YesNoRushPanel
  
  Description: 
  
  This class has methods and properties to perform the YesNoRush Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function yesNoRushPanel() { 

/*--------------------------------------------------------------------------- 
  Method: yesNoRushPanel() 
  
  Description: This method will the Instantiate the yesNoRushPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlYesNoRush =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelYesNoRush", 2);
  this.throwError = false; 
    
} //yesNoRushPanel

yesNoRushPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the yesNoRushPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlYesNoRush.Exists;  //Return whether yesNoRushPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

yesNoRushPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if YesNoRush Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at yesNoRushPanel.Click"+btnName+": The YesNoRush Panel does not Exist.",
              message     : this.pnlYesNoRush + " Panel does not Exist." }             
    
    this.pnlYesNoRush.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

yesNoRushPanel.prototype.ClickYes = function () {  

/*-----------------------------------------------------------------
  Method      : ClickYes()
  
  Description : This method Clicks the Yes button  
  
  Output      : Click on Yes button if YesNoRush Panel Exists
-----------------------------------------------------------------*/  
  this.Click("YES");
      
} //ClickYes

yesNoRushPanel.prototype.ClickNo = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNo()
  
  Description : This method Clicks the No button  
  
  Output      : Click on No button if YesNoRush Panel Exists
-----------------------------------------------------------------*/  
  this.Click("NO");
      
} //ClickNo

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating yesNoRushPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new yesNoRushPanel();  
}