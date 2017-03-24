//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------

  Name:TicketNumberVehicleTagPanel
  
  Description: 
  
  This class has methods and properties to perform the TicketNumberVehicleTagPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************/

function ticketNumberVehicleTagPanel() { 

/*-------------------------------------------------------------------------------------------- 
  Method: ticketNumberVehicleTagPanel() 
  
  Description: This method will the Instantiate the TicketNumberVehicleTagPanel Wrapper Helper
--------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTicketNumberVehicleTag =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTicketNumberVehicleTag", 2);
  this.throwError = false; 
    
} //ticketNumberVehicleTagPanel

ticketNumberVehicleTagPanel.prototype.Exists = function () {  

/*---------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketNumberVehicleTagPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
---------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTicketNumberVehicleTag.Exists;  //Return whether ticketNumberVehicleTagPanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at ticketNumberVehicleTagPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

ticketNumberVehicleTagPanel.prototype.ClickTagNumber = function () {  

/*-------------------------------------------------------------------------------
    Method      : ClickTagNumber()
  
    Description : This method Clicks the Tag Number button  
  
    Output      : Click on Tag Number button if TicketNumberVehicleTagPanel Exists
  ------------------------------------------------------------------------------*/  
  try{
  
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TicketNumberVehicleTagPanel.ClickTagNumber:: The TicketNumberVehicleTag Panel does not Exist.",
              message     : this.pnlTicketNumberVehicleTag + " Panel does not Exist." }             
    
    this.pnlTicketNumberVehicleTag.WaitWinFormsObject("ScreenButton", "TAG NUMBER", 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at ticketNumberVehicleTagPanel.ClickTagNumber");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickTagNumber


function New() {

/*----------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating ticketNumberVehicleTagPanel() class from other units of the project. 
-----------------------------------------------------------------------------------*/

  return new ticketNumberVehicleTagPanel();  
}