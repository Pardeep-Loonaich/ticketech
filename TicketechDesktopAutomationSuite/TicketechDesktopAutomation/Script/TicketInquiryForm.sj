//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT TicketInquiryOptionsPanel
//USEUNIT TicketInquiryScreen


/*************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryForm
  
  Description: 
  
  This class has methods and properties to perform the TicketInquiryForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function ticketInquiryForm() { 

/*--------------------------------------------------------------------- 
  Method: ticketInquiryForm() 
  
  Description: This method will Instantiate the ticketInquiryForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgTicketInquiry =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketInquiry", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objTicketInquiryOptionsPanel = TicketInquiryOptionsPanel.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objTicketInquiryScreen = TicketInquiryScreen.New();
  
  this.throwError = false; 
    
} //ticketInquiryForm


ticketInquiryForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketInquiryForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgTicketInquiry.Exists;  //Return whether ticketInquiryForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

ticketInquiryForm.prototype.ClickFindByVehicle = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickFindByVehicle()
  
  Description : This method Clicks FindByVehicle button  
  
  Output      : Clicks FindByVehicle button if ticketInquiryForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryForm.ClickFindByVehicle: The ticketInquiryForm does not Exist.",
              message     : this.dlgTicketInquiry + " The ticketInquiryForm does not Exist." }             
    
    this.objTicketInquiryOptionsPanel.ClickFindByVehicle();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickFindByVehicle

ticketInquiryForm.prototype.ClickFindByTicket = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickFindByTicket()
  
  Description : This method Clicks FindByTicket button  
  
  Output      : Clicks FindByTicket button if ticketInquiryForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryForm.ClickFindByTicket: The ticketInquiryForm does not Exist.",
              message     : this.dlgTicketInquiry + " The ticketInquiryForm does not Exist." }             
    
    this.objTicketInquiryOptionsPanel.ClickFindByTicket();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickFindByTicket

ticketInquiryForm.prototype.VerifyTicketInfo = function (objTestData) { 
/*-----------------------------------------------------------------------------------------------------
  Method      : GetFormInfo()
  
  Description : This method is for getting Grid rows by column header
  
  Output      : Gets the Grid rows based on the Column in the TicketInquiryForm
-----------------------------------------------------------------------------------------------------*/ 
  try {
    
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryForm.GetFormInfo: The ticketInquiry Screen does not Exist.",
              message     : this.dlgTicketInquiry + " Screen does not Exist." }   
    
    Delay(2000);
  
    eVehicleData = this.objTicketInquiryScreen.GetTicketDetails();
             
    eVehicleData.bResult = objTestData.sTicketNumber == eVehicleData.sTicketNumber && objTestData.sVehicleTag == eVehicleData.sVehicleTag;
  
    return eVehicleData;

  }
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ticketInquiryForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new ticketInquiryForm();  
}