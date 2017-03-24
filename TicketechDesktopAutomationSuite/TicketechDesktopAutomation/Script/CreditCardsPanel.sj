//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------

  Name:CreditCardsPanel
  
  Description: 
  
  This class has methods and properties to perform the CreditCards Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************/

function creditCardsPanel() { 

/*--------------------------------------------------------------------------------------------- 
  Method: creditCardsPanel() 
  
  Description: This method will the Instantiate the CreditCards Panel Wrapper Helper
---------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlCreditCards =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelCreditCards", 3);
  this.throwError = false; 
    
} //creditCardsPanel

creditCardsPanel.prototype.Exists = function () {  

/*---------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the creditCardsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlCreditCards.Exists;  //Return whether CreditCardsPanel exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at creditCardsPanel.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


creditCardsPanel.prototype.ClickCreditCardType = function (iCardIndex) {  

/*------------------------------------------------------------------------------
  Method      : ClickCreditCardType()
  
  Description : This method Clicks the CreditCardType  
  
  Output      : Click on the CreditCardType if CreditCards Panel Exists
------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at CreditCardsPanel.ClickCreditCardType: The CreditCards Panel does not Exist.",
              message     : this.pnlCreditCards + " Panel does not Exist." }             
    
    Delay(1000);
    this.pnlCreditCards.FindChild(["Index","Enabled"],[iCardIndex, true],1).Keys("[Enter]");   
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at creditCardsPanel.ClickCreditCardType");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*---------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating creditCardsPanel() class from other units of the project. 
-----------------------------------------------------------------------------------------------------*/

  return new creditCardsPanel();  
}