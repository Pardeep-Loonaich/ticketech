//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------

  Name:CursorsPanel
  
  Description: 
  
  This class has methods and properties to perform the Cursors Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************/

function cursorsPanel() { 

/*--------------------------------------------------------------------------------------------- 
  Method: cursorsPanel() 
  
  Description: This method will the Instantiate the Cursors Panel Wrapper Helper
---------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlCursors =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelCursors", 2);
  this.throwError = false; 
    
} //numericPanel

cursorsPanel.prototype.Exists = function () {  

/*---------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the cursorsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlCursors.Exists;  //Return whether CursorsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

cursorsPanel.prototype.ClickLeftCursor = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickLeftCursor()
  
  Description : This method Clicks the Left Cursor button  
  
  Output      : Click on Left Cursor button if Cursors Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("LEFT")
  
} //ClickLeftCursor

cursorsPanel.prototype.ClickRightCursor = function () {  

/*-----------------------------------------------------------------------------
  Method      : ClickRightCursor()
  
  Description : This method Clicks the Right Cursor button  
  
  Output      : Click on Right Cursor button if Cursors Panel Exists
-----------------------------------------------------------------------------*/ 
  this.Click("RIGHT")
  
} //ClickRightCursor

cursorsPanel.prototype.ClickUpCursor = function () {  

/*---------------------------------------------------------------------------------------
  Method      : ClickUpCursor()
  
  Description : This method Clicks the Up Cursor button  
  
  Output      : Click on Up Cursor button if Cursors Panel Exists
---------------------------------------------------------------------------------------*/ 
  this.Click("UP")
  
} //ClickUpCursor

cursorsPanel.prototype.ClickDownCursor = function () {  

/*-----------------------------------------------------------------------------
  Method      : ClickDownCursor()
  
  Description : This method Clicks the Down Cursor button  
  
  Output      : Click on Down Cursor button if Cursors Panel Exists
-----------------------------------------------------------------------------*/ 
  this.Click("DOWN")
  
} //ClickDownCursor

cursorsPanel.prototype.Click = function (btnName) {  

/*------------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Cursors Panel Exists
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at cursorsPanel.Click"+btnName+": The Cursors Panel does not Exist.",
              message     : this.pnlCursors + " Panel does not Exist." }             
    
    this.pnlCursors.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*---------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating cursorsPanel() class from other units of the project. 
-----------------------------------------------------------------------------------------------------*/

  return new cursorsPanel();  
}