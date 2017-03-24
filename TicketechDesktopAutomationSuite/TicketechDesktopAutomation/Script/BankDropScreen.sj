//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:BankDropScreen
  
  Description: 
  
  This class has methods and properties to perform the BankDropScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function bankDropScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: bankDropScreen() 
  
  Description: This method will the Instantiate the BankDropScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnBankDrop =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenBankDrop", 3);
  
  this.throwError = false; 
    
} //bankDropScreen

bankDropScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the bankDropScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnBankDrop.Exists;  //Return whether bankDropScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at bankDropScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

bankDropScreen.prototype.SetBagNumber = function (sBag) {  

/*-------------------------------------------------------------------------------
  Method      : SetBagNumber()
  
  Description : This method enters the Bag Number in the Bank Drop screen
  
  Output      : Enters the Bag Number in the Bank Drop screen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at bankDropScreen.SetBagNumber: The Bank Drop screen does not Exist.",
              message     : this.scrnBankDrop + " Screen does not Exist." }             
    
    if (sBag !== undefined && sBag !== null)
      this.scrnBankDrop.FindChild("Caption", "BAG #",3).FindChild("WinFormsControlName","maskedTextBoxInfo",1).Keys(sBag);
      
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Error in bankDropScreen.SetBagNumber");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetBagNumber

bankDropScreen.prototype.GetBagNumber = function (sBag) {  

/*-------------------------------------------------------------------------------
  Method      : GetBagNumber()
  
  Description : This method gets the Bag Number in the Bank Drop screen
  
  Output      : Gets the Bag Number in the Bank Drop screen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at bankDropScreen.GetBagNumber: The Bank Drop screen does not Exist.",
              message     : this.scrnBankDrop + " Screen does not Exist." }             
    
  
    return  this.scrnBankDrop.FindChild("Caption", "BAG #",3).FindChild("WinFormsControlName","maskedTextBoxInfo",1).wText;
      
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Error in bankDropScreen.GetBagNumber");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetBagNumber

bankDropScreen.prototype.SetAmount = function (iAmount) {  

/*-------------------------------------------------------------------------------
  Method      : SetAmount()
  
  Description : This method enters  Amount
  
  Output      : Enters the Amount in the Bank Drop screen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at bankDropScreen.SetAmount: The Bank Drop screen does not Exist.",
              message     : this.scrnBankDrop + " Screen does not Exist." }             
    
     if (iAmount !== undefined && iAmount !== null)
     this.scrnBankDrop.FindChild("Caption", "AMOUNT",3).FindChild("WinFormsControlName","maskedTextBoxInfo",1).Keys(iAmount);
      
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Error in bankDropScreen.SetPassowrd");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPassword

bankDropScreen.prototype.GetMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetMessage()
  
  Description : This method returns the message displayed in the user identification screen 
  
  Output      : Returns the the message displayed in the user identification screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at BankDropScreen.GetMessage: The bankDrop screen does not Exist.",
              message     : this.scrnBankDrop + " Info does not Exist." }   
              
    objMessage = this.scrnBankDrop.WinFormsObject("screenInformationFooter").WinFormsObject("labelInformation");          

    return objMessage.WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating bankDropScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new bankDropScreen();  
}


bankDropScreen.prototype.CheckGivenBagInFirstRow = function(sBagNumber){
/*------------------------------------------------------------------------------------
  Method      : CheckGivenBagInFirstRow()
  
  Description : This method Checks the given Bag is available in the first row
  
  Output      : returns true if the Given Bag is found in Grid first row
------------------------------------------------------------------------------------*/ 
  try {
    
    bBagAvailable = false;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at bankDropScreen.CheckGivenBagInFirstRow: The bankDropScreen does not Exist.",
              message     : this.scrnBankDrop + " Screen does not Exist." }  
    
    objGrid = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 5);
    
    if(objGrid.wRowCount > 0){
      if(objGrid.wValue(0,0).Equals(sBagNumber))
        bBagAvailable = true;
    }

    return bBagAvailable; 
  }
  
  catch(exception) {
    TestLog.Message("Error in CheckGivenBagInFirstRow method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
  }
}
