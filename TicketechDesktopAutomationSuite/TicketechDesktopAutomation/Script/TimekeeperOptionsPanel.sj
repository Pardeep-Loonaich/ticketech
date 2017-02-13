//USEUNIT Utility

/**************************************************************************************
            ---------- Class Definition ----------
  Name:TimekeeperOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the TimekeeperOptions panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************************/

function timekeeperOptionsPanel() { 

/*---------------------------------------------------------------------------------------- 
  Method: timekeeperOptionsPanel() 
  
  Description: This method will the Instantiate the timekeeperOptionsPanel Wrapper Helper
----------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTimekeeperOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTimekeeperOptions", 2000);
  this.throwError = false; 
    
} //timekeeperOptionsPanel

timekeeperOptionsPanel.prototype.Exists = function () {  

/*------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the timekeeperOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTimekeeperOptions.Exists;  //Return whether timekeeperOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

timekeeperOptionsPanel.prototype.Click = function (btnName) {  

/*-------------------------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if TimekeeperOptions Panel Exists
-------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at timekeeperOptionsPanel.Click"+btnName+": The TimekeeperOptions Panel does not Exist.",
              message     : this.pnlTimekeeperOptions + " Panel does not Exist." }             
    
    this.pnlTimekeeperOptions.FindChild(["WndCaption","Visible"] ,[btnName,true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

timekeeperOptionsPanel.prototype.ClickEnrollment = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickEnrollment()
  
  Description : This method Clicks the Enrollment button  
  
  Output      : Click on Enrollment button if TimekeeperOptions Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("ENROLLMENT");
      
} //ClickEnrollment

timekeeperOptionsPanel.prototype.IsBtnVisible = function (btnName) {  

/*---------------------------------------------------------------------------------------------
  Method      : IsBtnVisible(btnName)
  
  Description : This method Checks the required button given as the parameter is visible/available 
  
  Output      : Checks the required button is visible/available if TimekeeperOptions Panel Exists
----------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at timekeeperOptionsPanel.IsBtnVisible"+btnName+": The TimekeeperOptions Panel does not Exist.",
              message     : this.pnlTimekeeperOptions + " Panel does not Exist." }             
    
   return this.pnlTimekeeperOptions.FindChild("WndCaption", btnName,2).Visible;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //IsBtnVisible

timekeeperOptionsPanel.prototype.ClickSchedule = function () {  

/*-------------------------------------------------------------------------
  Method      : ClickSchedule()
  
  Description : This method Clicks the Schedule button  
  
  Output      : Click on Schedule button if TimekeeperOptions Panel Exists
-------------------------------------------------------------------------*/  
  this.Click("SCHEDULE");
      
} //ClickSchedule

timekeeperOptionsPanel.prototype.ClickOpenPunchInsReport = function () {  

/*----------------------------------------------------------------------------------
  Method      : ClickOpenPunchInsReport()
  
  Description : This method Clicks the OpenPunchInsReport button  
  
  Output      : Click on OpenPunchInsReport button if TimekeeperOptions Panel Exists
----------------------------------------------------------------------------------*/  
  this.Click("OPEN\r\nPUNCH\r\nINS\r\nREPORT");
      
} //ClickOpenPunchInsReport

timekeeperOptionsPanel.prototype.ClickMissingPunchesReport = function () {  

/*------------------------------------------------------------------------------------
  Method      : ClickMissingPunchesReport()
  
  Description : This method Clicks the MissingPunchesReport button  
  
  Output      : Click on MissingPunchesReport button if TimekeeperOptions Panel Exists
------------------------------------------------------------------------------------*/  
  this.Click("MISSING PUNCHES REPORT");
      
} //ClickMissingPunchesReport

timekeeperOptionsPanel.prototype.ClickEmployeeTransfer = function () {  

/*--------------------------------------------------------------------------------
  Method      : ClickEmployeeTransfer()
  
  Description : This method Clicks the EmployeeTransfer button  
  
  Output      : Click on EmployeeTransfer button if TimekeeperOptions Panel Exists
--------------------------------------------------------------------------------*/  
  this.Click("EMPLOYEE TRANSFER");
      
} //ClickEmployeeTransfer

timekeeperOptionsPanel.prototype.ClickPrintSchedule = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickPrintSchedule()
  
  Description : This method Clicks the PrintSchedule button  
  
  Output      : Click on PrintSchedule button if TimekeeperOptions Panel Exists
-----------------------------------------------------------------------------*/  
  this.Click("PRINT SCHEDULES");
      
} //ClickPrintSchedule

timekeeperOptionsPanel.prototype.ClickNoPunchHours = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickNoPunchHours()
  
  Description : This method Clicks the NoPunchHours button  
  
  Output      : Click on NoPunchHours button if TimekeeperOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("NO-PUNCH HOURS");
      
} //ClickNoPunchHours

timekeeperOptionsPanel.prototype.ClickPrintWeeklyReports = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickPrintWeeklyReports()
  
  Description : This method Clicks the PrintWeeklyReports button  
  
  Output      : Click on PrintWeeklyReports button if TimekeeperOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("PRINT WEEKLY REPORTS");
      
} //ClickPrintWeeklyReports

timekeeperOptionsPanel.prototype.ClickPrintTimeCard = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickPrintTimeCard()
  
  Description : This method Clicks the PrintTimeCard button  
  
  Output      : Click on PrintTimeCard button if TimekeeperOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("PRINT TIMECARD");
      
} //ClickPrintTimeCard


function New() {

/*------------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating timekeeperOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------------*/

  return new timekeeperOptionsPanel();  
}