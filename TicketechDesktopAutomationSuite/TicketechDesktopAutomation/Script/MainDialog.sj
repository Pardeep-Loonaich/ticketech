﻿//USEUNIT Utility
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
  this.mainoptionsPanel = MainOptionsPanel.New();
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

    return this.dlgMain.Exists;  //Return whether punchPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

mainDialog.prototype.NavigateToEmployeeInfoScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToEmployeeInfoScreen()
  
  Description : This method clicks Punch In button
  
  Output      : Clicks Punch In button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToEmployeeInfoScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.punchPanel.ClickPunchIn();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitForm

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating mainDialog() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new mainDialog();  
}

mainDialog.prototype.Login = function () {  

/*--------------------------------------------------------------------------
  Method      : Login()
  
  Description : This method clicks LogIn button
  
  Output      : Clicks LogIn button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.Login: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.mainOptionsPanel.ClickLogin();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitForm