//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT TimekeeperOptionsPanel
//USEUNIT TimekeeperMenuScreen
//USEUNIT BackPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:TimekeeperMenuForm
  
  Description: 
  
  This class has methods and properties to perform the TimekeeperMenuForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function timekeeperMenuForm() { 

/*--------------------------------------------------------------------- 
  Method: timekeeperMenuForm() 
  
  Description: This method will the Instantiate the timekeeperMenuForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgTimekeeperMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormTimekeeperMenu", 3000); 
  
  this.objInformationScreen = InformationScreen.New();
  this.objTimekeeperOptionsPanel = TimekeeperOptionsPanel.New();
  this.objTimekeeperMenuScreen = TimekeeperMenuScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objBackPanel = BackPanel.New();
  
  this.throwError = false; 
    
} //timekeeperMenuForm

timekeeperMenuForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the timekeeperMenuForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.dlgTimekeeperMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormTimekeeperMenu", 3000); 
  
    this.objInformationScreen = InformationScreen.New();
    this.objTimekeeperOptionsPanel = TimekeeperOptionsPanel.New();
    this.objTimekeeperMenuScreen - TimekeeperMenuScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objBackPanel = BackPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

timekeeperMenuForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the timekeeperMenuForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgTimekeeperMenu.Exists;  //Return whether timekeeperMenuForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

timekeeperMenuForm.prototype.NavigateToEnrollmentForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToEnrollmentForm()
  
  Description : This method Clicks Enrollment button  
  
  Output      : Clicks Enrollment button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToEnrollmentForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("ENROLLMENT")) {
        this.objTimekeeperOptionsPanel.ClickEnrollment();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToEnrollmentForm

timekeeperMenuForm.prototype.NavigateToPrintTimecardForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToPrintTimecardForm()
  
  Description : This method Clicks Print Timecard button  
  
  Output      : Clicks Print Timecard button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToPrintTimecardForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("PRINT TIMECARD")) {
        this.objTimekeeperOptionsPanel.ClickPrintTimecard();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToPrintTimecardForm

timekeeperMenuForm.prototype.PrintWeeklyReports = function () {  

/*-----------------------------------------------------------------------------
  Method      : PrintWeeklyReports()
  
  Description : This method Clicks PrintWeeklyReports button  
  
  Output      : Clicks PrintWeeklyReports button if TimekeeperMenu Form Exists
----------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.PrintWeeklyReports: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("PRINT WEEKLY REPORTS")) {
        this.objTimekeeperOptionsPanel.ClickPrintWeeklyReports();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //PrintWeeklyReports

timekeeperMenuForm.prototype.NavigateToNoPunchHoursForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToNoPunchHoursForm()
  
  Description : This method Clicks NoPunchHours button  
  
  Output      : Clicks NoPunchHours button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToNoPunchHoursForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("NO-PUNCH HOURS")) {
        this.objTimekeeperOptionsPanel.ClickNoPunchHours();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToNoPunchHoursForm

timekeeperMenuForm.prototype.NavigateToEmployeeTransferForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToEmployeeTransferForm()
  
  Description : This method Clicks Employee Transfer button  
  
  Output      : Clicks Employee Transfer button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToEmployeeTransferForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("EMPLOYEE TRANSFER")) {
        this.objTimekeeperOptionsPanel.ClickEmployeeTransfer();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToNoPunchHoursForm

timekeeperMenuForm.prototype.NavigateToPrintSchedulesForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToPrintSchedulesForm()
  
  Description : This method Clicks Print Schedules button  
  
  Output      : Clicks Print Schedules button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToPrintSchedulesForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("PRINT SCHEDULES")) {
        this.objTimekeeperOptionsPanel.ClickPrintSchedule();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToPrintSchedulesForm


timekeeperMenuForm.prototype.ClickMissingPunchesReport = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickMissingPunchesReport()
  
  Description : This method Clicks MissingPunches button  
  
  Output      : Clicks MissingPunches button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.ClickMissingPunchesReport: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("MISSING PUNCHES REPORT")) {
        this.objTimekeeperOptionsPanel.ClickMissingPunchesReport();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickMissingPunchesReport

timekeeperMenuForm.prototype.NavigateToScheduleForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToScheduleForm()
  
  Description : This method Clicks Schedule button  
  
  Output      : Clicks Schedule button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToScheduleForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.objTimekeeperOptionsPanel.IsBtnVisible("SCHEDULE")) {
        this.objTimekeeperOptionsPanel.ClickSchedule();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToScheduleForm

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating timekeeperMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new timekeeperMenuForm();  
}