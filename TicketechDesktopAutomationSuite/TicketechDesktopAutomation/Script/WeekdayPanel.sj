//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:WeekdayPanel
  
  Description: 
  
  This class has methods and properties to perform the Weekday Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function weekdayPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: weekdayPanel() 
  
  Description: This method will the Instantiate the Weekday Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlWeekday =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelWeekday", 2);
  this.throwError = false; 
    
} //weekdayPanel

weekdayPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the weekdayPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlWeekday.Exists;  //Return whether weekdayPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

weekdayPanel.prototype.ClickSunday = function () {  

/*--------------------------------------------------------------------------
  Method      : Sunday()
  
  Description : This method Clicks the Sunday button  
  
  Output      : Click on Bereavement button if Weekday Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("SUNDAY")
  
} //ClickBereavement

weekdayPanel.prototype.ClickMonday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickMonday ()
  
  Description : This method Clicks the Monday button  
  
  Output      : Click on Monday button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("MONDAY")
  
} //ClickBirthday 

weekdayPanel.prototype.ClickTuesday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickTuesday ()
  
  Description : This method Clicks the Tuesday button  
  
  Output      : Click on Tuesday button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("TUESDAY")
  
} //ClickHoliday 

weekdayPanel.prototype.ClickWednesday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickWednesday ()
  
  Description : This method Clicks the Wednesday button  
  
  Output      : Click on Wednesday button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("WEDNESDAY")
  
} //ClickMissedInOrOut 

weekdayPanel.prototype.ClickThursday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickThursday ()
  
  Description : This method Clicks the Thursday button  
  
  Output      : Click on Thursday button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("THURSDAY")
  
} //ClickOther 

weekdayPanel.prototype.ClickFriday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickFriday()
  
  Description : This method Clicks the Friday button  
  
  Output      : Click on Friday button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("FRIDAY")
  
} //ClickSick

weekdayPanel.prototype.ClickSaturday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickSaturday ()
  
  Description : This method Clicks the Saturday button  
  
  Output      : Click on Saturday button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("SATURDAY")
  
} //ClickTravel

weekdayPanel.prototype.ClickAllWeek= function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAllWeek ()
  
  Description : This method Clicks the AllWeek button  
  
  Output      : Click on AllWeek button if Weekday Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("ALL WEEK")
  
} //ClickVacation

weekdayPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Weekday Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at weekdayPanel.Click"+btnName+": The Weekday Panel does not Exist.",
              message     : this.pnlWeekday + " Panel does not Exist." }             
    
    objWeekdayButton = this.pnlWeekday.WaitWinFormsObject("ScreenButton", btnName, 1000);
    
    objWeekdayButton.SetFocus();
    
    if(objWeekdayButton.Focus()){
      objWeekdayButton.ClickButton();
    }
    else
      throw { name        : "Button Exception",
              description : "Error at weekdayPanel.Click"+btnName+": The Button is not in Focus.",
              message     : objWeekdayButton + " is not in Focus." } 
    
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
  This method is for instantiating weekdayPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new weekdayPanel();  
}