//USEUNIT Utility

/**************************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the TimekeeperOptions panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************************/

function ticketInquiryOptionsPanel() { 

/*---------------------------------------------------------------------------------------- 
  Method: ticketInquiryOptionsPanel() 
  
  Description: This method will the Instantiate the ticketInquiryOptionsPanel Wrapper Helper
----------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTicketInquiryOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTicketInquiryOptions", 2000);
  this.throwError = false; 
    
} //ticketInquiryOptionsPanel

ticketInquiryOptionsPanel.prototype.Exists = function () {  

/*------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketInquiryOptionsPanel.  
  
  Output       : True if Panel Exists
                False if Panel does not Exists   
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTicketInquiryOptions.Exists;  //Return whether ticketInquiryOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

ticketInquiryOptionsPanel.prototype.Click = function (btnName) {  

/*-------------------------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if TicketInquiryOptions Panel Exists
-------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryOptionsPanel.Click"+btnName+": The TicketInquiryOptions Panel does not Exist.",
              message     : this.pnlTicketInquiryOptions + " Panel does not Exist." }             
    
    this.pnlTicketInquiryOptions.FindChild(["WndCaption","Visible"] ,[btnName,true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click


ticketInquiryOptionsPanel.prototype.IsBtnVisible = function (btnName) {  

/*---------------------------------------------------------------------------------------------
  Method      : IsBtnVisible(btnName)
  
  Description : This method Checks the required button given as the parameter is visible/available 
  
  Output      : Checks the required button is visible/available if TicketInquiryOptions Panel Exists
----------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryOptionsPanel.IsBtnVisible"+btnName+": The TicketInquiryOptions Panel does not Exist.",
              message     : this.pnlTicketInquiryOptions + " Panel does not Exist." }             
    
   return this.pnlTicketInquiryOptions.FindChild("WndCaption", btnName,2).Visible;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //IsBtnVisible

ticketInquiryOptionsPanel.prototype.ClickApplyReservation = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickApplyReservation()
  
  Description : This method Clicks the ApplyReservation button  
  
  Output      : Click on ApplyReservation button if TicketInquiryOptions Panel Exists
-----------------------------------------------------------------------------*/  
  this.Click("APPLY RESERVATION");
      
} //ClickApplyReservation

ticketInquiryOptionsPanel.prototype.ClickNextTicket = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickNextTicket()
  
  Description : This method Clicks the NextTicket button  
  
  Output      : Click on NextTicket button if TicketInquiryOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("NEXT TICKET");
      
} //ClickNextTicket

ticketInquiryOptionsPanel.prototype.ClickFindByCoupon = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickFindByCoupon()
  
  Description : This method Clicks the FindByCoupon button  
  
  Output      : Click on FindByCoupon button if TicketInquiryOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("FIND BY COUPON");
      
} //ClickFindByCoupon

ticketInquiryOptionsPanel.prototype.ClickFindByVehicle = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickFindByVehicle()
  
  Description : This method Clicks the FindByVehicle button  
  
  Output      : Click on FindByVehicle button if TicketInquiryOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("FIND BY VEHICLE");
      
} //ClickFindByVehicle

ticketInquiryOptionsPanel.prototype.ClickFindByTicket = function () {  

/*----------------------------------------------------------------------------
  Method      : ClickFindByTicket()
  
  Description : This method Clicks the FindByTicket button  
  
  Output      : Click on FindByTicket button if TicketInquiryOptions Panel Exists
----------------------------------------------------------------------------*/  
  this.Click("FIND BY TICKET");
      
} //ClickFindByTicket

function New() {

/*------------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ticketInquiryOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------------*/

  return new ticketInquiryOptionsPanel();  
}