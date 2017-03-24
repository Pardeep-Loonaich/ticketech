//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:DealsOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the Deals Options Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function dealsOptionsPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: dealsOptionsPanel() 
  
  Description: This method will the Instantiate the Deals Options Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnldealsOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "Panel*Options", 2);
  this.throwError = false; 
    
} //dealsOptionsPanel

dealsOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the dealsOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnldealsOptions.Exists;  //Return whether dealsOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

dealsOptionsPanel.prototype.ClickReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickReservation()
  
  Description : This method Clicks the Reservation button  
  
  Output      : Click on Reservation button if Deals Options Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("RESERVATION")
  
} //ClickReservation

dealsOptionsPanel.prototype.ClickPrepay = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickPrepay()
  
  Description : This method Clicks the Prepay button  
  
  Output      : Click on Prepay button if Deals Options Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("PREPAY")
  
} //ClickPrepay

dealsOptionsPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Deals Options Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at dealsOptionsPanel.Click"+btnName+": The Deals Options Panel does not Exist.",
              message     : this.pnldealsOptions + " Panel does not Exist." }             
    
    this.pnldealsOptions.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
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
  This method is for instantiating dealsOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new dealsOptionsPanel();  
}