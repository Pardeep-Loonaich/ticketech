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


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ReservationMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reservationMenuForm();  
}