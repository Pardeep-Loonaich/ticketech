//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:PrintTimecardOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the PrintTimecardOptions Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function printTimecardOptionsPanel() { 

/*--------------------------------------------------------------------------- 
  Method: printTimecardOptionsPanel() 
  
  Description: This method will the Instantiate the printTimecardOptionsPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlPrintTimecardOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelPrintTimecardOptions", 2000);
  this.throwError = false; 
    
} //printTimecardOptionsPanel

printTimecardOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the printTimecardOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlPrintTimecardOptions.Exists;  //Return whether printTimecardOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at printTimecardOptionsPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

printTimecardOptionsPanel.prototype.ClickAllEmployees = function () {  

/*------------------------------------------------------
  Method      : ClickAllEmployees()
  
  Description : This method Clicks All Employees button 
  
  Output      : Clicks Back button if PrintTimecardOptions Panel Exists
------------------------------------------------------*/  
  try {
    
    bButtonClicked = false;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at PrintTimecardOptionsPanel.ClickAllEmployees: The PrintTimecardOptions Panel does not Exist.",
              message     : this.pnlPrintTimecardOptions + " Panel does not Exist." } 
              
                          
    objButton = this.pnlPrintTimecardOptions.WaitWinFormsObject("ScreenButton", "ALL EMPLOYEES", 2000);
    
    if(objButton.Exists){
      objButton.SetFocus();
      objButton.ClickButton();   
      bButtonClicked = true;
    }
    
    return bButtonClicked;
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at printTimecardOptionsPanel.ClickPrintTimecardOptions");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickAllEmployess


function New() {

/*----------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating printTimecardOptionsPanel() class from other units of the project. 
-----------------------------------------------------------------------------------*/

  return new printTimecardOptionsPanel();  
}