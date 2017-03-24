//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT ReservationInquiryInfoScreen


/*************************************************************************
            ---------- Class Definition ----------
  Name:ReservationsInquiryReportParametersForm
  
  Description: 
  
  This class has methods and properties to perform the ReservationsInquiryReportParametersForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function reservationsInquiryReportParametersForm() { 

/*--------------------------------------------------------------------- 
  Method: reservationsInquiryReportParametersForm() 
  
  Description: This method will the Instantiate the reservationsInquiryReportParametersForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmReservationsInquiryReportParameters =  Sys.Process("PosApplication").WaitWinFormsObject("FormReservationsInquiryReportParameters", 3000); 
    
  this.objNavigationPanel = NavigationPanel.New();
  this.objReservationInquiryInfoScreen = ReservationInquiryInfoScreen.New();
  
  this.throwError = false; 
    
} //reservationsInquiryReportParametersForm

reservationsInquiryReportParametersForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the reservationInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
   
    this.frmReservationsInquiryReportParameters =  Sys.Process("PosApplication").WaitWinFormsObject("FormReservationsInquiryReportParameters", 3000); 
  
    this.objNavigationPanel = NavigationPanel.New();
    this.objReservationInquiryInfoScreen = ReservationInquiryInfoScreen.New();
        
    } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

reservationsInquiryReportParametersForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reservationsInquiryReportParametersForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    return this.frmReservationsInquiryReportParameters.Exists;  //Return whether reservationsInquiryReportParametersForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reservationsInquiryReportParametersForm.prototype.SetBarCode = function (objTestData) {  

/*--------------------------------------------------------------------------
  Method      : EnterBarCode()
  
  Description : This method enters BarCode and clicks Enter button  
  
  Output      : Enters BarCode if Reservations Inquiry Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationsInquiryReportParametersForm.EnterBarCode: The Reservation Inquiry Form does not Exist.",
              message     : this.frmReservationsInquiryReportParameters + " The Reservation Info Form does not Exist." }             
    
    Delay(1000);
              
    this.objReservationInquiryInfoScreen.SetBarCode(objTestData.sBarcode);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetBarCode

reservationsInquiryReportParametersForm.prototype.SetFirstName = function (objTestData) {  

/*--------------------------------------------------------------------------
  Method      : EnterFirstName()
  
  Description : This method enters first name and clicks Enter button  
  
  Output      : Enters first name if Reservations Inquiry Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationsInquiryReportParametersForm.EnterFirstName: The Reservation Inquiry Form does not Exist.",
              message     : this.frmReservationsInquiryReportParameters + " The Reservation Info Form does not Exist." }             
    
    Delay(1000);
    
    this.objReservationInquiryInfoScreen.EnterFirstName(objTestData.sFirstname);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetFirstName

reservationsInquiryReportParametersForm.prototype.SetLastName = function (objTestData) {  

/*--------------------------------------------------------------------------
  Method      : EnterLastName()
  
  Description : This method enters last name and clicks Enter button  
  
  Output      : Enters last name if Reservations Inquiry Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationsInquiryReportParametersForm.EnterLastName: The Reservation Inquiry Form does not Exist.",
              message     : this.frmReservationsInquiryReportParameters + " The Reservation Info Form does not Exist." }             
    Delay(1000);
      
    this.objReservationInquiryInfoScreen.EnterLastName(objTestData.sLastname);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetLastName


reservationsInquiryReportParametersForm.prototype.FillAndSubmitReservationInquiry = function (objTestData) {  

/*--------------------------------------------------------------------------
  Method      : FillAndSubmitReservationInquiry()
  
  Description : This method enters BarCode, first name and last name on reservation inquiry form  
  
  Output      : Fill and Submit reservation inquiry form
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationsInquiryReportParametersForm.FillAndSubmitReservationInquiry: The Reservation Inquiry Form does not Exist.",
              message     : this.frmReservationsInquiryReportParameters + " The Reservation Inquiry Form does not Exist." }             
    
    Delay(1000);              
    this.objReservationInquiryInfoScreen.EnterBarcode(objTestData.sBarcode);
    Delay(1000);    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    this.objReservationInquiryInfoScreen.EnterFirstName(objTestData.sFirstname);
    Delay(1000);    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    this.objReservationInquiryInfoScreen.EnterLastName(objTestData.sLastname);
    Delay(1000);    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);            
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //FillAndSubmitReservationInquiry


reservationsInquiryReportParametersForm.prototype.GetFooterMessage = function () {  

/*--------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns footer status of reservation inquiry info form  
  
  Output      : returns foother message of reservation inquiry info form
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationsInquiryReportParametersForm.GetFooterMessage: The Reservation Inquiry Form does not Exist.",
              message     : this.frmReservationsInquiryReportParameters + " The Reservation Info Form does not Exist." }             
    
    return this.objReservationInquiryInfoScreen.GetFooterMessage();
    Delay(1000);        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch     
} //GetFooterMessage


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating reservationsInquiryReportParametersForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reservationsInquiryReportParametersForm();  
}
