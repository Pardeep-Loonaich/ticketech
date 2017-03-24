//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT TicketInquiryUpdateScreen
//USEUNIT ColorPanel
//USEUNIT MakesPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryVehicleUpdateForm
  
  Description: it contains all method of ticketInquiryVehicleUpdate
  
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/
//variable deceleration 
var objTicketInquiryUpdateScrn;
var objColorPanel;
var objMakesPanel;
var objNavigationPanel;

function ticketInquiryVehicleUpdateForm() { 

/*------------------------------------------------------------------------- 
  Method: TicketInquiryVehicleUpdateForm() 
  
  Description: This method will the Instantiate the TicketInquiryVehicleUpdateForm Wrapper
-------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgTicketInquiryVehicleUpdate =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketInquiryVehicleUpdate*", 3000); 
  
  this.objTicketInquiryUpdateScrn = TicketInquiryUpdateScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //TicketInquiryVehicleUpdateForm

ticketInquiryVehicleUpdateForm.prototype.Refresh = function () {  

/*-----------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the TicketInquiryVehicleUpdateForm Wrapper   
-----------------------------------------------------------------------------*/  
  try {

    this.dlgTicketInquiryVehicleUpdate =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketInquiryVehicleUpdate*", 3000); 
  
    this.objTicketInquiryUpdateScrn = TicketInquiryUpdateScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

ticketInquiryVehicleUpdateForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the vehicle info form.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgTicketInquiryVehicleUpdate.Exists;  //Return whether TicketInquiryVehicleUpdateForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


 ticketInquiryVehicleUpdateForm.prototype.provideVehicleDetails = function (eVehicleDetails)   {  

/*-------------------------------------------------------------------------
  Method      : provideVehicleDetails()
  
  Description : This method will enter vehicle plate number, color and make    
-------------------------------------------------------------------------*/ 
  try { 
  
    this.objTicketInquiryUpdateScrn.EnterPlateNumber(eVehicleDetails.sPlateNumber);
    this.objNavigationPanel.ClickEnter();
    
    this.Refresh();Delay(3000);
  
    objColorPanel = ColorPanel.New();
    objColorPanel.SelectColor(eVehicleDetails.sColor);
  
    this.Refresh();Delay(5000);
  
    objMakesPanel = MakesPanel.New();
    objMakesPanel.SelectVehicleMake(eVehicleDetails.sVehicleMake);
  
    Delay(2000);
   
  } // End Try
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
    
  } //End catch 
   
} //provideVehicleDetails

function New() {

/*---------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating TicketInquiryVehicleUpdateForm() class from other units of the project. 
-----------------------------------------------------------------------------------------*/

  return new ticketInquiryVehicleUpdateForm();  
}

