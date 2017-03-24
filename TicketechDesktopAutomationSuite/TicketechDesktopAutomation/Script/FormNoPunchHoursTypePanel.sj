//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:FormNoPunchHoursTypePanel
  
  Description: 
  
  This class has methods and properties to perform the FormNoPunchHoursType Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function formNoPunchHoursTypePanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: formNoPunchHoursTypePanel() 
  
  Description: This method will the Instantiate the FormNoPunchHoursType Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlFormNoPunchHoursType =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelFormNoPunchHoursType", 2);
  this.throwError = false; 
    
} //formNoPunchHoursTypePanel

formNoPunchHoursTypePanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the formNoPunchHoursTypePanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlFormNoPunchHoursType.Exists;  //Return whether formNoPunchHoursTypePanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

formNoPunchHoursTypePanel.prototype.ClickBereavement = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickBereavement()
  
  Description : This method Clicks the Bereavement button  
  
  Output      : Click on Bereavement button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("BEREAVEMENT")
  
} //ClickBereavement

formNoPunchHoursTypePanel.prototype.ClickBirthday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickBirthday ()
  
  Description : This method Clicks the Birthday button  
  
  Output      : Click on Birthday button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("BIRTHDAY")
  
} //ClickBirthday 

formNoPunchHoursTypePanel.prototype.ClickHoliday = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickHoliday ()
  
  Description : This method Clicks the Holiday button  
  
  Output      : Click on Holiday button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("HOLIDAY")
  
} //ClickHoliday 

formNoPunchHoursTypePanel.prototype.ClickMissedInOrOut = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickMissedInOrOut ()
  
  Description : This method Clicks the MissedInOrOut button  
  
  Output      : Click on MissedInOrOut button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("MISSED IN OR OUT")
  
} //ClickMissedInOrOut 

formNoPunchHoursTypePanel.prototype.ClickOther = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickOther ()
  
  Description : This method Clicks the Other button  
  
  Output      : Click on Other button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("OTHER")
  
} //ClickOther 

formNoPunchHoursTypePanel.prototype.ClickSick = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickSick()
  
  Description : This method Clicks the Sick button  
  
  Output      : Click on Sick button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("SICK")
  
} //ClickSick

formNoPunchHoursTypePanel.prototype.ClickTravel = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickTravel ()
  
  Description : This method Clicks the Travel button  
  
  Output      : Click on Travel button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("TRAVEL")
  
} //ClickTravel

formNoPunchHoursTypePanel.prototype.ClickVacation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickVacation ()
  
  Description : This method Clicks the Vacation button  
  
  Output      : Click on Vacation button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("VACATION")
  
} //ClickVacation

formNoPunchHoursTypePanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if FormNoPunchHoursType Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formNoPunchHoursTypePanel.Click"+btnName+": The FormNoPunchHoursType Panel does not Exist.",
              message     : this.pnlFormNoPunchHoursType + " Panel does not Exist." }             
    
    objFormNoPunchHoursTypeButton = this.pnlFormNoPunchHoursType.WaitWinFormsObject("ScreenButton", btnName, 3000);
    
    objFormNoPunchHoursTypeButton.SetFocus();
    
    if(objFormNoPunchHoursTypeButton.Focus()){
      objFormNoPunchHoursTypeButton.ClickButton();
    }
    else
      throw { name        : "Button Exception",
              description : "Error at formNoPunchHoursTypePanel.Click"+btnName+": The Button is not in Focus.",
              message     : objFormNoPunchHoursTypeButton + " is not in Focus." } 
    
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
  This method is for instantiating formNoPunchHoursTypePanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new formNoPunchHoursTypePanel();  
}