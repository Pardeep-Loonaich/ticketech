//USEUNIT Utility

/***************************************************************************
            ---------- Class Definition ----------

  Name:OptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the OptionsPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
***************************************************************************/

function optionsPanel() { 

/*----------------------------------------------------------------------------- 
  Method: optionsPanel() 
  
  Description: This method will the Instantiate the optionsPanel Wrapper Helper
-----------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelOptions", 2);
  this.throwError = false; 
    
} //optionsPanel

optionsPanel.prototype.Exists = function () {  

/*-------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the optionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlOptions.Exists;  //Return whether optionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


optionsPanel.prototype.ClickNext = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNext()
  
  Description : This method Clicks the Next button  
  
  Output      : Click on Next button if Options Panel Exists
-----------------------------------------------------------------*/  
  this.Click("NEXT >>");
      
} //ClickNext

optionsPanel.prototype.ClickVehicleInventory = function () {  

/*------------------------------------------------------------------------
  Method      : ClickVehicleInventory()
  
  Description : This method Clicks the Vehicle Inventory button  
  
  Output      : Click on Vehicle Inventory button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("VEHICLE INVENTORY");
      
} //ClickVehicleInventory

optionsPanel.prototype.ClickTicketInquiry = function () {  

/*------------------------------------------------------------------------
  Method      : ClickTicketInquiry()
  
  Description : This method Clicks the TICKET INQUIRY button  
  
  Output      : Click on TICKET INQUIRY button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("TICKET INQUIRY");
      
} //ClickTicketInquiry

optionsPanel.prototype.ClickEnableRushMode = function () {  

/*------------------------------------------------------------------------
  Method      : ClickEnableRushMode()
  
  Description : This method Clicks the EnableRushMode button  
  
  Output      : Click on EnableRushMode button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("ENABLE\nRUSH\nMODE");
      
} //ClickEnableRushMode

optionsPanel.prototype.ClickOpenTicketsReport = function () {  

/*------------------------------------------------------------------------
  Method      : ClickOpenTicketsReport()
  
  Description : This method Clicks the OpenTicketsReport button  
  
  Output      : Click on OpenTicketsReport button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("OPEN TICKETS REPORT");
      
} //ClickOpenTicketsReport

optionsPanel.prototype.ClickOtherPayment = function () {  

/*------------------------------------------------------------------------
  Method      : ClickOtherPayment()
  
  Description : This method Clicks the OtherPayment button  
  
  Output      : Click on OtherPayment button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("OTHER PAYMENT");
      
} //ClickOtherPayment

optionsPanel.prototype.ClickReceipts = function () {  

/*------------------------------------------------------------------------
  Method      : ClickReceipts()
  
  Description : This method Clicks the Receipts button  
  
  Output      : Click on Receipts button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("RECEIPTS");
      
} //ClickReceipts

optionsPanel.prototype.ClickRushSelection = function () {  

/*------------------------------------------------------------------------
  Method      : ClickRushSelection()
  
  Description : This method Clicks the RushSelection button  
  
  Output      : Click on RushSelection button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("RUSH SELECTION");
      
} //ClickRushSelection

optionsPanel.prototype.ClickClosedTicketsReport = function () {  

/*------------------------------------------------------------------------
  Method      : ClickClosedTicketsReport()
  
  Description : This method Clicks the ClosedTicketsReport button  
  
  Output      : Click on ClosedTicketsReport button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("CLOSED TICKETS REPORT");
      
} //ClickClosedTicketsReport

optionsPanel.prototype.ClickMonthlyPayment = function () {  

/*------------------------------------------------------------------------
  Method      : ClickMonthlyPayment()
  
  Description : This method Clicks the MonthlyPayment button  
  
  Output      : Click on MonthlyPayment button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("MONTHLY PAYMENT");
      
} //ClickMonthlyPayment

optionsPanel.prototype.ClickLostClaim = function () {  

/*------------------------------------------------------------------------
  Method      : ClickLostClaim()
  
  Description : This method Clicks the LostClaim button  
  
  Output      : Click on LostClaim button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("LOST CLAIM");
      
} //ClickLostClaim

optionsPanel.prototype.ClickPrePay = function () {  

/*------------------------------------------------------------------------
  Method      : ClickPrePay()
  
  Description : This method Clicks the PrePay button  
  
  Output      : Click on PrePay button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("PREPAY");
      
} //ClickPrePay

optionsPanel.prototype.ClickNewMonthly = function () {  

/*------------------------------------------------------------------------
  Method      : ClickNewMonthly()
  
  Description : This method Clicks the NewMonthly button  
  
  Output      : Click on NewMonthly button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("NEW MONTHLY");
      
} //ClickNewMonthly 

optionsPanel.prototype.ClickEndOfDay = function () {  

/*------------------------------------------------------------------------
  Method      : ClickEndOfDay()
  
  Description : This method Clicks the EndOfDay button  
  
  Output      : Click on EndOfDay button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("END OF DAY");
      
} //ClickEndOfDay

optionsPanel.prototype.ClickReprintEndOfDay = function () {  

/*------------------------------------------------------------------------
  Method      : ClickReprintEndOfDay()
  
  Description : This method Clicks the ReprintEndOfDay button  
  
  Output      : Click on ReprintEndOfDay button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("REPRINT END OF DAY");
      
} //ClickReprintEndOfDay

optionsPanel.prototype.ClickTechnicianMenu = function () {  

/*------------------------------------------------------------------------
  Method      : ClickTechnicianMenu()
  
  Description : This method Clicks the TechnicianMenu button  
  
  Output      : Click on TechnicianMenu button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("TECHNICIAN MENU");
      
} //ClickTechnicianMenu

optionsPanel.prototype.ClickBackupTickets = function () {  

/*------------------------------------------------------------------------
  Method      : ClickBackupTickets()
  
  Description : This method Clicks the BackupTickets button  
  
  Output      : Click on BackupTickets button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("BACKUP TICKETS");
      
} //ClickBackupTickets

optionsPanel.prototype.ClickCorrectPayments = function () {  

/*------------------------------------------------------------------------
  Method      : ClickCorrectPayments()
  
  Description : This method Clicks the CorrectPayments button  
  
  Output      : Click on CorrectPayments button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("CORRECT PAYMENT");
      
} //ClickCorrectPayments

optionsPanel.prototype.ClickClosedTicketsByUser = function () {  

/*------------------------------------------------------------------------
  Method      : ClickClosedTicketsByUser()
  
  Description : This method Clicks the ClosedTicketsByUser button  
  
  Output      : Click on ClosedTicketsByUser button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("CLOSED TICKETS BY USER");
      
} //ClickClosedTicketsByUser

optionsPanel.prototype.ClickExpenses = function () {  

/*------------------------------------------------------------------------
  Method      : ClickExpenses()
  
  Description : This method Clicks the Expenses button  
  
  Output      : Click on Expenses button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("EXPENSES");
      
} //ClickExpenses

optionsPanel.prototype.ClickReservationMenu = function () {  

/*------------------------------------------------------------------------
  Method      : ClickReservationMenu()
  
  Description : This method Clicks the ReservationMenu button  
  
  Output      : Click on ReservationMenu button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("RESERVATION MENU");
      
} //ClickReservationMenu

optionsPanel.prototype.ClickUpdateVehicleInfo = function () {  

/*------------------------------------------------------------------------
  Method      : ClickUpdateVehicleInfo()
  
  Description : This method Clicks the UpdateVehicleInfo button  
  
  Output      : Click on UpdateVehicleInfo button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("UPDATE VEHICLE INFORMATION");
      
} //ClickUpdateVehicleInfo

optionsPanel.prototype.ClickCreditCardOffline = function () {  

/*------------------------------------------------------------------------
  Method      : ClickCreditCardOffline()
  
  Description : This method Clicks the CreditCardOffline button  
  
  Output      : Click on CreditCardOffline button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("CREDIT\r\nCARD\r\nOFFLINE");
      
} //ClickCreditCardOffline

optionsPanel.prototype.ClickBankDrop = function () {  

/*------------------------------------------------------------------------
  Method      : ClickBankDrop()
  
  Description : This method Clicks the BankDrop button  
  
  Output      : Click on BankDrop button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("BANK DROP");
      
} //ClickBankDrop

optionsPanel.prototype.ClickMonthlyMenu = function () {  

/*------------------------------------------------------------------------
  Method      : ClickMonthlyMenu()
  
  Description : This method Clicks the MonthlyMenu button  
  
  Output      : Click on MonthlyMenu button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("MONTHLY MENU");
      
} //ClickMonthlyMenu

optionsPanel.prototype.ClickEndOfShift = function () {  

/*------------------------------------------------------------------------
  Method      : ClickEndOfShift()
  
  Description : This method Clicks the EndOfShift button  
  
  Output      : Click on EndOfShift button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("END OF SHIFT");
      
} //ClickEndOfShift

optionsPanel.prototype.ClickReprintEndOfShift = function () {  

/*------------------------------------------------------------------------
  Method      : ClickReprintEndOfShift()
  
  Description : This method Clicks the ReprintEndOfShift button  
  
  Output      : Click on ReprintEndOfShift button if Options Panel Exists
------------------------------------------------------------------------*/  
  this.Click("REPRINT END OF SHIFT");
      
} //ClickReprintEndOfShift

optionsPanel.prototype.Click = function (btnName) {  

/*------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button in the parameter
  
  Output      : Click on given button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.Click"+btnName+": The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating optionsPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new optionsPanel();  
}