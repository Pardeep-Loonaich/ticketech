//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:FormNoPunchHoursDayPanel
  
  Description: 
  
  This class has methods and properties to perform the FormNoPunchHoursDay Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function formNoPunchHoursDayPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: formNoPunchHoursDayPanel() 
  
  Description: This method will the Instantiate the FormNoPunchHoursDay Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlFormNoPunchHoursDay =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelFormNoPunchHoursDay", 2);
  this.throwError = false; 
    
} //formNoPunchHoursDayPanel

formNoPunchHoursDayPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the formNoPunchHoursDayPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlFormNoPunchHoursDay.Exists;  //Return whether formNoPunchHoursDayPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

formNoPunchHoursDayPanel.prototype.ClickSunday = function () {  

/*--------------------------------------------------------------------------
  Method      : Sunday()
  
  Description : This method Clicks the Sunday button  
  
  Output      : Click on Sunday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("SUNDAY")
  
} //ClickSunday

formNoPunchHoursDayPanel.prototype.ClickMonday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickMonday ()
  
  Description : This method Clicks the Monday button  
  
  Output      : Click on Monday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("MONDAY")
  
} //ClickMonday 

formNoPunchHoursDayPanel.prototype.ClickTuesday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickTuesday ()
  
  Description : This method Clicks the Tuesday button  
  
  Output      : Click on Tuesday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("TUESDAY")
  
} //ClickTuesday 

formNoPunchHoursDayPanel.prototype.ClickWednesday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickWednesday ()
  
  Description : This method Clicks the Wednesday button  
  
  Output      : Click on Wednesday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("WEDNESDAY")
  
} //ClickWednesday 

formNoPunchHoursDayPanel.prototype.ClickThursday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickThursday ()
  
  Description : This method Clicks the Thursday button  
  
  Output      : Click on Thursday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("THURSDAY")
  
} //ClickThursday 

formNoPunchHoursDayPanel.prototype.ClickFriday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickFriday()
  
  Description : This method Clicks the Friday button  
  
  Output      : Click on Friday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("FRIDAY")
  
} //ClickFriday

formNoPunchHoursDayPanel.prototype.ClickSaturday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickSaturday ()
  
  Description : This method Clicks the Saturday button  
  
  Output      : Click on Saturday button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("SATURDAY")
  
} //ClickSaturday

formNoPunchHoursDayPanel.prototype.ClickAllWeek= function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAllWeek ()
  
  Description : This method Clicks the AllWeek button  
  
  Output      : Click on AllWeek button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("ALL WEEK")
  
} //ClickAllWeek

formNoPunchHoursDayPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if FormNoPunchHoursDay Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formNoPunchHoursDayPanel.Click"+btnName+": The FormNoPunchHoursDay Panel does not Exist.",
              message     : this.pnlFormNoPunchHoursDay + " Panel does not Exist." }             
    
    objFormNoPunchHoursDayButton = this.pnlFormNoPunchHoursDay.WaitWinFormsObject("ScreenButton", btnName, 1000);
    
    objFormNoPunchHoursDayButton.SetFocus();
    
    if(objFormNoPunchHoursDayButton.Focus()){
      objFormNoPunchHoursDayButton.ClickButton();
    }
    else
      throw { name        : "Button Exception",
              description : "Error at formNoPunchHoursDayPanel.Click"+btnName+": The Button is not in Focus.",
              message     : objFormNoPunchHoursDayButton + " is not in Focus." } 
    
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
  This method is for instantiating formNoPunchHoursDayPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new formNoPunchHoursDayPanel();  
}