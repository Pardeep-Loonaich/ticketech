//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:ChangeRatePanel
  
  Description: 
  
  This class has methods and properties to perform the ChangeRatePanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function changeRatePanel() { 

/*--------------------------------------------------------------------------- 
  Method: changeRatePanel() 
  
  Description: This method will the Instantiate the changeRatePanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlChangeRate =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelChangeRate", 2);
  this.throwError = false; 
    
} //changeRatePanel

changeRatePanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the changeRatePanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlChangeRate.Exists;  //Return whether changeRatePanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

changeRatePanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if PanelChangeRate Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at changeRatePanel.Click"+btnName+": The PanelChangeRate does not Exist.",
              message     : this.pnlChangeRate + " Panel does not Exist." }             
    
    this.pnlChangeRate.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating changeRatePanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new changeRatePanel();  
}