//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT MainOptionsPanel
//USEUNIT MainScreen
//USEUNIT OptionsPanel
//USEUNIT TicketingPanel
//USEUNIT PunchPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:MainDialog
  
  Description: 
  
  This class has methods and properties to perform the MainDialog objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function mainDialog() { 

/*--------------------------------------------------------------------- 
  Method: mainDialog() 
  
  Description: This method will the Instantiate the mainDialog Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgMain =  Sys.Process("PosApplication").WaitWinFormsObject("FormMain", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.punchPanel = PunchPanel.New();
  this.mainOptionsPanel = MainOptionsPanel.New();
  this.optionsPanel = OptionsPanel.New();
  this.mainScreen = MainScreen.New();
  this.ticketingPanel = TicketingPanel.New();
  
  this.throwError = false; 
    
} //mainDialog

mainDialog.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the mainDialog.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgMain.Exists;  //Return whether MainDialog exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

mainDialog.prototype.NavigateToPunchInScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToPunchInScreen()
  
  Description : This method clicks Punch In button
  
  Output      : Clicks Punch In button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToPunchInScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.punchPanel.ClickPunchIn();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToPunchInScreen

mainDialog.prototype.NavigateToPunchOutScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToPunchOutScreen()
  
  Description : This method clicks PunchOut button
  
  Output      : Clicks PunchOut button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToPunchOutScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.punchPanel.ClickPunchOut();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToPunchOutScreen

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating mainDialog() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new mainDialog();  
}

mainDialog.prototype.NavigateToUserInfoScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToUserInfoScreen()
  
  Description : This method clicks LogIn button
  
  Output      : Clicks LogIn button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToUserInfoScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.mainOptionsPanel.ClickLogin();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToUserInfoScreen

mainDialog.prototype.NavigateToTimeKeeperMenu = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToTimeKeeperMenu()
  
  Description : This method clicks TimeKeeperMenu button
  
  Output      : Clicks TimeKeeperMenu button
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToTimeKeeperMenu: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }
                 
    if(this.punchPanel.IsBtnVisible("TIMEKEEPER MENU")) {
        this.punchPanel.ClickTimeKeeperMenu();
        flag = true;
    }
 
    return flag;
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToTimeKeeperMenu

mainDialog.prototype.GetFormInfo = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the Info of the Screen like Title, Message etc. 
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.getFormInfo: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }
     
    frmInfo = {  Title    : this.mainScreen.GetTitle(),
                 Date     : this.mainScreen.GetDate(),
                 Time     : this.mainScreen.GetTime(),
                 Message  : this.mainScreen.GetFooterMessage()
              };
      
    return frmInfo;
      
  }
  
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }

}

mainDialog.prototype.NavigateToMonthlyScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToMonthlyScreen()
  
  Description : This method clicks Monthly button
  
  Output      : Clicks Monthly button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToMonthlyScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.ticketingPanel.ClickMonthly();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToMonthlyScreen

  mainDialog.prototype.clickOnDailyButton = function () {  

/*--------------------------------------------------------------------------
  Method      : clickOnDailyButton()
  
  Description : use this method to click on daliy button on main screen
  
  Output      : it will navigate to daily module after clicking on daily button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.clickOnDailyButton: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.ticketingPanel.ClickDaily();
    Delay(1000);
        
  } //End try
  
  catch (exception)
  {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //clickOnDailyButton