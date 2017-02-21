//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT TicketNumberScreen


/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInTicketNumberForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInTicketNumberForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInTicketNumberForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInTicketNumberForm() 
  
  Description: This method will the Instantiate the checkInTicketNumberForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmCheckInTicketNumber =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInTicketNumber", 3000);   
  this.navigationPanel = NavigationPanel.New();
  this.ticketNumberScreen = TicketNumberScreen.New();
  
  this.throwError = false; 
    
} //checkInTicketNumberForm

checkInTicketNumberForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkInTicketNumberForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.frmCheckInTicketNumber =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInTicketNumber", 3000);   
    this.navigationPanel = NavigationPanel.New();
    this.ticketNumberScreen = TicketNumberScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkInTicketNumberForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInTicketNumberForm.  
  
  Output: True if form Exists
          False if panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmCheckInTicketNumber.Exists;  //Return whether checkInTicketNumberForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkInTicketNumberForm.prototype.SetTicketNumber = function (sTicketNumber) {  

/*--------------------------------------------------------------------------
  Method      : SetTicketNumber()
  
  Description : This method Enters ticket number , if checkInTicketNumberForm exists
  
  Output      : Enters ticket number  if checkInTicketNumberForm Form Exists
--------------------------------------------------------------------------*/  
  try {
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at CheckInTicketNumberForm.SetTicketNumber: The CheckInTicketNumberForm Form does not Exist.",
              message     : this.frmCheckInTicketNumber + " The CheckInTicketNumberForm Form does not Exist." }                 

        this.ticketNumberScreen.EnterTicketNumber(sTicketNumber);
        Log.Message(sTicketNumber + "-Ticket number entered manually")        
    }//End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetTicketNumber


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInTicketNumberForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInTicketNumberForm();  
}