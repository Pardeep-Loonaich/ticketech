//USEUNIT Utility
//USEUNIT ReservationMenuPanel

/**************************************************************************
            ---------- Class Definition ----------
  Name:ReservationMenuForm
  
  Description: 
  
  This class has methods and properties to perform the ReservationMenuForm Form objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function reservationMenuForm() { 

/*--------------------------------------------------------------------------- 
  Method: reservationMenuForm() 
  
  Description: This method will the Instantiate the reservationMenuForm Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmReservationMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "FormReservationMenu", 2000);
  this.objReservationMenuPanel = ReservationMenuPanel.New();
  this.throwError = false; 
    
} //reservationMenuForm

reservationMenuForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reservationMenuForm.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmReservationMenu.Exists;  //Return whether reservationMenuForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


reservationMenuForm.prototype.ClickDailyReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickDailyReservation()
  
  Description : This method Clicks the Daily Reservation button  
  
  Output      : Click on Daily Reservation button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickDailyReservation();
      
} //ClickDailyReservation

reservationMenuForm.prototype.ClickReservationInquiry = function () {  

/*-----------------------------------------------------------------
  Method      : ClickReservationInquiry()
  
  Description : This method Clicks the Reservation Inquiry button  
  
  Output      : Click on Reservation Inquiry button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickReservationInquiry();
      
} //ClickReservationInquiry

reservationMenuForm.prototype.ClickEventReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickEventReservation()
  
  Description : This method Clicks the Event Reservation button  
  
  Output      : Click on Event Reservation button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickEventReservation();
      
} //ClickEventReservation

reservationMenuForm.prototype.ClickNonValidReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickNonValidReservation()
  
  Description : This method Clicks on Non-Valid Reservation button  
  
  Output      : Click on Non-Valid Reservation button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickNonValidReservation();
      
} //ClickNonValidReservation

reservationMenuForm.prototype.ClickOpenReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickOpenReservation()
  
  Description : This method Clicks on Open Reservation button  
  
  Output      : Click on Open Reservation button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickOpenReservation();
      
} //ClickOpenReservation

reservationMenuForm.prototype.ClickOpenReservationByProvider = function () {  

/*-----------------------------------------------------------------
  Method      : ClickOpenReservationByProvider()
  
  Description : This method Clicks on Open Reservation By Provider button  
  
  Output      : Click on Open Reservation By Provider button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickOpenReservationByProvider();
      
} //ClickOpenReservationByProvider

reservationMenuForm.prototype.ClickClosedReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickClosedReservation()
  
  Description : This method Clicks on Closed Reservation button  
  
  Output      : Click on Closed Reservation button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickClosedReservation();
      
} //ClickClosedReservation

reservationMenuForm.prototype.ClickCurrentReservation = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCurrentReservation()
  
  Description : This method Clicks on Current Reservation button  
  
  Output      : Click on Current Reservation button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickCurrentReservation();
      
} //ClickCurrentReservation

reservationMenuForm.prototype.ClickClosedReservationByProvider = function () {  

/*-----------------------------------------------------------------
  Method      : ClickClosedReservationByProvider()
  
  Description : This method Clicks on Closed Reservation By Provider button  
  
  Output      : Click on Closed Reservation By Provider button if Reservation Menu Panel Exists
-----------------------------------------------------------------*/  
  this.objReservationMenuPanel.ClickClosedReservationByProvider();
      
} //ClickClosedReservationByProvider

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ReservationMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reservationMenuForm();  
}