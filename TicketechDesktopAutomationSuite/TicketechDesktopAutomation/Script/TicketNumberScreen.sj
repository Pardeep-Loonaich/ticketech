//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:TicketNumberScreen
  
  Description: 
  
  This class has methods and properties to perform the TicketNumberScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function ticketNumberScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: ticketNumberScreen() 
  
  Description: This method will the Instantiate the TicketNumberScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnTicketNumber =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenTicketNumber", 3);
  
  this.throwError = false; 
    
} //ticketNumberScreen

ticketNumberScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketNumberScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnTicketNumber.Exists;  //Return whether ticketNumberScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

ticketNumberScreen.prototype.EnterTicketNumber = function (sTicketNumber) {  

/*-------------------------------------------------------------------------------
  Method      : EnterTicketNumber()
  
  Description : This method enters the Ticket Number in the Ticket Number screen
  
  Output      : Enters the Ticket Number in the Ticket Number screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketNumberScreen.EnterTicketNumber: The Ticket Number screen Exist.",
              message     : this.scrnTicketNumber + " Screen Exist." }             
    
    if (sTicketNumber !== undefined && sTicketNumber !== null)      
      Sys.Process("PosApplication").WinFormsObject("FormCheckInTicketNumber").WinFormsObject("ScreenTicketNumber").WinFormsObject("selectableTextBoxTicket").WinFormsObject("labelTextBox").Keys(sTicketNumber);
      Delay(1000);
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterTicketNumber


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ticketNumberScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new ticketNumberScreen();  
}