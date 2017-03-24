//USEUNIT Utility
//USEUNIT TicketNumberScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT TicketNumberVehicleTagPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:TicketNumberForm
  
  Description: 
  
  This class has methods and properties to perform the TicketNumberForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function ticketNumberForm() { 

/*--------------------------------------------------------------------- 
  Method: ticketNumberForm() 
  
  Description: This method will the Instantiate the ticketNumberForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmTicketNumberForm =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketNumber", 3000); 
  
  this.objTicketNumberScreen = TicketNumberScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objNumericPanel = NumericPanel.New();
  this.objTicketNumberVehicleTagPanel = TicketNumberVehicleTagPanel.New();
  
  this.throwError = false; 
    
} //ticketNumberForm

ticketNumberForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the ticketNumberForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.frmTicketNumberForm =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketNumber", 3000); 
  
    this.objTicketNumberScreen = TicketNumberScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objNumericPanel = NumericPanel.New();
    this.objTicketNumberVehicleTagPanel = TicketNumberVehicleTagPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

ticketNumberForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketNumberForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmTicketNumberForm.Exists;  //Return whether checkInCustomerInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

ticketNumberForm.prototype.NavigateToTagNumber = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToTagNumber()
  
  Description : This method clicks Tag Number button
  
  Output      : Clicks Tag Number button if ticketNumberForm Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketNumberForm.NavigateToTagNumber: The Ticket Number Form does not Exist.",
              message     : this.frmTicketNumberForm + " The frmTicketNumberForm Form does not Exist." }                 
        
    this.objTicketNumberVehicleTagPanel.ClickTagNumber();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToTagNumber

ticketNumberForm.prototype.SetTicketNumber = function (sTicketNumber) {  

/*--------------------------------------------------------------------------
  Method      : SetTicketNumber()
  
  Description : This method enters Ticket Number  
  
  Output      : Enters Ticket Number if TicketNumber Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TicketNumberForm.SetTicketNumber: The Ticket Number Form does not Exist.",
              message     : this.frmTicketNumberForm + " The Ticket Number Form does not Exist." }             
    
    this.objTicketNumberScreen.EnterTicketNumber(sTicketNumber);
    Delay(1000);
    
  } //End try

  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetTicketNumber

ticketNumberForm.prototype.InputAndSubmitFormWithErrors = function (sTicketNumber) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
  
  Description : This method enters ticket number/tag number and click enter button
  
  Output      : Enters ticket number/tag number in ticketNumberForm and click enter button
--------------------------------------------------------------------------*/  
  try {
  
    this.SetTicketNumber(sTicketNumber);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.objTicketNumberScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputAndSubmitFormWithErrors


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ticketNumberForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new ticketNumberForm();  
}

