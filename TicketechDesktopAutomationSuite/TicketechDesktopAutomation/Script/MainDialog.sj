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
  
  this.dlgMain =  Sys.Process("PosApplication").WaitWinFormsObject("FormMain", 5000); 
  
  this.objInformationScreen = InformationScreen.New();
  this.objPunchPanel = PunchPanel.New();
  this.objMainOptionsPanel = MainOptionsPanel.New();
  this.objOptionsPanel = OptionsPanel.New();
  this.objMainScreen = MainScreen.New();
  this.objTicketingPanel = TicketingPanel.New();
  
  this.throwError = false; 
    
} //mainDialog


mainDialog.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the MainDialog Wrapper   
--------------------------------------------------------------------------------*/  
  try {
   
    this.dlgMain =  Sys.Process("PosApplication").WaitWinFormsObject("FormMain", 10000); 
  
    this.objInformationScreen = InformationScreen.New();
    this.objPunchPanel = PunchPanel.New();
    this.objMainOptionsPanel = MainOptionsPanel.New();
    this.objOptionsPanel = OptionsPanel.New();
    this.objMainScreen = MainScreen.New();
    this.objTicketingPanel = TicketingPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

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
    
    this.objPunchPanel.ClickPunchIn();
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
    
    this.objPunchPanel.ClickPunchOut();
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
    
    this.objMainOptionsPanel.ClickLogin();
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
                 
    if(this.objPunchPanel.IsBtnVisible("TIMEKEEPER MENU")) {
        this.objPunchPanel.ClickTimeKeeperMenu();
        flag = true;
        Delay(1000);
    }
 
    return flag;
        
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
     
    frmInfo = {  Title    : this.objMainScreen.GetTitle(),
                 Date     : this.objMainScreen.GetDate(),
                 Time     : this.objMainScreen.GetTime(),
                 Message  : this.objMainScreen.GetFooterMessage()
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
    
    this.objTicketingPanel.ClickMonthly();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToMonthlyScreen

mainDialog.prototype.NavigateToReplaceScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToReplaceScreen()
  
  Description : This method clicks Replace button
  
  Output      : Clicks Replace button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToReplaceScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    return this.objTicketingPanel.ClickReplace();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToReplaceScreen

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
    
    this.objTicketingPanel.ClickDaily();
    Delay(1000);
        
  } //End try
  
  catch (exception)
  {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //clickOnDailyButton

mainDialog.prototype.NavigateToTechnicianMenu = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToTechnicianMenu()
  
  Description : This method clicks Technician Menu button
  
  Output      : Clicks Technician Menu button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToTechnicianMenu: The Technician Menu does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickTechnicianMenu();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToTechnicianMenu

mainDialog.prototype.NavigateToLostClaim = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToLostClaim()
  
  Description : This method clicks Lost Claim button
  
  Output      : Clicks Lost Claim button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToLostClaim: The Lost Claim does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickLostClaim();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToLostClaim


mainDialog.prototype.VerifyTicketNumber = function(iTicketNumber){

/*------------------------------------------------------------------------------------ 
  Method: VerifyTicketNumber() 
  
  Description:
  This method is for verifying ticket number, manualy entered for vehicle checkin.
  
  OutPut: true/false 
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.VerifyTicketNumber: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }
     
    return this.objInformationScreen.VerifyTicketExists(iTicketNumber);      
      
  }
  
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }

}

mainDialog.prototype.NavigateToOtherPaymentScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToOtherPaymentScreen()
  
  Description : This method clicks Other Payments button
  
  Output      : Clicks Other Payments button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToOtherPaymentScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickOtherPayment();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToOtherPaymentScreen

mainDialog.prototype.NavigateToMonthlyPaymentScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToMonthlyPaymentScreen()
  
  Description : This method clicks Monthly Payment button
  
  Output      : Clicks Monthly Payment button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToMonthlyPaymentScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickMonthlyPayment();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToMonthlyPaymentScreen

mainDialog.prototype.NavigateToReservationMenu = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToReservationMenu()
  
  Description : This method clicks Reservation Menu button
  
  Output      : Clicks Reservation Menu button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToReservationMenu: The Reservation Menu does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickReservationMenu();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToReservationMenu

mainDialog.prototype.NavigateToReceiptsScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToReceiptsScreen()
  
  Description : This method clicks Receipts button
  
  Output      : Clicks Receipts button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToReceiptsScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickReceipts();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToReceiptsScreen

mainDialog.prototype.NavigateToBankDropScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToBankDropScreen()
  
  Description : This method clicks Bank Drop button
  
  Output      : Clicks Bank Drop button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToBankDropScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickBankDrop();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToMonthlyPaymentScreen

mainDialog.prototype.NavigateToExpensesScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToExpensesScreen()
  
  Description : This method clicks Expenses button
  
  Output      : Clicks Expenses button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToExpensesScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickExpenses();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToExpensesScreen

mainDialog.prototype.NavigateToRushSelectionScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToRushSelectionScreen()
  
  Description : This method clicks Rush Selection button
  
  Output      : Clicks Rush Selection button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToRushSelectionScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickRushSelection();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToRushSelectionScreen

mainDialog.prototype.IsRushModeAvailable = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the Main Dilaog Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    bRushHour = false;
     
     this.lastError = {};
    
     if (!this.Exists())
       throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.IsRushModeAvailable: The mainDialog Form does not Exist.",
              message     : this.dlgMain + " The mainDialog Form does not Exist." } 
    
    objRushHour = Sys.Process("PosApplication").FindChild("WinFormsControlName","labelRushHour",2);
                        
    if(objRushHour.Exists){
      if(objRushHour.Visible)
        bRushHour = true;
    }
    return bRushHour;
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //IsRushModeAvailable

mainDialog.prototype.EnableRushMode = function () {  

/*--------------------------------------------------------------------------
  Method      : EnableRushMode()
  
  Description : This method Enables Rush mode
  
  Output      : Clicks EnableRushMode button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.EnableRushMode: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    if(!this.IsRushModeAvailable()){
      this.objOptionsPanel.ClickEnableRushMode(); 
      Delay(1000);
      return true;
    }
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //EnableRushMode

mainDialog.prototype.DisableRushMode = function () {  

/*--------------------------------------------------------------------------
  Method      : DisableRushMode()
  
  Description : This method Disables Rush mode
  
  Output      : Clicks DisableRushMode button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.DisableRushMode: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    if(this.IsRushModeAvailable()){
      this.objOptionsPanel.ClickDisableRushMode();
      Delay(1000);
      return true;
    }
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //EnableRushMode

mainDialog.prototype.NavigateToCorrectPaymentScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToCorrectPaymentScreen()
  
  Description : This method clicks Correct Payment button
  
  Output      : Clicks Correct Payment button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToCorrectPaymentScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickCorrectPayment();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //NavigateToCorrectPaymentScreen

mainDialog.prototype.NavigateToPrepayScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToPrepayScreen()
  
  Description : This method clicks Prepay button
  
  Output      : Clicks Prepay button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToPrepayScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickPrepay();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToPrepayScreen

mainDialog.prototype.IsHotelAvailable = function () {  

/*--------------------------------------------------------------------------
  Method      : IsHotelAvailable()
  
  Description : This method Checks if any Hotel Button is Present in Main
  
  Output      : Checks and returns true if Hotel button is available, else false
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.IsHotelAvailable: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    Delay(1000);
    return this.dlgMain.FindChild(["WndCaption","Visible"], ["*HOTEL*", true], 2).Exists;
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
} //IsHotelAvailable

mainDialog.prototype.NavigateToTicketInquiryScreen = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToTicketInquiryScreen()
  
  Description : This method clicks TicketInquiry button
  
  Output      : Clicks TicketInquiry button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.NavigateToTicketInquiryScreen: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    this.objOptionsPanel.ClickTicketInquiry();
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToTicketInquiryScreen

mainDialog.prototype.ClickCreditCardOfflineButton = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCreditCardOfflineButton()
  
  Description : This method clicks CreditCardOffline button
  
  Output      : Clicks CreditCardOffline button
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainDialog.ClickCreditCardOfflineButton: The Main Dialog does not Exist.",
              message     : this.dlgMain + " The Main Dialog does not Exist." }             
    
    Delay(1000);
    return this.objOptionsPanel.ClickCreditCardOffline();
 
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickCreditCardOfflineButton









