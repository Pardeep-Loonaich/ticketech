//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT TicketNumberScreen
//USEUNIT ReprintReceiptsOptionsPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:ReprintReceiptsTicketNumbeForm
  
  Description: 
  
  This class has methods and properties to perform the ReprintReceiptsTicketNumberForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function reprintReceiptsTicketNumberForm() { 

/*-------------------------------------------------------------------------- 
  Method: reprintReceiptsTicketNumberForm() 
  
  Description: This method will the Instantiate the reprintReceiptsTicketNumberForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgReprintReceiptsTicketNumber =  Sys.Process("PosApplication").WaitWinFormsObject("FormReprintReceiptsTicketNumber", 3000); 
  
  this.objInfoScreen        = InformationScreen.New();
  this.objTicketNumberScreen = TicketNumberScreen.New();
  this.objNavigationPanel   = NavigationPanel.New();
  this.objNumericPanel      = NumericPanel.New();
  this.objReprintReceiptsOptionsPanel = ReprintReceiptsOptionsPanel.New();
  
  this.throwError = false; 
    
} //reprintReceiptsTicketNumberForm

reprintReceiptsTicketNumberForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the reprintReceiptsTicketNumberForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgReprintReceiptsTicketNumber =  Sys.Process("PosApplication").WaitWinFormsObject("FormReprintReceiptsTicketNumber", 3000); 
  
    this.objInfoScreen         = InformationScreen.New();
    this.objTicketNumberScreen = TicketNumberScreen.New();
    this.objNavigationPanel    = NavigationPanel.New();
    this.objNumericPanel       = NumericPanel.New();
    this.objReprintReceiptsOptionsPanel = ReprintReceiptsOptionsPanel.New();
  
   } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

reprintReceiptsTicketNumberForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reprintReceiptsTicketNumberForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgReprintReceiptsTicketNumber.Exists;  //Return whether reprintReceiptsTicketNumberForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reprintReceiptsTicketNumberForm.prototype.InputTicketNumberAndSubmit = function (sTicketNumber) {  

/*--------------------------------------------------------------------------
  Method      : InputTicketNumberAndSubmit()
  
  Description : This method enters Ticket Number  
  
  Output      : Enters Ticket Number if ReprintReceiptsTicketNumber Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsTicketNumberForm.InputTicketNumberAndSubmit: The ReprintReceiptsTicketNumber Form does not Exist.",
              message     : this.dlgReprintReceiptsTicketNumber + " The ReprintReceiptsTicketNumber Form does not Exist." }             
    
    //Enters ticketNumber in ticketNumber field
    this.objTicketNumberScreen.EnterTicketNumber(sTicketNumber);
    Delay(1000);
    
    //for ticket number length = 6, it will automatically Print; for ticket number < 6, ClickEnter is required
    if(sTicketNumber.length < 6){
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
    }
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputTicketNumberAndSubmit

reprintReceiptsTicketNumberForm.prototype.InputTicketNumberAndSubmitWithErrors = function (sTicketNumber) {  

/*--------------------------------------------------------------------------
  Method      : InputTicketNumberAndSubmitWithErrors()
  
  Description : This method enters Ticket Number
  
  Output      : Enters Ticket Number in ReprintReceiptsTicketNumber Form and click enter button
--------------------------------------------------------------------------*/  
  try {
  
    this.InputTicketNumberAndSubmit(sTicketNumber);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.objTicketNumberScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputTicketNumberAndSubmitWithErrors

reprintReceiptsTicketNumberForm.prototype.PrintByPrintReceipt = function (sTicketNumber) {  

/*------------------------------------------------------------------------------------
  Method      : PrintByPrintReceipt()
  
  Description : This method Clicks Print Receipts button  
  
  Output      : Clicks Print Receipts button if reprintReceiptsTicketNumberForm Exists
------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reprintReceiptsTicketNumberForm.PrintByPrintReceipt: The reprintReceiptsTicketNumberForm does not Exist.",
              message     : this.dlgReprintReceiptsTicketNumber + " The reprintReceiptsTicketNumberForm does not Exist." }             
    
    if (sTicketNumber == null || sTicketNumber == undefined){
      sTicketNumber = this.objTicketNumberScreen.GetTicketNumberInTextBox();
      
      if (sTicketNumber != null && sTicketNumber.length > 0) {
        this.objReprintReceiptsOptionsPanel.ClickPrintReceipt(); 
        Delay(2000);
        return SQLQueries.validateTicketNumber(sTicketNumber)?  1 : -1;
      } 
    }
    else {
       this.objTicketNumberScreen.EnterTicketNumber(sTicketNumber);
       Delay(1000);
       
       if(sTicketNumber.length < 6){
        this.objReprintReceiptsOptionsPanel.ClickPrintReceipt();
        Delay(2000);
       }
       return this.objTicketNumberScreen.GetErrorMessage();
    } 
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //PrintByPrintReceipt

reprintReceiptsTicketNumberForm.prototype.SelectAllReceipts = function () {  

/*----------------------------------------------------------------------------------
  Method      : SelectAllReceipts()
  
  Description : This method Clicks All Receipts button  
  
  Output      : Clicks All Receipts button if reprintReceiptsTicketNumberForm Exists
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reprintReceiptsTicketNumberForm.SelectAllReceipts: The reprintReceiptsTicketNumberForm does not Exist.",
              message     : this.dlgReprintReceiptsTicketNumber + " The reprintReceiptsTicketNumberForm does not Exist." }             
    
    this.objReprintReceiptsOptionsPanel.ClickAllReceipts();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectAllReceipts

reprintReceiptsTicketNumberForm.prototype.PrintByEnter = function () {  

/*----------------------------------------------------------------------------
  Method      : PrintByEnter()
  
  Description : This method clicks Enter button  
  
  Output      : Clicks Enter button if ReprintReceiptsTicketNumber Form Exists
----------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if(!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsTicketNumberForm.PrintByEnter: The ReprintReceiptsTicketNumber Form does not Exist.",
              message     : this.dlgReprintReceiptsTicketNumber + " The ReprintReceiptsTicketNumber Form does not Exist." }             
    
    sTicketNumber = this.objTicketNumberScreen.GetTicketNumberInTextBox();
    
    if(sTicketNumber != null && sTicketNumber.length > 0) {
      this.objNavigationPanel.ClickEnter();
      Delay(2000);
      return SQLQueries.validateTicketNumber(sTicketNumber) ? 1 : -1;
    }
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //PrintByEnter

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating reprintReceiptsTicketNumberForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reprintReceiptsTicketNumberForm();  
}

