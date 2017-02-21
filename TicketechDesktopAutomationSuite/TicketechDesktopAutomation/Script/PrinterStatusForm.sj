//USEUNIT Utility



/*************************************************************************
            ---------- Class Definition ----------
  Name:PrinterStatusForm
  
  Description: 
  
  This class has methods and properties to perform the PrinterStatusForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function printerStatusForm() { 

/*--------------------------------------------------------------------- 
  Method: printerStatusForm() 
  
  Description: This method will Instantiate the printerStatusForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgPrinterStatusForm =  Sys.Process("PosApplication").WaitWinFormsObject("frmAutorecoverBocaStatus", 3000); 
  
  this.throwError = false; 
    
} //printerStatusForm


printerStatusForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the printerStatusForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgPrinterStatusForm.Exists;  //Return whether printerStatusForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

printerStatusForm.prototype.ClickRetry = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickRetry()
  
  Description : This method Clicks Retry button  
  
  Output      : Clicks Retry button if printerStatusForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at printerStatusForm.ClickRetry: The printerStatusForm does not Exist.",
              message     : this.dlgPrinterStatusForm + " The printerStatusForm does not Exist." }             
    
    this.dlgPrinterStatusForm.WaitWinFormsObject("btnRetry", 3000).ClickButton();
    Delay(3000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickRetry

printerStatusForm.prototype.ClickCancel = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickCancel()
  
  Description : This method Clicks Cancel button  
  
  Output      : Clicks Cancel button if printerStatusForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at printerStatusForm.ClickCancel: The printerStatusForm does not Exist.",
              message     : this.dlgPrinterStatusForm + " The printerStatusForm does not Exist." }             
    
    this.dlgPrinterStatusForm.WaitWinFormsObject("btnCancel", 3000).ClickButton();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickCancel

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating printerStatusForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new printerStatusForm();  
}