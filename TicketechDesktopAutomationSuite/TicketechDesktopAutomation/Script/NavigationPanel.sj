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
  
  this.pnlNavigation =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelNavigation", 2);
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

    return this.pnlNavigation.Exists;  //Return whether navigationPanel exists or not
  
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
  this.Click("ENTER")
  
} //ClickEnter

navigationPanel.prototype.ClickCancel = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCancel()
  
  Description : This method Clicks the Cancel button  
  
  Output      : Click on Cancel button if Navigation Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("CANCEL")
  
} //ClickCancel

navigationPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Navigation Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at navigationPanel.Click"+btnName+": The Navigation Panel does not Exist.",
              message     : this.pnlNavigation + " Panel does not Exist." }             
    
    this.pnlNavigation.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating navigationPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new navigationPanel();  
}