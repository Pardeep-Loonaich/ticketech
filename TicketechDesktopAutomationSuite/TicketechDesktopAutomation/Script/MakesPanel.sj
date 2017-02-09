//USEUNIT Utility

/***************************************************************************
            ---------- Class Definition ----------

  Name:MakesPanel
  
  Description: 
  
  This class has methods and properties to perform the MakesPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
***************************************************************************/

function makesPanel() { 

/*----------------------------------------------------------------------------- 
  Method: makesPanel() 
  
  Description: This method will Instantiate the makesPanel Wrapper Helper
-----------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlMakes =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelMakes", 5);
  this.throwError = false; 
    
} //makesPanel

/*
-----------------------------
Method: Refresh
Desc:   to refresh this Makes Panel Page
-----------------------
*/


makesPanel.prototype.Refresh=function()

{
this.lastError = {};
  this.pnlMakes =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelMakes", 5);
  this.throwError = false; 
}

makesPanel.prototype.Exists = function () {  

/*-------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the makesPanel.  
  
  Output: True if Makes Panel Exists
          False if Makes Panel does not Exists   
-------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlMakes.Exists;  //Return whether makesPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


makesPanel.prototype.ClickNext = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNext()
  
  Description : This method Clicks the Next button  
  
  Output      : Click on Next button if Makes Panel Exists
-----------------------------------------------------------------*/      
    this.pnlMakes.FindChild(["WndCaption","Visible"], ["NEXT >>", true], 2).ClickButton();  

} //ClickNext


makesPanel.prototype.SelectVehicleMake = function (sVehicleMake) {  

/*------------------------------------------------------------------------
  Method      : SelectVehicleMake()
  
  Description : This method Clicks the given vehicle make button in the parameter
  
  Output      : Click on given make button if Makes Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at makesPanel.Click"+sVehicleMake+": The Makes Panel does not Exist.",
              message     : this.pnlMakes + " Panel does not Exist." }             
    if(this.pnlMakes.FindChild(["Value","Visible"], [sVehicleMake, true], 2).Exists)
    {
    this.pnlMakes.FindChild(["Value","Visible"], [sVehicleMake, true], 2).ClickButton();
    }
    else
    {
    MakesPanel.New().ClickNext();
    this.Refresh();
    this.pnlMakes.FindChild(["Value","Visible"], [sVehicleMake, true], 2).ClickButton();
    }
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
  This method is for instantiating makesPanel() class from other units of the project. 
-------------------------------------------------------------------------------------*/

  return new makesPanel();  
}