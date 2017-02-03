//USEUNIT Utility

/***************************************************************************
            ---------- Class Definition ----------

  Name:ColorPanel
  
  Description: 
  
  This class has methods and properties to perform the ColorPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
***************************************************************************/

function colorPanel() { 

/*----------------------------------------------------------------------------- 
  Method: colorPanel() 
  
  Description: This method will Instantiate the colorPanel Wrapper Helper
-----------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlColor =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelColor", 5);
  this.throwError = false; 
    
} //colorPanel

colorPanel.prototype.Exists = function () {  

/*-------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the colorPanel.  
  
  Output: True if Color Panel Exists
          False if Color Panel does not Exists   
-------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlColor.Exists;  //Return whether colorPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


colorPanel.prototype.ClickBlack = function () {  

/*-----------------------------------------------------------------
  Method      : ClickBlack()
  
  Description : This method Clicks the Black Color button  
  
  Output      : Click on Black button if Color Panel Exists
-----------------------------------------------------------------*/  
  this.Click("BLACK");
      
} //ClickBlack



colorPanel.prototype.SelectColor = function (btnColor) {  

/*------------------------------------------------------------------------
  Method      : SelectColor()
  
  Description : This method Clicks the given color button in the parameter
  
  Output      : Click on given color button if Color Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at colorPanel.Click"+btnColor+": The Color Panel does not Exist.",
              message     : this.pnlColor + " Panel does not Exist." }             
    
    this.pnlColor.FindChild(["WndCaption","Visible"], [btnColor, true], 2).ClickButton();
    
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
  This method is for instantiating colorPanel() class from other units of the project. 
-------------------------------------------------------------------------------------*/

  return new colorPanel();  
}