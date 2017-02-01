//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:YesNoConfirmActionPanel
  
  Description: 
  
  This class has methods and properties to perform the YesNoConfirmAction panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function yesNoConfirmActionPanel() { 

/*--------------------------------------------------------------------------- 
  Method: yesNoConfirmActionPanel() 
  
  Description: This method will the Instantiate the yesNoConfirmActionPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlYesNo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelYesNoConfirmAction", 2000);
  this.throwError = false; 
    
} //yesNoConfirmActionPanel

yesNoConfirmActionPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the yesNoConfirmActionPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlYesNo.Exists;  //Return whether yesNoConfirmActionPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

yesNoConfirmActionPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if YesNoConfirmAction Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at yesNoConfirmActionPanel.Click"+btnName+": The YesNoConfirmAction Panel does not Exist.",
              message     : this.pnlYesNo + " Panel does not Exist." }             
    
    this.pnlYesNo.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

yesNoConfirmActionPanel.prototype.ClickYes = function () {  

/*-----------------------------------------------------------------
  Method      : ClickYes()
  
  Description : This method Clicks the Yes button  
  
  Output      : Click on Yes button if YesNoConfirmAction Panel Exists
-----------------------------------------------------------------*/  
  this.Click("YES");
      
} //ClickYes

yesNoConfirmActionPanel.prototype.ClickNo = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNo()
  
  Description : This method Clicks the No button  
  
  Output      : Click on No button if YesNoConfirmAction Panel Exists
-----------------------------------------------------------------*/  
  this.Click("NO");
      
} //ClickNo

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating yesNoConfirmActionPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new yesNoConfirmActionPanel();  
}