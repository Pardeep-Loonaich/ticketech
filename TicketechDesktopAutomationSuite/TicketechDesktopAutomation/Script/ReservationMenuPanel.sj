//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:ReservationMenuPanel
  
  Description: 
  
  This class has methods and properties to perform the Reservation Menu Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function reservationMenuPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: reservationMenuPanel() 
  
  Description: This method will the Instantiate the Reservation Menu Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlReservationMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelReservationMenu", 2);
  this.throwError = false; 
    
} //numericPanel

reservationMenuPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reservationMenuPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlReservationMenu.Exists;  //Return whether reservationMenuPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


reservationMenuPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at navigationPanel.Click"+btnName+": The Navigation Panel does not Exist.",
              message     : this.pnlNavigation + " Panel does not Exist." }             
    
    this.pnlReservationMenu.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click


reservationMenuPanel.prototype.ClickDailyReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickDailyReservation()
  
  Description : This method Clicks the Daily Reservation button  
  
  Output      : Click on Daily Reservation button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("DAILY RESERVATION")
  
} //ClickDailyReservation


reservationMenuPanel.prototype.ClickClosedReservationByProvider = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickClosedReservationByProvider()
  
  Description : This method Clicks the Closed Reservation By Provider button  
  
  Output      : Click on Closed Reservation By Provider button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("CLOSED RESERVATION BY PROVIDER")
  
} //ClickClosedReservationByProvider


reservationMenuPanel.prototype.ClickClosedReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickClosedReservation()
  
  Description : This method Clicks the Closed Reservation button  
  
  Output      : Click on Closed Reservation button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("CLOSED RESERVATION")
  
} //ClickClosedReservation


reservationMenuPanel.prototype.ClickOpenReservationByProvider = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickOpenReservationByProvider()
  
  Description : This method Clicks the Open Reservation By Provider button  
  
  Output      : Click on Open Reservation By Provider button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("OPEN RESERVATION BY PROVIDER")
  
} //ClickOpenReservationByProvider


reservationMenuPanel.prototype.ClickOpenReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickOpenReservation()
  
  Description : This method Clicks the Open Reservation button  
  
  Output      : Click on Open Reservation button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("OPEN RESERVATION")
  
} //ClickOpenReservation


reservationMenuPanel.prototype.ClickCurrentReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCurrentReservation()
  
  Description : This method Clicks the Current Reservation button  
  
  Output      : Click on Current Reservation button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("RESERVANCY")
  
} //ClickCurrentReservation


reservationMenuPanel.prototype.ClickNonValidReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickNonValidReservation()
  
  Description : This method Clicks the Non-Valid Reservation button  
  
  Output      : Click on Non-Valid Reservation button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("NON-VALID RESERVATION")
  
} //ClickNonValidReservation


reservationMenuPanel.prototype.ClickEventReservation = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickEventReservation()
  
  Description : This method Clicks the Event Reservation button  
  
  Output      : Click on Event Reservation button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("EVENT RESERVATION")
  
} //ClickEventReservation


reservationMenuPanel.prototype.ClickReservationInquiry = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickReservationInquiry()
  
  Description : This method Clicks the Reservation Inquiry button  
  
  Output      : Click on Reservation Inquiry button if Reservation Menu Panel Exists
--------------------------------------------------------------------------*/ 
  this.Click("RESERVATION INQUIRY")
  
} //ClickReservationInquiry


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ReservationMenuPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new reservationMenuPanel();  
}