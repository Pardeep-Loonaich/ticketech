//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT MenuScreen
//USEUNIT TechnicianOptionsPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:TechnicianMenuForm
  
  Description: 
  
  This class has methods and properties to perform the TechnicianMenuForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function technicianMenuForm() { 

/*--------------------------------------------------------------------- 
  Method: technicianMenuForm() 
  
  Description: This method will the Instantiate the technicianMenuForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTechnicianOptions =  Sys.Process("PosApplication").WaitWinFormsObject("FormTechnicianMenu", 3000);   
  this.technicianOptionsPanel = TechnicianOptionsPanel.New();
  this.navigationPanel = NavigationPanel.New();
  this.menuScreen = MenuScreen.New();
  
  this.throwError = false; 
    
} //technicianMenuForm

technicianMenuForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the technicianMenuForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.pnlTechnicianOptions =  Sys.Process("PosApplication").WaitWinFormsObject("FormTechnicianMenu", 3000);   
    this.technicianOptionsPanel = TechnicianOptionsPanel.New();
    this.navigationPanel = NavigationPanel.New();
    this.menuScreen = MenuScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

technicianMenuForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the technicianMenuForm.  
  
  Output: True if panel Exists
          False if panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTechnicianOptions.Exists;  //Return whether technicianMenuForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

technicianMenuForm.prototype.EnableManualTicketEntry = function () {  

/*--------------------------------------------------------------------------
  Method      : EnableManualTicketEntry()
  
  Description : This method Clicks Manual Ticket Entry button, if Manual ticket entry is disabled  
  
  Output      : Clicks Manual Ticket Entry button if TechnicianMenuForm Form Exists
--------------------------------------------------------------------------*/  
  try {
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TechnicianMenuForm.EnableManualTicketEntry: The TechnicianMenuForm Form does not Exist.",
              message     : this.pnlTechnicianOptions + " The TechnicianMenuForm Form does not Exist." }   
              
      if(!this.menuScreen.ConfirmManualTicketEntryMessage()) { 
        this.technicianOptionsPanel.ClickManualTicketEntry();
        this.navigationPanel.ClickCancel();
        Log.Message("Manual ticket entry enabled")
        }
        else {
        Log.Message("Manual ticket entry already enabled")
        }
    }//End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnableManualTicketEntry

technicianMenuForm.prototype.DisableManualTicketEntry = function () {  

/*--------------------------------------------------------------------------
  Method      : DisableManualTicketEntry()
  
  Description : This method Clicks Manual Ticket Entry button, if Manual ticket entry is enabled  
  
  Output      : Clicks Manual Ticket Entry button if TechnicianMenuForm Form Exists
--------------------------------------------------------------------------*/  
  try {
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TechnicianMenuForm.DisableManualTicketEntry: The TechnicianMenuForm Form does not Exist.",
              message     : this.pnlTechnicianOptions + " The TechnicianMenu Form does not Exist." }   
              
      if(this.menuScreen.ConfirmManualTicketEntryMessage() === true) {
        this.technicianOptionsPanel.ClickManualTicketEntry();
        this.navigationPanel.ClickCancel();
        Log.Message("Manual ticket entry disabled")
        }
        else {
        Log.Message("Manual ticket entry already disabled")
        }
    }//End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //DisableManualTicketEntry

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating technicianMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new technicianMenuForm();  
}