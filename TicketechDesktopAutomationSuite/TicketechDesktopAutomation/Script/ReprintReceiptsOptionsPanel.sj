//USEUNIT Utility

/**************************************************************************
            ---------- Class Definition ----------
  Name:ReprintReceiptsOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the ReprintReceiptsOptions Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function reprintReceiptsOptionsPanel() { 

/*--------------------------------------------------------------------------- 
  Method: reprintReceiptsOptionsPanel() 
  
  Description: This method will the Instantiate the ReprintReceiptsOptionsPanel Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlReprintReceiptsOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelReprintReceiptsOptions", 2);
  this.throwError = false; 
    
} //reprintReceiptsOptionsPanel

reprintReceiptsOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reprintReceiptsOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlReprintReceiptsOptions.Exists;  //Return whether reprintReceiptsOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reprintReceiptsOptionsPanel.prototype.ClickPrintReceipt = function () {  

/*-----------------------------------------------------------------
  Method      : ClickPrintReceipt()
  
  Description : This method Clicks the PrintReceipt button  
  
  Output      : Click on PrintReceipts button if ReprintReceiptsOptions Panel Exists
-----------------------------------------------------------------*/  
this.Click("PRINT RECEIPT");      
} //ClickPrintReceipt

reprintReceiptsOptionsPanel.prototype.ClickAllReceipts = function () {  

/*-----------------------------------------------------------------
  Method      : ClickAllReceipts()
  
  Description : This method Clicks the AllReceipts button  
  
  Output      : Click on AllReceipts button if ReprintReceiptsOptions Panel Exists
-----------------------------------------------------------------*/  
 this.Click("ALL RECEIPTS");      
} //ClickAllReceipts

reprintReceiptsOptionsPanel.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click(btnName)
  
  Description : This method Clicks the required button given as the parameter  
  
  Output      : Click on the required button if ReprintReceiptsOptions Panel Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOptionsPanel.Click"+btnName+": The ReprintReceiptsOptions Panel does not Exist.",
              message     : this.pnlReprintReceiptsOptions + " Panel does not Exist." }             
    
    aqUtils.Delay(1000);
    this.pnlReprintReceiptsOptions.FindChild(["WndCaption","Visible"], [btnName,true],2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating reprintReceiptsOptionsPanel() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reprintReceiptsOptionsPanel();  
}