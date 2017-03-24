//USEUNIT Utility

/**************************************************************************************
            ---------- Class Definition ----------
  Name:PunchSchedulePanel
  
  Description: 
  
  This class has methods and properties to perform the PunchSchedulePanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************************/

function punchSchedulePanel() { 

/*----------------------------------------------------------------------------------- 
  Method: punchSchedulePanel() 
  
  Description: This method will the Instantiate the punchSchedulePanel Wrapper Helper
-------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlPunchSchedule =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelPunchSchedule", 2);
  this.throwError = false; 
    
} //punchSchedulePanel

punchSchedulePanel.prototype.Exists = function () {  

/*--------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the punchSchedulePanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlPunchSchedule.Exists;  //Return whether punchSchedulePanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at punchSchedulePanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

punchSchedulePanel.prototype.ClickSaveSchedule = function () {  

/*---------------------------------------------------------------------
  Method      : ClickSaveSchedule()
  
  Description : This method Clicks Save Schedule button 
  
  Output      : Clicks Save Schedule button if PunchSchedule Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PunchSchedulePanel.ClickSaveSchedule: The PunchSchedule Panel does not Exist.",
              message     : this.pnlPunchSchedule + " Panel does not Exist." }             
    
    this.pnlPunchSchedule.WaitWinFormsObject("ScreenButton", "SAVE SCHEDULE", 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at punchSchedulePanel.ClickSaveSchedule");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickSaveSchedule


function New() {

/*----------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating punchSchedulePanel() class from other units of the project. 
-----------------------------------------------------------------------------------*/

  return new punchSchedulePanel();  
}