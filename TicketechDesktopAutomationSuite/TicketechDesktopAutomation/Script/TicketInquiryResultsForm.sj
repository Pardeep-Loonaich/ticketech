//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT TicketInquiryResultsScreen




/*************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryResultsForm
  
  Description: 
  
  This class has methods and properties to perform the TicketInquiryResultsForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function ticketInquiryResultsForm() { 

/*--------------------------------------------------------------------- 
  Method: ticketInquiryResultsForm() 
  
  Description: This method will the Instantiate the ticketInquiryResultsForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgTicketInquiryResults =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketInquiryResults", 3000); 
  
  this.ticketInquiryResultsScreen = TicketInquiryResultsScreen.New();
  this.navigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //ticketInquiryResultsForm

ticketInquiryResultsForm.prototype.Refresh = function () {  

/*----------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the ticketInquiryResultsForm Wrapper   
-----------------------------------------------------------------------------------------*/  
  try {
   
    this.dlgTicketInquiryResults =  Sys.Process("PosApplication").WaitWinFormsObject("FormTicketInquiryResults", 3000); 

    this.ticketInquiryResultsScreen = TicketInquiryResultsScreen.New();
    this.navigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

ticketInquiryResultsForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketInquiryResultsForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  

    return this.dlgTicketInquiryResults.Exists;  //Return whether ticketInquiryResultsForm exists or not
      
} //Exists


ticketInquiryResultsForm.prototype.IsTicketAvailable = function (sTicketNo) {  

/*------------------------------------------------------------------------------------------------------------------------------
  Method      : IsTicketAvailable()
  
  Description : This method finds the Ticket number for the entered vehicle details  
  
  Output      : Finds the Ticket number for the entered vehicle details if TicketInquiryResults Form Exists
-------------------------------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formTicketInquiryResults.NavigateToCorrectEmployeeForm: The TicketInquiryResults Form does not Exist.",
              message     : this.dlgTicketInquiryResults + " The TicketInquiryResults Form does not Exist." }
                
    return this.ticketInquiryResultsScreen.MoveToTicketDataRow(sTicketNo);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //IsTicketAvailable



function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ticketInquiryResultsForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new ticketInquiryResultsForm();  
}