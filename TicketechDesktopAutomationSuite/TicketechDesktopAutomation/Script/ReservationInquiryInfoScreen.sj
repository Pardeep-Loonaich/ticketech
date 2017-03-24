//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:ReservationInquiryInfoScreen
  
  Description: 
  
  This class has methods and properties to perform the ReservationInquiryInfoScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function reservationInquiryInfoScreen() { 

/*----------------------------------------------------------------------------------- 
  Method: reservationInquiryInfoScreen() 
  
  Description: This method will the Instantiate the reservationInquiryInfoScreen Wrapper Helper
-----------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnReservationInquiryInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenReservationInquiryInfo", 3);
  this.throwError = false; 
    
} //reservationsMenuScreen

reservationInquiryInfoScreen.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the Reservations Menu Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnReservationInquiryInfo.Exists;  //Return whether reservationsMenuScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reservationInquiryInfoScreen.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method refresh the objects of the Reservations inquiry Screen.  
  
  Output:   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    this.scrnReservationInquiryInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenReservationInquiryInfo", 3);
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh


reservationInquiryInfoScreen.prototype.EnterBarcode = function (sBarcode) {  

/*-------------------------------------------------------------------------------
  Method      : EnterBarcode()
  
  Description : This method enters barcode on the Reservations inquiry Screen 
  
  Output      : This method enters barcode on the Reservations inquiry Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationInquiryInfoScreen "+barcode+": The Reservations Inquiry screen does not Exist.",
              message     : this.scrnReservationInquiryInfo + " Screen does not Exist." }             
    
    this.scrnReservationInquiryInfo.WinFormsObject("selectableTextBoxBarcode").WinFormsObject("maskedTextBoxInfo").Keys(sBarcode);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterBarcode

reservationInquiryInfoScreen.prototype.EnterFirstName = function (firstname) {  

/*-------------------------------------------------------------------------------
  Method      : EnterFirstName()
  
  Description : This method enters first name on the Reservations inquiry Screen 
  
  Output      : This method enters first name on the Reservations inquiry Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EnterFirstName "+firstname+": The Reservations Inquiry screen does not Exist.",
              message     : this.scrnReservationInquiryInfo + " Screen does not Exist." }             
    
    this.scrnReservationInquiryInfo.WinFormsObject("selectableTextBoxFirstName").WinFormsObject("maskedTextBoxInfo").Keys(firstname);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterFirstName

reservationInquiryInfoScreen.prototype.EnterLastName = function (lastname) {  

/*-------------------------------------------------------------------------------
  Method      : EnterLastName()
  
  Description : This method enters last name on the Reservations inquiry Screen 
  
  Output      : This method enters last name on the Reservations inquiry Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EnterFirstName "+lastname+": The Reservations Inquiry screen does not Exist.",
              message     : this.scrnReservationInquiryInfo + " Screen does not Exist." }             
    
    this.scrnReservationInquiryInfo.WinFormsObject("selectableTextBoxLastName").WinFormsObject("maskedTextBoxInfo").Keys(lastname);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterLastName

reservationInquiryInfoScreen.prototype.GetFooterMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the current FooterMessage in the reservation Inquiry Info screen 
  
  Output      : Returns the current FooterMessage in the reservation Inquiry Info screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationInquiryInfoScreen.Get"+objControlName+": The reservationInquiryInfo screen does not Exist.",
              message     : this.scrnReservationInquiryInfo + " Screen does not Exist." }             
    
    //return this.scrnReservationInquiryInfo.FindChild("WinFormsControlName", objControlName, 2).Text;    
    return this.scrnReservationInquiryInfo.WinFormsObject("screenInformationFooter").WinFormsObject("labelInformation").WndCaption;
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetFooterMessage

function New() {

/*------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating reservationInquiryInfoScreen() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new reservationInquiryInfoScreen();  
}