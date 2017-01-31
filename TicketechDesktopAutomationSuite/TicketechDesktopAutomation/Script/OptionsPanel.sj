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
  
  this.pnlOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelOptions", 2000);
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
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickNext: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["NEXT >>", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickNext

optionsPanel.prototype.ClickVehicleInventory = function () {  

/*------------------------------------------------------------------------
  Method      : ClickVehicleInventory()
  
  Description : This method Clicks the Vehicle Inventory button  
  
  Output      : Click on Vehicle Inventory button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickVehicleInventory: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["VEHICLE INVENTORY", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickVehicleInventory

optionsPanel.prototype.ClickTicketInquiry = function () {  

/*------------------------------------------------------------------------
  Method      : ClickTicketInquiry()
  
  Description : This method Clicks the TICKET INQUIRY button  
  
  Output      : Click on TICKET INQUIRY button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickTicketInquiry: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["TICKET INQUIRY", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickTicketInquiry

optionsPanel.prototype.ClickEnableRushMode = function () {  

/*------------------------------------------------------------------------
  Method      : ClickEnableRushMode()
  
  Description : This method Clicks the EnableRushMode button  
  
  Output      : Click on EnableRushMode button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickEnableRushMode: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["ENABLE\nRUSH\nMODE", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickEnableRushMode

optionsPanel.prototype.ClickOpenTicketsReport = function () {  

/*------------------------------------------------------------------------
  Method      : ClickOpenTicketsReport()
  
  Description : This method Clicks the OpenTicketsReport button  
  
  Output      : Click on OpenTicketsReport button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickOpenTicketsReport: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["OPEN TICKETS REPORT", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickOpenTicketsReport

optionsPanel.prototype.ClickOtherPayment = function () {  

/*------------------------------------------------------------------------
  Method      : ClickOtherPayment()
  
  Description : This method Clicks the OtherPayment button  
  
  Output      : Click on OtherPayment button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickOtherPayment: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["OTHER PAYMENT", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickOtherPayment

optionsPanel.prototype.ClickReceipts = function () {  

/*------------------------------------------------------------------------
  Method      : ClickReceipts()
  
  Description : This method Clicks the Receipts button  
  
  Output      : Click on Receipts button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickReceipts: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["RECEIPTS", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickReceipts

optionsPanel.prototype.ClickRushSelection = function () {  

/*------------------------------------------------------------------------
  Method      : ClickRushSelection()
  
  Description : This method Clicks the RushSelection button  
  
  Output      : Click on RushSelection button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickRushSelection: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["RUSH SELECTION", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickRushSelection

optionsPanel.prototype.ClickClosedTicketsReport = function () {  

/*------------------------------------------------------------------------
  Method      : ClickClosedTicketsReport()
  
  Description : This method Clicks the ClosedTicketsReport button  
  
  Output      : Click on ClosedTicketsReport button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickClosedTicketsReport: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["CLOSED TICKETS REPORT", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickClosedTicketsReport

optionsPanel.prototype.ClickMonthlyPayment = function () {  

/*------------------------------------------------------------------------
  Method      : ClickMonthlyPayment()
  
  Description : This method Clicks the MonthlyPayment button  
  
  Output      : Click on MonthlyPayment button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickMonthlyPayment: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["MONTHLY PAYMENT", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickMonthlyPayment

optionsPanel.prototype.ClickLostClaim = function () {  

/*------------------------------------------------------------------------
  Method      : ClickLostClaim()
  
  Description : This method Clicks the LostClaim button  
  
  Output      : Click on LostClaim button if Options Panel Exists
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsPanel.ClickLostClaim: The Options Panel does not Exist.",
              message     : this.pnloptions + " Panel does not Exist." }             
    
    this.pnloptions.FindChild(["WndCaption","Visible"], ["LOST CLAIM", true], 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickLostClaim

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating optionsPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new optionsPanel();  
}