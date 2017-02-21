//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:TechnicianOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the Technician Options Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function technicianOptionsPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: technicianOptionsPanel() 
  
  Description: This method will the Instantiate the Reservation Menu Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTechnicianOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTechnicianOptions", 3);
  this.throwError = false; 
    
} //technicianOptionsPanel

technicianOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the technicianOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTechnicianOptions.Exists;  //Return whether technicianOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


technicianOptionsPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Technician Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at pnlTechnicianOptions.Click"+btnName+": The Technician Panel does not Exist.",
              message     : this.pnlTechnicianOptions + " Panel does not Exist." }             
    
    this.pnlTechnicianOptions.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click


technicianOptionsPanel.prototype.ClickManualTicketEntry = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickManualTicketEntry()
  
  Description : This method Clicks the Manual Ticket Entry button  
  
  Output      : Click on Manual Ticket Entry button if Technician Options Panel Exists
--------------------------------------------------------------------------*/  
  Delay(1000);   
  this.Click("MANUAL TICKET ENTRY")
  
} //ClickManualTicketEntry


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating technicianOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new technicianOptionsPanel();  
}