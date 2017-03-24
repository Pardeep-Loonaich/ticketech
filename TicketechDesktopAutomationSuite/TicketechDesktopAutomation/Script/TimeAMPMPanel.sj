//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:TimeAMPMPanel
  
  Description: 
  
  This class has methods and properties to perform the TimeAMPMPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function timeAMPMPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: timeAMPMPanel() 
  
  Description: This method will the Instantiate the TimeAMPMPanel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTimeAMPM =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTimeAMPM", 2);
  this.throwError = false; 
    
} //numericPanel

timeAMPMPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the timeAMPMPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTimeAMPM.Exists;  //Return whether timeAMPMPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


timeAMPMPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if TimeAMPMPanel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at timeAMPMPanel.Click"+btnName+": The TimeAMPMPanel does not Exist.",
              message     : this.pnlNavigation + " Panel does not Exist." }             
    
    this.pnlTimeAMPM.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click


timeAMPMPanel.prototype.ClickAM = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAM()
  
  Description : This method Clicks the AM button  
  
  Output      : Click on AM if TimeAMPMPanel Exists
--------------------------------------------------------------------------*/ 
  this.Click("AM")
  
} //ClickAM


timeAMPMPanel.prototype.ClickPM = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickPM()
  
  Description : This method Clicks the PM button  
  
  Output      : Click on PM button if TimeAMPMPanel Exists
--------------------------------------------------------------------------*/ 
  this.Click("PM")
  
} //ClickPM

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating TimeAMPMPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new timeAMPMPanel();  
}